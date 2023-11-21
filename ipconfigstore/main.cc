#define LOG_TAG "ipconfigstore"
#define LOG_NDEBUG 0

#include <sys/types.h>
#include <ifaddrs.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <string.h>
#include <net/route.h>
#include <unistd.h>
#include <stdio.h>
#include <arpa/inet.h>
#include <regex>
#include <set>
#include <dirent.h>

#include <android-base/properties.h>
#include <android-base/logging.h>
#include "data.h"
#include <log/log.h>
#include <cutils/properties.h>
using namespace android::base;

struct ipconfig {
    char ifa_name[24];
    uint32_t mask;
    char ipv4[16];
    char gateway[16];
};

static int get_gateway(char *dev, char *gateway) {
    FILE *fp;
    char buf[256]; // 128 is enough for linux
    char iface[16];
    int ret = -1;
    unsigned long dest_addr, gate_addr;
    fp = fopen("/proc/net/route", "r");
    if (fp == NULL) return -1;
    /* Skip title line */
    fgets(buf, sizeof(buf), fp);
    while (fgets(buf, sizeof(buf), fp)) {
        if (sscanf(buf, "%s\t%lX\t%lX", iface, &dest_addr, &gate_addr) != 3 || dest_addr != 0 || strcmp(dev, iface)) continue;
        inet_ntop(AF_INET, &gate_addr, gateway, INET_ADDRSTRLEN);
        ret = 0;
        break;
    }

    fclose(fp);
    return ret;
}

static int bitcount(uint32_t n)
{
    int count = 0;
    while (n) {
        count++;
        n &= (n - 1);
    }
    return count;
}

static int get_conf(std::vector<struct ipconfig> &conf) {
    struct ifaddrs *ifAddrStruct = NULL;
    struct ifaddrs *ifAddrStructHead = NULL;
    void *tmpAddrPtr = NULL;
    int ret = -1;
    getifaddrs(&ifAddrStruct);
    if (ifAddrStruct != NULL) {
        ifAddrStructHead = ifAddrStruct;
    }

    while (ifAddrStruct != NULL) {
        struct ipconfig tmpconf;
        if ((GetIntProperty("persist.fde.e", 0) || !strncmp(ifAddrStruct->ifa_name, "en", 2)
             || !strncmp(ifAddrStruct->ifa_name, "wl", 2)
             || !strncmp(ifAddrStruct->ifa_name, "usb", 3))
             && ifAddrStruct->ifa_addr && (ifAddrStruct->ifa_addr->sa_family == AF_INET)
             && (get_gateway(ifAddrStruct->ifa_name, tmpconf.gateway) == 0)) {
            tmpAddrPtr =& ((struct sockaddr_in *)ifAddrStruct->ifa_addr)->sin_addr;
            inet_ntop(AF_INET, tmpAddrPtr, tmpconf.ipv4, INET_ADDRSTRLEN);
            tmpconf.mask = bitcount(((struct sockaddr_in *)ifAddrStruct->ifa_netmask)->sin_addr.s_addr);
            strcpy(tmpconf.ifa_name, ifAddrStruct->ifa_name);
            conf.push_back(tmpconf);
            ret = 0;
        }
        ifAddrStruct = ifAddrStruct->ifa_next;
    }

    if (ifAddrStructHead != NULL) {
        freeifaddrs(ifAddrStruct);
    }
    return ret;
}

static void write_dns(FILE *fp) {
    std::set<std::string> dnsList;
    auto ndns = GetIntProperty("ro.boot.fde_net_ndns", 0);
    for (int i = 1; i <= ndns; ++i) {
        dnsList.insert(GetProperty("ro.boot.fde_net_dns" + std::to_string(i), ""));
    }
    if (dnsList.empty()) dnsList.insert("114.114.114.114");

    for (auto& dns: dnsList) {
        writePackedString("dns", fp);
        writePackedString(dns.c_str(), fp);
    }
}

static void write_proxy(FILE *fp) {
    // static | pac | none | unassigned
    std::string proxy_type = GetProperty("ro.boot.fde_net_proxy_type", "");
    if ("static" == proxy_type) {
        writePackedString("proxySettings", fp);
        writePackedString("STATIC", fp);

        writePackedString("proxyHost", fp);
        writePackedString(GetProperty("ro.boot.fde_net_proxy_host", "").c_str(), fp);

        writePackedString("proxyPort", fp);
        writePackedUInt32(GetIntProperty("ro.boot.fde_net_proxy_port", 3128), fp);

        writePackedString("exclusionList", fp);
        writePackedString(GetProperty("ro.boot.fde_net_proxy_exclude_list", "").c_str(), fp);
    } else if ("pac" == proxy_type) {
        writePackedString("proxySettings", fp);
        writePackedString("PAC", fp);

        writePackedString("proxyPac", fp);
        writePackedString(GetProperty("ro.boot.fde_net_proxy_pac", "").c_str(), fp);
    } else if ("none" == proxy_type) {
        writePackedString("proxySettings", fp);
        writePackedString("NONE", fp);
    } else {
        // ignored
    }
}

static int write_conf(std::vector<struct ipconfig> &conf) {
    FILE *fp = fopen("/data/misc/ethernet/ipconfig.txt", "w+");

    writePackedUInt32(3, fp); // version
    for (auto i : conf) {
        writePackedString("ipAssignment", fp);
        writePackedString("STATIC", fp);

        writePackedString("linkAddress", fp);
        writePackedString(i.ipv4, fp);
        writePackedUInt32(i.mask, fp);

        writePackedString("gateway", fp);
        writePackedUInt32(1, fp); // Default route (dest).
        writePackedString("0.0.0.0", fp);
        writePackedUInt32(0, fp);
        writePackedUInt32(1, fp); // Have a gateway.
        writePackedString(i.gateway, fp);

        write_dns(fp);

        write_proxy(fp);

        writePackedString("id", fp);
        writePackedString(i.ifa_name, fp);

        writePackedString("eos", fp);
    }


    fclose(fp);
    return 0;
}

static void write_wifi_interface(void) {
    DIR* d = opendir("/sys/class/net");
    if (d == nullptr) {
        return;
    }

    dirent* e;
    while ((e = readdir(d)) != nullptr) {
        if (strncmp("wl", e->d_name, 2) == 0) {
            SetProperty("wifi.interface", e->d_name);
            SetProperty("fde.fake_wifi_mac", "0");
            break;
        }
    }

    closedir(d);
}

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;
    write_wifi_interface();
    std::vector<struct ipconfig> conf;
    if (get_conf(conf) == 0) {
        return write_conf(conf);
    }
    ALOGE("ipconfig fail");
    return 0;
}

