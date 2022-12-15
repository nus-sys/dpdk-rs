# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

#=======================================================================================================================
# Default Paths
#=======================================================================================================================

export PREFIX ?= $(HOME)
export PKG_CONFIG_PATH ?= $(shell find $(PREFIX)/lib/ -name '*pkgconfig*' -type d 2> /dev/null | xargs | sed -e 's/\s/:/g')
export LD_LIBRARY_PATH ?= $(HOME)/lib:$(shell find $(PREFIX)/lib/ -name '*x86_64-linux-gnu*' -type d 2> /dev/null | xargs | sed -e 's/\s/:/g')

#=======================================================================================================================
# Tools
#=======================================================================================================================

export CARGO ?= $(HOME)/.cargo/bin/cargo
export RM ?= rm -rf

#=======================================================================================================================
# Switches
#=======================================================================================================================

# Set build mode.
ifneq ($(DEBUG),yes)
export BUILD = release
else
export BUILD = dev
endif

# Set build flags.
export FLAGS += --profile $(BUILD)

# Set driver version.
export DRIVER ?= $(shell [ ! -z "`lspci | grep -E "ConnectX-[4,5]"`" ] && echo mlx5 || echo mlx4)
export FLAGS += --features=$(DRIVER)
