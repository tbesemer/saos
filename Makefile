export OS_CONTAINER_ROOT := $(shell pwd)
include ${OS_CONTAINER_ROOT}/config/machine.mk
export OS_KERNEL_CONTAINER_ROOT := ${OS_CONTAINER_ROOT}/saos_kernel
export OS_YOCTO_CONTAINER_ROOT := ${OS_CONTAINER_ROOT}/saos_yocto

export OS_ENV_FILE := /opt/poky/2.2.4/environment-setup-cortexa9hf-neon-poky-linux-gnueabi

.PHONY: saos_build_yocto
saos_build_yocto:
	make -C ${OS_YOCTO_CONTAINER_ROOT}
	cp -p ${OS_YOCTO_CONTAINER_ROOT}/deploy/saos-rootfs.cpio.gz ${OS_CONTAINER_ROOT}/deploy/

.PHONY: saos_build_kernel
saos_build_kernel: saos_chk_env_file
	@ . ${OS_ENV_FILE} && make -C ${OS_KERNEL_CONTAINER_ROOT}
	cp -p ${OS_KERNEL_CONTAINER_ROOT}/deploy/zImage ${OS_CONTAINER_ROOT}/deploy/
	cp -p ${OS_KERNEL_CONTAINER_ROOT}/deploy/zImage.dtb ${OS_CONTAINER_ROOT}/deploy/

.PHONY: saos_clean_kernel
saos_clean_kernel: saos_chk_env_file
	@ . ${OS_ENV_FILE} && make -C ${OS_KERNEL_CONTAINER_ROOT} kernel_standard_mrproper
	@ . ${OS_ENV_FILE} && make -C ${OS_KERNEL_CONTAINER_ROOT} kernel_deploy_clean

.PHONY: saos_build_itb
saos_build_itb: saos_build_kernel
	mkimage -f config/os_image.its  deploy/saos_raw_os.itb
	cp deploy/saos_raw_os.itb /tftpboot/

.PHONY: saos_fetch_subtrees
saos_fetch_subtrees:
	@ bin/do_fetch_trees.sh

.PHONY: saos_chk_env_file
saos_chk_env_file:
	@ if [ ! -f ${OS_ENV_FILE} ]; \
	then \
		echo "====>>> SDK MISSING [${OS_ENV_FILE}], please install" ;\
		exit 1 ;\
	else \
		exit 0 ;\
	fi;
