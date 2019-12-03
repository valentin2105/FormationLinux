# TP2-Kernel


### Objectif:

> Créer, compiler et charger un module du Noyau.
> Compiler avec DKMS le module ZFS puis formater et monter une partition ZFS


### Procédure:

```
# On installe les headers du noyau
apt install linux-headers-`uname -r` build-essential




mkdir -p ~/src/lkm_example
cd ~/src/lkm_example

vim lkm_example.c


#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
MODULE_LICENSE("GPL");
MODULE_AUTHOR("FormationLinux niveau 2");
MODULE_DESCRIPTION("A simple Linux Kernel module.");
MODULE_VERSION("0.01");
static int __init lkm_example_init(void) {
 printk(KERN_INFO "Hello, World! from the Linux Kernel\n");
  return 0;
  }
  static void __exit lkm_example_exit(void) {
   printk(KERN_INFO "Goodbye, World!\n");
   }
   module_init(lkm_example_init);
   module_exit(lkm_example_exit);




vim Makefile

obj-m += lkm_example.o
all:
 make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
 clean:
  make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean



make


ls -alh


insmod lkm_example.ko

dmesg

lsmod |grep lkm  


rmmod lkm_example


dmesg

```

Notre module est pas très utile, allons un peu plus loin :

```
# On remplace le contenu de lkm_example.c avec ce code source : 


#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <asm/uaccess.h>
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Robert W. Oliver II");
MODULE_DESCRIPTION("A simple example Linux module.");
MODULE_VERSION("0.01");
#define DEVICE_NAME "lkm_example"
#define EXAMPLE_MSG "Hello, World!\n"
#define MSG_BUFFER_LEN 15
/* Prototypes for device functions */
static int device_open(struct inode *, struct file *);
static int device_release(struct inode *, struct file *);
static ssize_t device_read(struct file *, char *, size_t, loff_t *);
static ssize_t device_write(struct file *, const char *, size_t, loff_t *);
static int major_num;
static int device_open_count = 0;
static char msg_buffer[MSG_BUFFER_LEN];
static char *msg_ptr;
/* This structure points to all of the device functions */
static struct file_operations file_ops = {
 .read = device_read,
 .write = device_write,
 .open = device_open,
 .release = device_release
};
/* When a process reads from our device, this gets called. */
static ssize_t device_read(struct file *flip, char *buffer, size_t len, loff_t *offset) {
 int bytes_read = 0;
 /* If we’re at the end, loop back to the beginning */
 if (*msg_ptr == 0) {
 msg_ptr = msg_buffer;
 }
 /* Put data in the buffer */
 while (len && *msg_ptr) {
 /* Buffer is in user data, not kernel, so you can’t just reference
 * with a pointer. The function put_user handles this for us */
 put_user(*(msg_ptr++), buffer++);
 len--;
 bytes_read++;
 }
 return bytes_read;
}
/* Called when a process tries to write to our device */
static ssize_t device_write(struct file *flip, const char *buffer, size_t len, loff_t *offset) {
 /* This is a read-only device */
 printk(KERN_ALERT "This operation is not supported.\n");
 return -EINVAL;
}
/* Called when a process opens our device */
static int device_open(struct inode *inode, struct file *file) {
 /* If device is open, return busy */
 if (device_open_count) {
 return -EBUSY;
 }
 device_open_count++;
 try_module_get(THIS_MODULE);
 return 0;
}
/* Called when a process closes our device */
static int device_release(struct inode *inode, struct file *file) {
 /* Decrement the open counter and usage count. Without this, the module would not unload. */
 device_open_count--;
 module_put(THIS_MODULE);
 return 0;
}
static int __init lkm_example_init(void) {
 /* Fill buffer with our message */
 strncpy(msg_buffer, EXAMPLE_MSG, MSG_BUFFER_LEN);
 /* Set the msg_ptr to the buffer */
 msg_ptr = msg_buffer;
 /* Try to register character device */
 major_num = register_chrdev(0, "lkm_example", &file_ops);
 if (major_num < 0) {
 printk(KERN_ALERT "Could not register device: %d\n", major_num);
 return major_num;
 } else {
 printk(KERN_INFO "lkm_example module loaded with device major number %d\n", major_num);
 return 0;
 }
}
static void __exit lkm_example_exit(void) {
 /* Remember — we have to clean up after ourselves. Unregister the character device. */
 unregister_chrdev(major_num, DEVICE_NAME);
 printk(KERN_INFO "Goodbye, World!\n");
}
/* Register module functions */
module_init(lkm_example_init);
module_exit(lkm_example_exit);



# On édite ensuite le Makefile

obj-m += lkm_example.o
all:
        make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
clean:
        make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
test:
        # We put a — in front of the rmmod command to tell make to ignore
        # an error in case the module isn’t loaded.
        rmmod lkm_example
        dmesg -C
        insmod lkm_example.ko
        dmesg


# On recompile
make


# On test et récupère le "Device major Number"
make test


# On créer un fichier pour parler à notre module 
mknod /dev/lkm_example c <NUM-MAJOR> 0

# On vérifie le bon fonctionnement de notre module à travers le fichier

cat /dev/lkm_example


```


