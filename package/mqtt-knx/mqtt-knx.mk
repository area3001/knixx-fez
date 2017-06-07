################################################################################
#
# mqtt-knx
#
################################################################################

MQTT_KNX_VERSION = e92777465cd6f4992ba7fea86f38ba2f9042cbbb
MQTT_KNX_SITE = https://github.com/krambox/mqtt-knx.git
MQTT_KNX_SITE_METHOD = git
MQTT_KNX_LICENSE = GPL
MQTT_KNX_LICENSE_FILES = LICENSE
MQTT_KNX_INSTALL_STAGING = NO
MQTT_KNX_INSTALL_TARGET = YES

define MQTT_KNX_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/local/mqtt-knx
	cp -R $(@D)/* $(TARGET_DIR)/usr/local/mqtt-knx
	cd $(TARGET_DIR)/usr/local/mqtt-knx; $(NPM) install --production
endef

$(eval $(generic-package))
