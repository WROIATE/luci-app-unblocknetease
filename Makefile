
# Copyright (C) 2022 WROIATE
include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for UnblockNetease Golang
LUCI_DEPENDS:= +bash +busybox +unzip +coreutils +coreutils-nohup +curl +dnsmasq-full +ipset +luci-compat +openssl-util +UnblockNeteaseGo +knot-host
LUCI_PKGARCH:=all
PKG_NAME:=luci-app-unblocknetease
PKG_VERSION:=1.1
PKG_RELEASE:=1

define Package/$(PKG_NAME)/conffiles
/etc/config/UnblockNetease
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature