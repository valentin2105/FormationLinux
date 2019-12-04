# TP2-Kernel

### Objectif:

> Créer, compiler et charger un module du Noyau.
> Compiler avec DKMS le module ZFS puis formater et monter une partition ZFS

### Procédure:

```
# On installe les headers du noyau
apt install linux-headers-`uname -r` build-essential

# On compile notre module de noyau
cd TP2-Kernel/Module1
make
ls -alh

# On charge notre module dans le noyau
insmod lkm1.ko

# On vérifie son fonctionnement
dmesg
lsmod |grep lkm  

# On le désactive
rmmod lkm1
dmesg
```

Notre module est pas très utile, allons un peu plus loin :

```
cd TP2-Kernel/Module2
# On compile
make

# On test et récupère le "Device major Number"
make test

# On créer un fichier dans /dev pour parler à notre module 
mknod /dev/lkm2 c <NUM-MAJOR> 0

# On vérifie le bon fonctionnement de notre module à travers le fichier
cat /dev/lkm2

# On désactive notre module
rm /dev/lkm2
rmmod lkm2
```


Maintenant on va compiler le module Noyau ZFS avec DKMS afin de pouvoir créer et monter une partition ZFS. 


```
echo deb http://deb.debian.org/debian buster contrib >> /etc/apt/sources.list
echo deb http://deb.debian.org/debian buster-backports main contrib >> /etc/apt/sources.list
apt update

apt install --yes debootstrap gdisk dkms dpkg-dev linux-headers-$(uname -r)
apt install --yes -t buster-backports zfs-dkms

modprobe zfs

zpool create -f files /dev/sda
```
