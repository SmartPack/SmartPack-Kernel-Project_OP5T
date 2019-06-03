# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=SmartPack Kernel by sunilpaulmathew@xda-developers.com
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=OnePlus5T
device.name2=dumpling
device.name3=OnePlus5
device.name4=cheeseburger
device.name5=
supported.versions=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install

# Don't allow flashing on non-Treble ROMs
is_treble=$(file_getprop /system/build.prop "ro.treble.enabled");
if [ ! "$is_treble" -o "$is_treble" == "false" ]; then
  ui_print " ";
  ui_print "This version of SmartPack-Kernel is only compatible with stock OxygenOS 5.1.5, or newer with Treble support!";
  exit 1;
fi;

# Don't allow flashing on unsupported versions
ui_print "Checking android version...";
android_ver=$(file_getprop /system/build.prop "ro.build.version.release");
ui_print "Android $android_ver detected...";
ui_print " ";
if [ ! "$android_ver" == "9" ]; then
  ui_print "This version of SmartPack-Kernel is only compatible with Android 9!";
  exit 1;
fi;

dump_boot;

# begin ramdisk changes

# init.rc
backup_file init.rc;
grep "import /init.SmartPack.rc" init.rc >/dev/null || sed -i '1,/.*import.*/s/.*import.*/import \/init.SmartPack.rc\n&/' init.rc
# Remove recovery service so that TWRP isn't overwritten
remove_section init.rc "service flash_recovery" ""

# init.tuna.rc

# fstab.tuna

# end ramdisk changes

write_boot;
## end install

