# TP3-Installation


### Objectif:

> Utiliser l'outil Debootstrap pour créer un système Ubuntu dans notre Debian.


### Procédure:

```
apt install debootstrap

mkdir ubuntu
debootstrap --arch=amd64 bionic ubuntu/ http://ubuntu.nautile.nc/ubuntu/


chroot ubuntu/


apt-get update
apt-get install apache2 
/etc/init.d/apache2 start

exit


curl localhost


echo "Hello World" > ubuntu/var/www/html/index.html

curl localhost

chroot ubuntu/ /etc/init.d/apache2 status


# On nettoie
chroot ubuntu/ /etc/init.d/apache2 stop
rm -rf ubuntu/
```
