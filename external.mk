include $(sort $(wildcard $(BR2_EXTERNAL_KNIXX_BUILDROOT_BUILDROOT_PATH)/package/*/*.mk))

flash-rpi:
	@if ! test $(DRIVE); then \
		echo "No drive specified. Please specify you SD card using DRIVE=<your sd card device>"; \
		exit 1; \
	fi

	@for PARTITION in 1 2; do \
		if [ -b $(DRIVE)$${PARTITION} ]; then \
			echo unmounting $(DRIVE)$${PARTITION}; \
			umount $(DRIVE)$${PARTITION}; \
		fi; \
	done

	@if [ -b $(DRIVE) ]; then \
		echo Writing $(img) to sd card $(DRIVE); \
		sudo dd if=$(img) of=$(DRIVE); \
	else \
		echo "$(DRIVE) is not a block device"; \
		exit 1; \
	fi
