/*
 * Author: andip71, 29.07.2017
 * 
 * Version 1.1.2
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

/*
 * Change log:
 *
 * 1.1.2 (18.07.2018)
 *   - Simplified sysFs to make compatible with SP-Kernel Manager
 *   - set default headphone gain to zero
 * 
 * 1.1.1 (29.07.2017)
 *   - Fix headphone volume reset issue
 * 
 * 1.1.0 (13.07.2017)
 *   - Add earpiece volume control
 *   - Add microphone sensitivity control
 *
 * 1.0.0 (03.07.2017)
 *   - Initial version for OnePlus 5
 * 
 */

#include "boeffla_sound.h"


/*****************************************/
// Variables
/*****************************************/

// internal boeffla sound variables
static int boeffla_sound;	// boeffla sound master switch
static int debug;			// debug switch

static int headphone_volume_l;
static int headphone_volume_r;


/*****************************************/
// internal helper functions
/*****************************************/

static void reset_boeffla_sound(void)
{
	// set all boeffla sound config settings to defaults
	headphone_volume_l = HEADPHONE_DEFAULT;
	headphone_volume_r = HEADPHONE_DEFAULT;

	if (debug)
		printk("Boeffla-sound: boeffla sound reset done\n");
}


static void reset_audio_hub(void)
{
	// reset all audio hub registers back to defaults
	set_headphone_gain_l(HEADPHONE_DEFAULT + HEADPHONE_REG_OFFSET);
	set_headphone_gain_r(HEADPHONE_DEFAULT + HEADPHONE_REG_OFFSET);

	set_earpiece_gain(EARPIECE_DEFAULT + EARPIECE_REG_OFFSET);

	set_mic_gain_call(MICLEVEL_DEFAULT_CALL + MICLEVEL_REG_OFFSET_CALL);

	if (debug)
		printk("Boeffla-sound: wcd9335 audio hub reset done\n");
}


/*****************************************/
// sysfs interface functions
/*****************************************/

// Boeffla sound master switch

static ssize_t boeffla_sound_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	// print current value
	return sprintf(buf, "Boeffla sound status: %d\n", boeffla_sound);
}


static ssize_t boeffla_sound_store(struct device *dev, struct device_attribute *attr,
					const char *buf, size_t count)
{
	unsigned int ret = -EINVAL;
	int val;

	// read values from input buffer
	ret = sscanf(buf, "%d", &val);

	if (ret != 1)
		return -EINVAL;
		
	// store if valid data
	if (((val == 0) || (val == 1)))
	{
		// check if there was a change
		if (boeffla_sound != val)
		{
			// set new status
			boeffla_sound = val;

			// re-initialize settings and audio hub (in any case for both on and off !)
			reset_boeffla_sound();
			reset_audio_hub();
		}

		// print debug info
		if (debug)
			printk("Boeffla-sound: status %d\n", boeffla_sound);
	}

	return count;
}


// Headphone volume

static ssize_t headphone_volume_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	int val_l;
	int val_r;

	val_l = get_headphone_gain_l() - HEADPHONE_REG_OFFSET;
	val_r = get_headphone_gain_r() - HEADPHONE_REG_OFFSET;

	// convert back into signed integer between -127 and +127)
	if (val_l > 127)
		val_l = val_l - 256;

	if (val_r > 127)
		val_r = val_r - 256;

	// print current values
	return sprintf(buf, "%d %d\n", val_l, val_r);
}


static ssize_t headphone_volume_store(struct device *dev, struct device_attribute *attr,
					const char *buf, size_t count)
{
	unsigned int ret = -EINVAL;
	int val_l;
	int val_r;

	// Terminate if boeffla sound is not enabled
	if (!boeffla_sound)
		return count;

	// read values from input buffer
	ret = sscanf(buf, "%d %d", &val_l, &val_r);

	if (ret != 2)
		return -EINVAL;
		
	// check whether values are within the valid ranges and adjust accordingly
	if (val_l > HEADPHONE_MAX)
		val_l = HEADPHONE_MAX;

	if (val_l < HEADPHONE_MIN)
		val_l = HEADPHONE_MIN;

	if (val_r > HEADPHONE_MAX)
		val_r = HEADPHONE_MAX;

	if (val_r < HEADPHONE_MIN)
		val_r = HEADPHONE_MIN;

	// store new values
	headphone_volume_l = val_l;
	headphone_volume_r = val_r;

	// set new values
	set_headphone_gain_l(headphone_volume_l + HEADPHONE_REG_OFFSET);
	set_headphone_gain_r(headphone_volume_r + HEADPHONE_REG_OFFSET);

	// print debug info
	if (debug)
		printk("%d %d\n", headphone_volume_l, headphone_volume_r);

	return count;
}

static ssize_t earpiece_volume_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	int val;

	val = get_earpiece_gain() - EARPIECE_REG_OFFSET;	// mono earpiece, so we alwas treat L and R the same

	// convert byte to signed int
	if (val > 127)
		val = (256 - val) * -1;

	// print current values
	return sprintf(buf, "%d %d\n", val, val);
}


static ssize_t earpiece_volume_store(struct device *dev, struct device_attribute *attr,
					const char *buf, size_t count)
{
	unsigned int ret = -EINVAL;
	int val;
	int val_unused;

	// Terminate if boeffla sound is not enabled
	if (!boeffla_sound)
		return count;

	// read values from input buffer
	ret = sscanf(buf, "%d %d", &val, &val_unused);	// mono earpiece, so we only consider first value

	if (ret != 2)
		return -EINVAL;

	// check whether values are within the valid ranges and adjust accordingly
	if (val > EARPIECE_MAX)
		val = EARPIECE_MAX;

	if (val < EARPIECE_MIN)
		val = EARPIECE_MIN;

	// set new value
	set_earpiece_gain(val + EARPIECE_REG_OFFSET);

	// print debug info
	if (debug)
		printk("%d %d\n", val, val);

	return count;
}


// Microphone level general

static ssize_t mic_level_call_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	int val;

	val = get_mic_gain_call() - MICLEVEL_REG_OFFSET_CALL;

	// convert byte to signed int
	if (val > 127)
		val = (256 - val) * -1;

	return sprintf(buf, "%d\n", val);
}


static ssize_t mic_level_call_store(struct device *dev, struct device_attribute *attr,
					const char *buf, size_t count)
{
	unsigned int ret = -EINVAL;
	int val;

	// Terminate if boeffla sound is not enabled
	if (!boeffla_sound)
		return count;

	// read value for mic level from input buffer
	ret = sscanf(buf, "%d", &val);

	if (ret != 1)
		return -EINVAL;

	// check whether values are within the valid ranges and adjust accordingly
	if (val > MICLEVEL_MAX_CALL)
		val = MICLEVEL_MAX_CALL;

	if (val < MICLEVEL_MIN_CALL)
		val = MICLEVEL_MIN_CALL;

	// set new value
	set_mic_gain_call(val + MICLEVEL_REG_OFFSET_CALL);

	// print debug info
	if (debug)
		printk("%d\n", val);

	return count;
}


// Debug status

static ssize_t debug_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	// return current debug status
	return sprintf(buf, "Debug status: %d\n", debug);
}

static ssize_t debug_store(struct device *dev, struct device_attribute *attr,
						const char *buf, size_t count)
{
	unsigned int ret = -EINVAL;
	unsigned int val;

	// check data and store if valid
	ret = sscanf(buf, "%d", &val);

	if (ret != 1)
		return -EINVAL;
		
	if ((val == 0) || (val == 1))
		debug = val;

	return count;
}


// Register dump

static ssize_t reg_dump_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	// return register dump information
	return sprintf(buf, "headphone_gain_l: %d\nheadphone_gain_r: %d\nearpiece_gain: %d\nmic_gain: %d\n", 
			get_headphone_gain_l(), 
			get_headphone_gain_r(),
			get_earpiece_gain(),
			get_mic_gain_call());
}


// Version information

static ssize_t version_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	// return version information
	return sprintf(buf, "%s\n", BOEFFLA_SOUND_VERSION);
}



// hook functions

unsigned int boeffla_sound_write_hook(unsigned int reg, unsigned int val)
{
	// if boeffla sound is off, return original value
	if (!boeffla_sound)
		return val;

	// based on the register, do the appropriate processing
	switch (reg)
	{
		// headphone l
		case WCD9335_CDC_RX1_RX_VOL_CTL:
		case WCD9335_CDC_RX1_RX_VOL_MIX_CTL:
			val = headphone_volume_l + HEADPHONE_REG_OFFSET;
			break;

		// headphone r
		case WCD9335_CDC_RX2_RX_VOL_CTL:
		case WCD9335_CDC_RX2_RX_VOL_MIX_CTL:
			val = headphone_volume_r + HEADPHONE_REG_OFFSET;
			break;
	}

	return val;
}


bool boeffla_sound_block_update_bits_hook(unsigned int reg)
{
	// based on the register, check if we should block the update
	switch (reg)
	{
		case WCD9335_CDC_RX1_RX_VOL_CTL:
		case WCD9335_CDC_RX1_RX_VOL_MIX_CTL:
		case WCD9335_CDC_RX2_RX_VOL_CTL:
		case WCD9335_CDC_RX2_RX_VOL_MIX_CTL:
			return true;
			break;
	}

	return false;
}

/*****************************************/
// Initialize boeffla sound sysfs folder
/*****************************************/

// define objects
static DEVICE_ATTR(boeffla_sound, 0664, boeffla_sound_show, boeffla_sound_store);
static DEVICE_ATTR(headphone_volume, 0664, headphone_volume_show, headphone_volume_store);
static DEVICE_ATTR(earpiece_volume, 0664, earpiece_volume_show, earpiece_volume_store);
static DEVICE_ATTR(mic_level_call, 0664, mic_level_call_show, mic_level_call_store);
static DEVICE_ATTR(debug, 0664, debug_show, debug_store);
static DEVICE_ATTR(version, 0664, version_show, NULL);
static DEVICE_ATTR(reg_dump, 0664, reg_dump_show, NULL);

// define attributes
static struct attribute *boeffla_sound_attributes[] = {
	&dev_attr_boeffla_sound.attr,
	&dev_attr_headphone_volume.attr,
	&dev_attr_earpiece_volume.attr,
	&dev_attr_mic_level_call.attr,
	&dev_attr_debug.attr,
	&dev_attr_version.attr,
	&dev_attr_reg_dump.attr,
	NULL
};

// define attribute group
static struct attribute_group boeffla_sound_control_group = {
	.attrs = boeffla_sound_attributes,
};

// define control device
static struct miscdevice boeffla_sound_control_device = {
	.minor = MISC_DYNAMIC_MINOR,
	.name = "boeffla_sound",
};


/*****************************************/
// Driver init and exit functions
/*****************************************/

static int boeffla_sound_init(void)
{
	// register boeffla sound control device
	misc_register(&boeffla_sound_control_device);
	if (sysfs_create_group(&boeffla_sound_control_device.this_device->kobj,
				&boeffla_sound_control_group) < 0) {
		printk("Boeffla-sound: failed to create sys fs object.\n");
		return 0;
	}

	// Initialize variables
	boeffla_sound = BOEFFLA_SOUND_DEFAULT;
	debug = DEBUG_DEFAULT;
	
	// Reset boeffla sound settings
	reset_boeffla_sound();

	// Print debug info
	printk("Boeffla-sound: engine version %s started\n", BOEFFLA_SOUND_VERSION);

	return 0;
}


static void boeffla_sound_exit(void)
{
	// remove boeffla sound control device
	sysfs_remove_group(&boeffla_sound_control_device.this_device->kobj,
                           &boeffla_sound_control_group);

	// Print debug info
	printk("Boeffla-sound: engine stopped\n");
}


/* define driver entry points */

module_init(boeffla_sound_init);
module_exit(boeffla_sound_exit);
