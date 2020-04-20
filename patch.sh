#/bin/bash
#=================================================
# Description: OpenWrt DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# Modify hostname
sed -i 's/OpenWrt/XY-C3/g' package/base-files/files/bin/config_generate

# Modify model
cat ../xy-c3.mk >> target/linux/ramips/image/mt7621.mk
cp -f ../mt7621_xiaoyu_xy-c3.dts target/linux/ramips/dts/
sed -i 's/xy-c5/xy-c3/g' target/linux/ramips/mt7621/base-files/etc/board.d/02_network

# Modify the version number
# sed -i "s/OpenWrt /wolfyu build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
sed -i "s/OpenWrt /wolfyu build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/default-settings/files/zzz-default-settings

# Modify default theme
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="wolfyu"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"wolfyu"@' .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config
    
echo '修改banner'
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/

# add ssr plus+
# git clone https://github.com/fw876/helloworld.git package/helloworld
# add OpenAppFilter
# git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# add serverchan
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
# add luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon
