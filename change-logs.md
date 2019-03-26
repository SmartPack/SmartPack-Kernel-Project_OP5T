# Change-logs

## 30. Mar 26, 2019
*Release status: stable-v30
Changes: Merged CAF tag LA.UM.7.4.r1-04800-8x98.0. Updated Linux Kernel version to 4.4.177 (credits: nathanchance). Exposed devfreq boot duration and freq. to userspace.

## 29. Mar 11, 2019
*Release status: stable-v29*
Changes: Added K-Lapse v4.3, a kernel level live-display module by @tanish2k09. 
cpu_Input_boost, devfreq_boost & simple_lmk: Merged updates from wahoo. Set *Maple* as the default I/O Scheduler. Misc changes, please visit my GitHub page for more information.

## 28. Feb 25, 2019
*Release status: stable-v28*
Changes: simple_lmk: Merged updates from wahoo. Merged CAF tag 'LA.UM.7.4.r1-04700-8x98.0'. Updated Linux Kernel version to 4.4.176 (credits: nathanchance).

## 27. Feb 01, 2019
*Release status: stable-v27*
Changes: Added back High Brightness Mode. Updated Linux Kernel version to 4.4.172 (credits: nathanchance).

## 26. Jan 18, 2019
*Release status: stable-v26*
Changes: Added interface to configure Linux PrintK logging (credits: Lord Boeffla). Simple_lmk & Devfreq_boost: merged updated from wahoo (credits: Sultanxda). Updated Linux Kernel version to 4.4.171 (credits: nathanchance). Up-to-date with OnePlus kernel source (oneplus/QC8998_P_9.0_Beta branch).

## 25. Jan 14, 2019
*Release status: stable-v25*
Changes: Updated Linux Kernel version to 4.4.170 (credits: nathanchance). Configured VM_MAX_READAHEAD as 2048. Fixed Google Camera related issues.

## 24. Jan 13, 2019
*Release status: beta-v24*
Changes: Up-to-date with CAF changes (latest; LA.UM.7.4.r1-04600-8x98.0). Fixed vibration control.

## 23. Jan 11, 2019
*Release status: beta-v23*
Changes: Implement sched/tune Dynamic SchedTune Boost on CPU Input Boost (credits: @joshuous). Incorporating recent patches from osm0sis's AnyKernel2 repo (credits: @osm0sis). Miscellaneous changes.

## 22. Jan 01, 2019
*Release status: beta-v22*
Changes: Merged updates from stock Oxygen OS stable Pie branch. Updated wireguard. Boeffla Wakelock blocker: block more wakelocks by default. Various other updates.

## 21. Dec 26, 2018
*Release status: beta-v21*
Changes: Merged updates from stock Oxygen OS [stable Pie branch](https://github.com/OnePlusOSS/android_kernel_oneplus_msm8998/tree/oneplus/QC8998_P_9.0).

## 20. Dec 25, 2018
*Release status: beta-v20*
Changes: Up-to-date with official OnePlus kernel changes. SmartPack boot script: CPU governor: Switched back to default interactive. CPU Input Boost: increased boost duration to 150 ms and OnePlus Launcher top-app boost duration to 1000 ms (hopefully makes the performance bit more snappy).

## 19. Dec 22, 2018
*Release status: beta-v19*
Changes: Switch default CPU governor for both Big & Little clusters to blu_active (Thanks to eng.stk for the tweaks). Update Linux Kernel version to 4.4.169 (credits: nathanchance).

## 18. Dec 18, 2018
*Release status: beta-v18*
Changes: Adrenoboost: updated to v2.1. ZRAM: set lz4 by default. Update Linux Kernel version to 4.4.168 (credits: nathanchance).

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
