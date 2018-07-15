export OS_CONTAINER_ROOT := $(shell pwd)
include ${OS_CONTAINER_ROOT}/config/machine.mk
export OS_KERNEL_CONTAINER_ROOT := ${OS_CONTAINER_ROOT}/saos_kernel
export OS_YOCTO_CONTAINER_ROOT := ${OS_CONTAINER_ROOT}/saos_yocto

export OS_ENV_FILE := /opt/poky/2.2.4/environment-setup-cortexa9hf-neon-poky-linux-gnueabi

.PHONY: saos_build_yocto
saos_build_yocto:
	make -C ${OS_YOCTO_CONTAINER_ROOT}

.PHONY: saos_build_kernel
saos_build_kernel: saos_chk_env_file
	@ . ${OS_ENV_FILE} && make -C ${OS_KERNEL_CONTAINER_ROOT}

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
