# TP2-Installation


### Objectif:

> Utiliser l'outil Debootstrap pour créer un système Ubuntu dans notre Debian.


### Procédure:

```
apt install debootstrap

mkdir ubuntu
debootstrap --arch=amd64 bionic ubuntu/ http://ubuntu.nautile.nc/ubuntu/


chroot ubuntu/


apt-get update


```
