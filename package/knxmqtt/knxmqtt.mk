

################################################################################
#
# inputevent
#
################################################################################

KNXMQTT_VERSION = dc270fdf9405c77e39e94a601ae4b8018cf81206
KNXMQTT_SITE = https://github.com/kurt-vd/knxmqtt.git
KNXMQTT_SITE_METHOD = git
KNXMQTT_LICENSE = GPLv3
KNXMQTT_LICENSE_FILES = COPYING

define KNXMQTT_CONFIGURE_CMDS
	echo "PREFIX=/usr" > $(@D)/config.mk
	echo "CFLAGS=$(TARGET_CFLAGS)" >> $(@D)/config.mk
	echo "CPPFLAGS=-D_GNU_SOURCE $(TARGET_CPPFLAGS)" >> $(@D)/config.mk
	echo "CXXFLAGS=$(TARGET_CXXFLAGS)" >> $(@D)/config.mk
	echo "LDFLAGS=$(TARGET_LDFLAGS)" >> $(@D)/config.mk
	echo "LDLIBS+=$(TARGET_LDLIBS) -lm" >> $(@D)/config.mk
	echo "CC=$(TARGET_CC)" >> $(@D)/config.mk
	echo "CXX=$(TARGET_CXX)" >> $(@D)/config.mk
	echo "LD=$(TARGET_LD)" >> $(@D)/config.mk
	echo "AS=$(TARGET_AS)" >> $(@D)/config.mk

	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) clean
endef

define KNXMQTT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define KNXMQTT_INSTALL_TARGET_CMDS
	$(INSTALL) -vp -m 0777 $(@D)/mqttnxd $(TARGET_DIR)/usr/bin/mqttnxd
	$(INSTALL) -vp -m 0777 $(@D)/eibtimeoff $(TARGET_DIR)/usr/bin/eibtimeoff
	$(INSTALL) -vp -m 0777 $(@D)/eibgtrace $(TARGET_DIR)/usr/bin/eibgtrace
	$(INSTALL) -vp -m 0777 $(@D)/mqttoff $(TARGET_DIR)/usr/bin/mqttoff
endef

$(eval $(generic-package))
