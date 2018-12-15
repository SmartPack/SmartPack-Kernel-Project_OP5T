/*
 *
 * Smart Charge: A simple interface to control USB fast charge
 *
 * Author: sunilpaulmathew <sunil.kde@gmail.com>
 *
 * Largely based on the original implementation of charge_levels
 * by andip71 aka Lord Boeffla
 *
 * Version 1.0, August 24, 2018 
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
 * Smart Charge - SysFS interface (same as that of force fast charge):
 * --------------------------------------
 *
 * /sys/kernel/fast_charge/force_fast_charge (rw)
 *
 *   1 - Bump USB charge rate upto 900 mA
 *   0 - disabled
 */

#include <linux/module.h>
#include <linux/kobject.h>
#include <linux/sysfs.h>

/* variables */
extern int smart_charge;

/* sysfs interface */
static ssize_t force_fast_charge_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
    /* return setting */
    return sprintf(buf, "%d\n", smart_charge);
}

static ssize_t force_fast_charge_store(struct kobject *kobj, struct kobj_attribute *attr, const char *buf, size_t count)
{
    unsigned int ret = -EINVAL;
    int val;

    /* read value from input buffer */
    ret = sscanf(buf, "%d", &val);

    if (ret != 1)
	return -EINVAL;

    /* value of 1 enables usb fast charging; everything else disables it */
    if (val == 1)
	smart_charge = 1;
    else
	smart_charge = 0;

    return count;
}

/* Initialize smart charge sysfs folder */

static struct kobj_attribute force_fast_charge_attribute =
__ATTR(force_fast_charge, 0664, force_fast_charge_show, force_fast_charge_store);

static struct attribute *smart_charge_attrs[] = {
    &force_fast_charge_attribute.attr,
    NULL,
};

static struct attribute_group smart_charge_attr_group = {
    .attrs = smart_charge_attrs,
};

static struct kobject *smart_charge_kobj;

int smart_charge_init(void)
{
    int smart_charge_retval;

    smart_charge_kobj = kobject_create_and_add("fast_charge", kernel_kobj);

    if (!smart_charge_kobj)
	{
	    return -ENOMEM;
        }

        smart_charge_retval = sysfs_create_group(smart_charge_kobj, &smart_charge_attr_group);

    if (smart_charge_retval)
	{
	    kobject_put(smart_charge_kobj);
	    return (smart_charge_retval);
	}
    return (smart_charge_retval);
}

void smart_charge_exit(void)
{
    kobject_put(smart_charge_kobj);
}

/* define driver entry points */
module_init(smart_charge_init);
module_exit(smart_charge_exit);
MODULE_LICENSE("GPL v2");
MODULE_AUTHOR("sunilpaulmathew <sunil.kde@gmail.com>");
MODULE_DESCRIPTION("Smart Charge: A simple interface to control USB fast charge");
