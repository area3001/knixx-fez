include $(sort $(wildcard $(BR2_EXTERNAL_KNIXX_BUILDROOT_PATH)/package/*/*.mk))

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

img=$(shell ls -t $(BINARIES_DIR)/*.img | head -n1)
flash-rpi: guard-DRIVE
	@for PARTITION in 1 2 3; do \
		if [ -b $(DRIVE)$${PARTITION} ]; then \
			echo unmounting $(DRIVE)$${PARTITION}; \
			umount $(DRIVE)$${PARTITION} || /bin/true; \
		fi; \
		if [ -b $(DRIVE)p$${PARTITION} ]; then \
			echo unmounting $(DRIVE)p$${PARTITION}; \
			umount $(DRIVE)p$${PARTITION} || /bin/true; \
		fi; \
	done

	@if [ -b $(DRIVE) ]; then \
		echo Writing $(img) to sd card $(DRIVE); \
		sudo dd if=$(img) of=$(DRIVE); \
	else \
		echo "$(DRIVE) is not a block device"; \
		exit 1; \
	fi
