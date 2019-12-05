# TP2-Kernel

### Objectif:

> Créer, compiler et charger un module du Noyau.
> Créer un paquet Debian DKMS un module Intel pour carte réseau non présent dans le Noyau.

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


Maintenant on va réaliser un cas concret,

Installer un module du Noyau pour un pilote de Carte réseau Intel XXV710-DA2 (i40e).

Pour cela nous allons réaliser un paquet Debian (.deb) qui va empacter le module i40e et le compiler grâce à DKMS.


```
cd TP2-Kernel/ModuleDKMS

# On décompresse les sources du pilote
tar -zxvf i40e-2.10.19.30.tar.gz

# On déplace la définition de notre paquet dans le dossier du pilote
mv debian/ i40e-2.10.19.30/
cd i40e-2.10.19.30/


# On installe les dépendances nécéssaires à la construction du paquet
apt update && apt install -y build-essential fakeroot debhelper


# On peut maintenant builder notre paquet .deb
 dpkg-buildpackage --no-sign


# On peut maintenant l'installer 
cd ../
dpkg -i i40e-dkms_2.4.6-0_all.deb

# On liste les modules DKMS
dkms status

# On inspecte notre pilote
modinfo i40e
```
