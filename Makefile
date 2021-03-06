#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=snort3
PKG_VERSION:=3.0.0-beta
PKG_VERSION_SHORT:=3.0.0
PKG_RELEASE:=4

PKG_SOURCE:=snort-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.snort.org/downloads/snortplus/
PKG_HASH:=ea4079c551002e4d83586f05b3ecdae72706a46ec223339b87ce60f7ae30b8a2
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/snort-$(PKG_VERSION_SHORT)

PKG_MAINTAINER:=W. Michael Petullo <mike@flyn.org>
PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:snort:snort

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/snort3
  SUBMENU:=Firewall
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libstdcpp +libdaq +libdnet +libopenssl +libpcap +libpcre +libpthread +libuuid +zlib +libhwloc +libtirpc +luajit
  TITLE:=Lightweight Network Intrusion Detection System
  URL:=http://www.snort.org/
  MENU:=1
endef

define Package/snort3/description
  Snort is an open source network intrusion detection and prevention system.
  It is capable of performing real-time traffic analysis, alerting, blocking
  and packet logging on IP networks.  It utilizes a combination of protocol
  analysis and pattern matching in order to detect anomalies, misuse and
  attacks.
endef

CMAKE_OPTIONS += \
	-DENABLE_STATIC_DAQ:BOOL=NO \
	-DENABLE_COREFILES:BOOL=NO \
	-DENABLE_GDB:BOOL=NO \
	-DMAKE_DOC:BOOL=NO \
	-DMAKE_HTML_DOC:BOOL=NO \
	-DMAKE_PDF_DOC:BOOL=NO \
	-DMAKE_TEXT_DOC:BOOL=NO \
	-DHAVE_LZMA=OFF

TARGET_CFLAGS  += -I$(STAGING_DIR)/opt/include/tirpc
TARGET_LDFLAGS += -ltirpc

define Package/snort3/conffiles
/opt/etc/config/snort
endef

define Package/snort3/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/snort  \
		$(1)/opt/bin/

	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/bin/u2{boat,spewfoo} \
		$(1)/opt/bin/

	$(INSTALL_DIR) $(1)/opt/lib/snort
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/snort/daqs/daq_hext.so \
		$(1)/opt/lib/snort/

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/lib/snort/daqs/daq_file.so \
		$(1)/opt/lib/snort/

	$(INSTALL_DIR) $(1)/opt/share/lua
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/snort/lua/snort_plugin.lua \
		$(1)/opt/share/lua/

	$(CP) \
		$(PKG_INSTALL_DIR)/opt/include/snort/lua/snort_config.lua \
		$(1)/opt/share/lua/

	$(INSTALL_DIR) $(1)/opt/etc/snort

	$(INSTALL_CONF) \
		$(PKG_INSTALL_DIR)/opt/etc/snort/*.lua \
		$(1)/opt/etc/snort/

	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) \
		./files/snort.init \
		$(1)/opt/etc/init.d/snort

	$(INSTALL_DIR) $(1)/opt/etc/config
	$(INSTALL_CONF) \
		./files/snort.config \
		$(1)/opt/etc/config/snort
endef

$(eval $(call BuildPackage,snort3))
