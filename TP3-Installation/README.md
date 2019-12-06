# TP3-Installation


### Objectif:

> Utiliser l'outil Debootstrap pour créer un système Ubuntu dans notre Debian.


### Procédure:

```
# On installe Debootstrap
apt install debootstrap

# On lance debootstrap dans un dossier ubuntu/ en demandant la version "Bionic"
mkdir ubuntu
debootstrap --arch=amd64 bionic ubuntu/ http://ubuntu.nautile.nc/ubuntu/


# On se chroot dans notre nouveau Ubuntu (change root)
chroot ubuntu/

# On installe Apache2 dans notre Ubuntu
apt-get update
apt-get install apache2 

# On le démarre et sort du chroot
/etc/init.d/apache2 start
exit

# On vérifie depuis l'hôte que le serveur est joignable
curl localhost

# On change le fichier HTML dans le chroot
echo "Hello World" > ubuntu/var/www/html/index.html


# On vérifie que le serveur sert bien les fichier de notre chroot
curl localhost

# On peut lancer des commandes directement dans le chroot comme ceci
chroot ubuntu/ /etc/init.d/apache2 status

# On nettoie
chroot ubuntu/ /etc/init.d/apache2 stop
rm -rf ubuntu/
```
