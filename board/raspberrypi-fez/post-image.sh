#!/usr/bin/env bash

BOARD_DIR="$(dirname $0)"
GENIMAGE_CFG="${BOARD_DIR}/genimage-raspberrypi3.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Adjust the cmdline.txt
cp "${BOARD_DIR}/cmdline.txt" "${BINARIES_DIR}/rpi-firmware"

# Adjust the config.txt
cp "${BOARD_DIR}/config.txt" "${BINARIES_DIR}/rpi-firmware"

# Compile and copy additional DTS
mkdir -p ${BINARIES_DIR}/rpi-firmware/overlays

# copy the standard overlays
cp ${BUILD_DIR}/rpi-firmware-*/boot/overlays/*.dtbo ${BINARIES_DIR}/rpi-firmware/overlays/

# compile and copy self-defined overlays
DTC=`ls ${BUILD_DIR}/linux-*/scripts/dtc/dtc | head -n1`
if ! [ -x $DTC ]; then
	DTC=dtc
else
	echo "Using $DTC"
fi

for DTS in ${BOARD_DIR}/*-overlay.dts; do
	DTSNAME=`basename ${DTS%%-overlay.dts}`
	echo "Compile $DTSNAME"
	$DTC -@ -O dtb $DTS -o ${BINARIES_DIR}/rpi-firmware/overlays/${DTSNAME}.dtbo
	echo "dtoverlay=${DTSNAME}" >> ${BINARIES_DIR}/rpi-firmware/config.txt
done

echo "generate image"
# generate image
rm -rf "${GENIMAGE_TMP}"

genimage \
  --rootpath "${TARGET_DIR}" \
  --tmppath "${GENIMAGE_TMP}" \
  --inputpath "${BINARIES_DIR}" \
  --outputpath "${BINARIES_DIR}" \
  --config "${GENIMAGE_CFG}"

#generate swupdate image
PRODUCT_NAME="rpi-fez"

mv ${BINARIES_DIR}/sdcard.img ${BINARIES_DIR}/${PRODUCT_NAME}_${VERSION}.img

exit $?


# case "${2}" in
# 	--add-pi3-miniuart-bt-overlay)
# 	if ! grep -qE '^dtoverlay=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
# 		echo "Adding 'dtoverlay=pi3-miniuart-bt' to config.txt (fixes ttyAMA0 serial console)."
# 		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"
#
# # fixes rpi3 ttyAMA0 serial console
# dtoverlay=pi3-miniuart-bt
# __EOF__
# 	fi
# 	;;
# 	--aarch64)
# 	# Run a 64bits kernel (armv8)
# 	sed -e '/^kernel=/s,=.*,=Image,' -i "${BINARIES_DIR}/rpi-firmware/config.txt"
# 	if ! grep -qE '^arm_control=0x200' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
# 		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"
#
# # enable 64bits support
# arm_control=0x200
# __EOF__
# 	fi
#
# 	# Enable uart console
# 	if ! grep -qE '^enable_uart=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
# 		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"
#
# # enable rpi3 ttyS0 serial console
# enable_uart=1
# __EOF__
# 	fi
# 	;;
# esac
