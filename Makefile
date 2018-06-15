export OS_CONTAINER_ROOT := $(shell pwd)
include ${OS_CONTAINER_ROOT}/config/machine.mk
export OS_KERNEL_CONTAINER_ROOT := ${OS_CONTAINER_ROOT}/saos_kernel
export OS_YOCTO_CONTAINER_ROOT := ${OS_CONTAINER_ROOT}/saos_yocto


.PHONY: saos_build_yocto
saos_build_yocto:
	make -C ${OS_YOCTO_CONTAINER_ROOT}

.PHONY: saos_build_kernel
saos_build_kernel:
	make -C ${OS_KERNEL_CONTAINER_ROOT}

.PHONY: saos_fetch_subtrees
saos_fetch_subtrees:
	@ bin/do_fetch_trees.sh
