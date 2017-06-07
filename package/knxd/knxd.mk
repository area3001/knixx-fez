################################################################################
#
# knxd
#
################################################################################

KNXD_VERSION = v0.12.10
KNXD_SITE = https://github.com/knxd/knxd
KNXD_SITE_METHOD = git
KNXD_LICENSE = GPLv2+
KNXD_LICENSE_FILES = LICENSE

KNXD_AUTORECONF = YES
KNXD_INSTALL_STAGING = YES
KNXD_INSTALL_TARGET = YES
KNXD_CONF_OPTS = --disable-systemd \
        --enable-eibnetip \
        --enable-eibnetiptunnel \
        --enable-eibnetipserver \
        --enable-groupcache \
        --enable-ncn5120

KNXD_DEPENDENCIES = libev libusb

$(eval $(autotools-package))
