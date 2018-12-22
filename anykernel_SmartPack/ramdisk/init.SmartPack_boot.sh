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

    # Disable thermal hotplug to switch governor
    echo 0 > /sys/module/msm_thermal/core_control/enabled
    echo "disable" > /sys/devices/soc/soc:qcom,bcl/mode
    echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
    echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
    echo "enable" > /sys/devices/soc/soc:qcom,bcl/mode

    # configure governor settings for little cluster
    echo "blu_active" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/above_hispeed_delay
    echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/timer_rate
    echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/io_is_busy
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/align_windows
    echo "83 1804800:95" > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/target_loads
    echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/min_sample_time
    echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/timer_slack
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/fastlane
    echo 50 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/fastlane_threshold

    # configure governor settings for big cluster
    echo "blu_active" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/above_hispeed_delay
    echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/timer_rate
    echo 1574400 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/io_is_busy
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/align_windows
    echo "83 1939200:90 2016000:95" > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/target_loads
    echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/min_sample_time
    echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/timer_slack
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/fastlane
    echo 50 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/fastlane_threshold

    # Re-enable thermal hotplug
    echo 1 > /sys/module/msm_thermal/core_control/enabled
    echo "disable" > /sys/devices/soc/soc:qcom,bcl/mode
    echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
    echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
    echo "enable" > /sys/devices/soc/soc:qcom,bcl/mode

    # Other cpu settings
    chmod 644 /sys/module/workqueue/parameters/power_efficient
    echo Y > /sys/module/workqueue/parameters/power_efficient
    echo 0-7 > /dev/cpuset/top-app/cpus
    echo 0-3,6-7 > /dev/cpuset/foreground/boost/cpus
    echo 0-3,6-7 > /dev/cpuset/foreground/cpus
    echo 0-1 > /dev/cpuset/background/cpus
    echo 0-3 > /dev/cpuset/system-background/cpus

    # GPU settings
    echo 1 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost

    # IO settings
    echo 1024 > /sys/block/sda/queue/read_ahead_kb
    echo 128 > /sys/block/sda/queue/nr_requests
    echo 1 > /sys/block/sda/queue/iostats
    echo 512 > /sys/block/sde/queue/read_ahead_kb
    echo 128 > /sys/block/sde/queue/nr_requests
    echo 1 > /sys/block/sde/queue/iostats

    # Misc settings
    fsync="/sys/module/sync/parameters/fsync_enabled"
    echo 0 > $fsync

    # The END
    echo "Everything done..." | tee /dev/kmsg
fi
