# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=StormBreaker Kernel
maintainer.string1=Forenche TG:@rakoool
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=surya
device.name2=karna
supported.versions=10-11
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel install
dump_boot;

# Pre patch command line
patch_cmdline "dfps.min_fps" " "
patch_cmdline "dfps.max_fps" " "

MIN_FPS=60
MAX_FPS=120
OOS=0

# Detect ROM
if [ -e /vendor/odm/etc/buildinfo/oem_build.prop ]; then
  OOS=1
  os_string="OxygenOS";
else
  os_string="Custom ROM";
fi

# Fallback mechanism but needs to be configured by the user
if [ -f /tmp/oos ]; then
  OOS=1
fi;

# begin ramdisk changes
# end ramdisk changes

# Begin patching command line
if [ "$OOS" == 1 ]; then
  ui_print "$os ,Patching cmdline with arguments:"
  ui_print "kpti=off dfps.min_fps=$MIN_FPS dfps.max_fps=$MAX_FPS"
  patch_cmdline "kpti=off" "kpti=off dfps.min_fps=$MIN_FPS dfps.max_fps=$MAX_FPS"
  else
  ui_print "$os not doing any changes to conmand line"
fi

write_boot;
## end install
