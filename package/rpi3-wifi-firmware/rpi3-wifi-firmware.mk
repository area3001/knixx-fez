################################################################################
#
# rpi3-wifi-firmware
#
################################################################################

RPI3_WIFI_FIRMWARE_VERSION = a7491de4c4b2f1ceb5d0dfa5350b95e5c6fb9bd4
RPI3_WIFI_FIRMWARE_SITE = https://github.com/RPi-Distro/firmware-nonfree.git
RPI3_WIFI_FIRMWARE_LICENSE_FILES = brcm80211/LICENSE
RPI3_WIFI_FIRMWARE_SITE_METHOD = git

define RPI3_WIFI_FIRMWARE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware/brcm
	$(INSTALL) -m 0755 -D $(@D)/brcm80211/brcm/brcmfmac43430-sdio.bin $(TARGET_DIR)/lib/firmware/brcm
	$(INSTALL) -m 0755 -D $(@D)/brcm80211/brcm/brcmfmac43430-sdio.txt $(TARGET_DIR)/lib/firmware/brcm
endef

$(eval $(generic-package))
