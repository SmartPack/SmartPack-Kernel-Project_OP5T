#!/system/bin/sh

#
# SmartPack-Kernel Boot Script
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

if [ "$(grep -c SmartPack-Kernel- /proc/version)" -eq "1" ]; then
    echo "Apply SmartPack-Kernel default settings..." | tee /dev/kmsg
    # Huge thanks to sultanxda and justjr @ xda-developers.com

    sleep 30;

    # configure governor settings for little cluster
    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/fast_ramp_down
    echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows
    echo 100 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
    echo "70 672000:45 825600:50 1036800:60 1248000:70 1478400:85" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
    echo 30000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
    echo 80000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction
    echo 79000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load

    # configure governor settings for big cluster
    echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo "19000 1400000:39000 1700000:19000 2100000:79000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/fast_ramp_down
    echo 19000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/align_windows
    echo 99 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
    echo "85 1728000:80 2112000:90 2342400:95" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
    echo 1574400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
    echo 30000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
    echo 80000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/enable_prediction
    echo 39000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load

    # Other cpu settings
    chmod 644 /sys/module/workqueue/parameters/power_efficient
    echo Y > /sys/module/workqueue/parameters/power_efficient
    echo 0-7 > /dev/cpuset/top-app/cpus
    echo 0-3,6-7 > /dev/cpuset/foreground/boost/cpus
    echo 0-3,6-7 > /dev/cpuset/foreground/cpus
    echo 0-1 > /dev/cpuset/background/cpus
    echo 0-3 > /dev/cpuset/system-background/cpus

    # Misc settings
    echo 1 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
    echo 1024 > /sys/block/sda/queue/read_ahead_kb
    echo 128 > /sys/block/sda/queue/nr_requests
    echo 1 > /sys/block/sda/queue/iostats
    echo 512 > /sys/block/sde/queue/read_ahead_kb
    echo 128 > /sys/block/sde/queue/nr_requests
    echo 1 > /sys/block/sde/queue/iostats

    # The END
    echo "Everything done..." | tee /dev/kmsg
fi
