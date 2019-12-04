obj-m += lkm2.o
all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
test:
	rmmod lkm2
	dmesg -C
	insmod lkm2.ko
	dmesg




