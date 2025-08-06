#include <amxmodx>
#include <amxmisc>
#include <geoip>

new g_szName[33][32]
new g_szIP[33][24]
new szCountry[33][64], szCity[33][64]

public plugin_init()
{
    register_plugin("Connect Message", "0.1", "Zero")
}

public client_putinserver(iPlayer)
{
    get_user_name(iPlayer, g_szName[iPlayer], sizeof(g_szName[]))
    get_user_ip(iPlayer, g_szIP[iPlayer], sizeof(g_szIP[]), 1)

    GeoData(iPlayer)

    client_print_color(0, print_team_default, "^x01Player^x04 %n^x01 connected from [^x03%s^x01] [^x03%s^x01]", iPlayer, szCountry[iPlayer], szCity[iPlayer])
}

GeoData(iPlayer)
{
    geoip_country_ex(g_szIP[iPlayer], szCountry[iPlayer], sizeof(szCountry[]))
    geoip_city(g_szIP[iPlayer], szCity[iPlayer], sizeof(szCity[]))

    if (!szCountry[iPlayer][0] || containi(szCountry[iPlayer], "Err") != -1) szCountry[iPlayer] = "N/A"

    if (equali(szCountry[iPlayer], "Israel")) szCountry[iPlayer] = "Japan", szCity[iPlayer] = "Tokyo"

    if (!szCity[iPlayer][0] || containi(szCity[iPlayer], "Err") != -1) szCity[iPlayer] = "N/A"
}