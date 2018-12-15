#!/bin/bash

#
# SmartPack-Kernel Build Script
# 
# Author: sunilpaulmathew <sunil.kde@gmail.com>
#

#
# This script is licensed under the terms of the GNU General Public 
# License version 2, as published by the Free Software Foundation, 
# and may be copied, distributed, and modified under those terms.
#

#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#

#
# ***** ***** ***** ..How to use this script… ***** ***** ***** #
#
# For those who want to build this kernel using this script…
#

# 1. Properly locate toolchain (Line# 37)
# 2. Set the 'KERNEL_VERSION' (Line# 45)
# 3. Open Terminal, ‘cd’ to the Kernel ‘root’ folder and run ‘. build_SmartPack.sh’
# 4. The output (anykernel zip) file will be generated in the ‘release_SmartPack’ folder
# 5. Enjoy your new Kernel

#
# ***** ***** *Variables to be configured manually* ***** ***** #

TOOLCHAIN="/home/sunil/aarch64-linux-gnu-8.x/bin/aarch64-opt-linux-android-"

ARCHITECTURE="arm64"

KERNEL_NAME="SmartPack-Kernel"

KERNEL_VARIANT="dumpling"	# please leave as such

KERNEL_VERSION="beta-v17"   # leave as such, if no specific version tag

KERNEL_DEFCONFIG="SmartPack_defconfig"

KERNEL_DATE="$(date +"%Y%m%d")"

BUILD_DIR="output_$KERNEL_VARIANT"

KERNEL_IMAGE="$BUILD_DIR/arch/$ARCHITECTURE/boot/Image.gz-dtb"

ANYKERNEL_DIR="anykernel_SmartPack"

RELEASE_DIR="release_SmartPack"

PREPARE_RELEASE=""

NUM_CPUS=""   # number of cpu cores used for build (leave empty for auto detection)

# ***** ***** ***** ***** ***THE END*** ***** ***** ***** ***** #

COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[1;32m"
COLOR_NEUTRAL="\033[0m"

export ARCH=$ARCHITECTURE

export CROSS_COMPILE="${CCACHE} $TOOLCHAIN"

export KBUILD_BUILD_USER=$KERNEL_NAME-[sunilpaulmathew

export KBUILD_BUILD_HOST=xda-developers.com]

if [ -z "$NUM_CPUS" ]; then
	NUM_CPUS=`grep -c ^processor /proc/cpuinfo`
fi

# Initialize building...
if [ -e $BUILD_DIR ]; then
	if [ -e $BUILD_DIR/.config ]; then
		rm -f $BUILD_DIR/.config
		if [ -e $KERNEL_IMAGE ]; then
			rm -f $KERNEL_IMAGE
		fi
	fi
else
	mkdir $BUILD_DIR
fi
echo -e $COLOR_NEUTRAL"\n building $KERNEL_NAME $KERNEL_VERSION for $KERNEL_VARIANT\n"$COLOR_NEUTRAL
make -C $(pwd) O=$BUILD_DIR $KERNEL_DEFCONFIG
# updating kernel version
sed -i "s;-perf;-$KERNEL_VERSION;" $BUILD_DIR/.config;
make -j$NUM_CPUS -C $(pwd) O=$BUILD_DIR
if [ -e $KERNEL_IMAGE ]; then
	echo -e $COLOR_GREEN"\n copying zImage to anykernel directory\n"$COLOR_NEUTRAL
	cp $KERNEL_IMAGE $ANYKERNEL_DIR/zImage
	# adding version tag to ramdisk in order to access from the Kernel Manager
	echo $KERNEL_VERSION > $ANYKERNEL_DIR/ramdisk/version
	echo -e $COLOR_GREEN"\n generating recovery flashable zip file\n"$COLOR_NEUTRAL
	cd $ANYKERNEL_DIR && zip -r9 $KERNEL_NAME-$KERNEL_VARIANT-$KERNEL_VERSION-$KERNEL_DATE.zip * -x README.md $KERNEL_NAME-$KERNEL_VARIANT-$KERNEL_VERSION-$KERNEL_DATE.zip && cd ..
	echo -e $COLOR_GREEN"\n cleaning...\n"$COLOR_NEUTRAL
	# check and create release folder.
	if [ ! -d "$RELEASE_DIR" ]; then
		mkdir $RELEASE_DIR
	fi
	rm $ANYKERNEL_DIR/zImage && mv $ANYKERNEL_DIR/$KERNEL_NAME* $RELEASE_DIR
	if [ "y" == "$PREPARE_RELEASE" ]; then
		echo -e $COLOR_GREEN"\n Preparing for kernel release\n"$COLOR_NEUTRAL
		cp $RELEASE_DIR/$KERNEL_NAME-$KERNEL_VARIANT-$KERNEL_VERSION-$KERNEL_DATE.zip kernel-release/$KERNEL_NAME-$KERNEL_VARIANT.zip
	fi
	echo -e $COLOR_GREEN"\n Building for $KERNEL_VARIANT finished... please visit '$RELEASE_DIR'...\n"$COLOR_NEUTRAL
else
	echo -e $COLOR_RED"\n Building for $KERNEL_VARIANT failed. Please fix the issues and try again...\n"$COLOR_RED
fi
