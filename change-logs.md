# Change-logs

## 17. Dec 15, 2018
*Release status: beta-v17*
Changes: CPU Input Boost, Devfreq Boost & Simple LMK: Merge updates from Wahoo (Credits: sultanxda). staging: android: ion: upstream updates (Credits: nathanchance). DIsabled fsync by default. Minor miscellaneous changes, especially on kernel boot script.

## 16. Dec 14, 2018
*Release status: beta-v16*
Changes: Very first kernel release for Android Pie. Based on the official [OOS source code](https://github.com/OnePlusOSS/android_kernel_oneplus_msm8998/tree/oneplus/QC8998_P_9.0_Beta). Update Linux Kernel version to 4.4.167 (credits: nathanchance).

## 15. Dec 02, 2018
*Release status: stable-v15*
Changes: Properly fix OnePlus gestures. Removed a bunch of bloats. Update Linux Kernel version to 4.4.166 (credits: nathanchance). Misc changes.

## 14. Nov 29, 2018
*Release status: stable-v14*
Changes: CPU Input Boost: slightly increase boost parameters. Update Linux Kernel version to 4.4.165 (credits: nathanchance).

## 13. Nov 25, 2018
*Release status: stable-v13*
Changes: Added several patches to default interactive governor. Removed spectrum support. Update Linux Kernel version to 4.4.164 (credits: nathanchance). SmartPack boot script: updated default interactive settings. Misc: a bunch of fixes & improvements.

## 12. Nov 20, 2018
*Release status: stable-v12*
Changes: Kernel is fully re-based (only useful stuffs are added back). Unified kernels for Oxygen OS Stable & Open beta. Fixed CPU freq not going over 2.3x GHz. Touch boost is now enabled, but not exposed to userspace meaning you won't get a chance to disable it in Kernel Manager (not even visible). Fixed Scheduled Workques. No more freezes and reboots while using the camera (hopefully). Bunch of clean-ups and fixed.

## 11. Nov 12, 2018
*Release status: stable-v11*
Changes: wakeup: add options to block more wakelocks. CPU input Boost & Simple LMK: merge updates from Wahoo (credits: Sultanxda). Incorporating recent patches from osm0sis's AnyKernel2 repo (credits: osm0sis). Update Linux Kernel version to 4.4.163 (credits: nathanchance).

## 10. Oct 26, 2018
*Release status: stable-v10*
Changes: Merge updates from oxygen OS stable branch. MSM_Thermal: Exposed a bunch of advanced parameters (Requires SmartPack-Kernel Manager). Workaround to fix wifi issues in OP5. Update Linux Kernel version to 4.4.162 (credits: @nathanchance).

## 9. Oct 11, 2018
*Release status: beta-v9*
Changes: CPU Input Boost: Merge updates from Wahoo and disabled stock CPU Boost. Added Devfreq Boost and Simple LMK driver by Sultanxda. Update Linux Kernel version to 4.4.160 (credits: @nathanchance). Many tweaks to improve overall stability. Add SmartPack boot script with a lot of useful tweaks to make the device fast & efficient.

## 8. Oct 06, 2018
*Release status: beta-v8-OB*
Changes: Thermal: revert to Qualcomm's stock thermal solution. CPU Input Boost: Merge updates from Wahoo and disabled stock CPU Boost. Added Devfreq Boost and Simple LMK driver by Sultanxda. Update Linux Kernel version to 4.4.159 (credits: @nathanchance). Some tweaks to improve overall stability.

## 7. Sept 27, 2018
*Release status: beta-v7-OB*
Changes: Added Simple MSM Thermal driver by Sultanxda with full control in SmartPack-Kernel Manager (v5.2 or later). Update Linux Kernel version to 4.4.158 (credits: @nathanchance). Add SmartPack boot script with a lot of useful tweaks to make the device fast & efficient.

## 6. Sept 20, 2018
*Release status: beta-v6*
Changes: Update Linux Kernel version to 4.4.157 (credits: @nathanchance). Merged several patches from CAF (credits: @crian). Now fully compatible with OnePlus 5.

## 5. Sept 16, 2018
*Release status: beta-v5*
Changes: Update Linux Kernel version to 4.4.156 (credits: @nathanchance). Added Alucard cpufreq gov.

## 4. Sept 06, 2018
*Release status: beta-v4*
Changes: Update Linux Kernel version to 4.4.154 (credits: @nathanchance). Switch toolchain into latest (GCC-8.2.1). Add control over Min Display Backlight. Merged several patches from CAF & Upstream (for cpufreq, iosched etc.). Add OS check to the anykernel script so that it won't be installed in non-treble OS and other un-supported android versions.

## 3. Aug 30, 2018
*Release status: beta-v3*
Changes: Update Linux Kernel version to 4.4.153 (credits: @nathanchance). Added Zen, Fiops, SIO & SIOPlus IO schedulers. Implemented vibration strength control (credits: Lord Boeffla). Misc changes.

## 2. Aug 23, 2018
*Release status: beta-v2*
Changes: Update Linux Kernel version to 4.4.151 (credits: @nathanchance). Merge updates from Oxygen OS to work best with version 5.1.5 (which includes project trouble support). Fix CPU frequencies sticking at max. Update wireguard.

## 1. Aug 22, 2018
*Release status: beta-v1*
The very first release for OnePlus 5T running stable OxygenOS 5.1.4 (Android 8.1.0).
Based on the [source code](https://github.com/android-linux-stable/op5) maintained by @nathanchance.
