# TP1-File System


### Objectif:

> Monter un RAID avec deux disques secondaires en utilisant mdadm. Puis créer une partition LVM afin de formater et monter un volume logique en BTRFS dans notre système. 


### Procédure:

```
# On liste les disques et partitions
fdisk -l 

# On récupère le status du RAID
cat /proc/mdstat

# On liste les disques avec lsblk
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT

# On va formater en type RAID le disque /dev/sdb
fdisk /dev/sdb

n > nouvelle partition
p > primary
1 
ENTER
ENTER
p > montre les partitions
t > change le type
fd > Type Linux RAID
p > montre les partitions
w > écrit les infos sur le disque

# On va formater en type RAID le disque /dev/sdb avec cfdisk
cfdisk /dev/sdc

# On initialise le RAID avec mdadm
mdadm  --create /dev/md0 --level=mirror --raid-devices=2 /dev/sdb1 /dev/sdc1

# On affiche le détail du RAID 
mdadm  --detail /dev/md0

# On installe lvm
apt update && apt install lvm2

# On crée un VolumeGroup (VG)
vgcreate deb /dev/md0p1

# On vérifie
vgdisplay

# On créer un LogicalVolume (LV) pour accueillir notre partition BTRFS
lvcreate -L 1G  deb -n lvbtrfs

# On vérifie
lvs

# On install les outils BTRFS
apt install btrfs-tools 

# On formate notre LV (lvbtrfs) 
mkfs.btrfs /dev/mapper/deb-lvbtrfs

# On créer le point de montage
mkdir -p /mnt/lvbtrfs

# On édite le fichier fstab de montage des partitions
vim /etc/fstab
 
/dev/deb/lvbtrfs  /mnt/lvbtrfs      btrfs      rw,noatime,ssd,discard,autodefrag      0      2

# On monte notre partition
mount -a

# On vérifie
df -h
btrfs filesystem show 
```

On va ensuite détruire l'un de nos deux disques pour simuler une panne physique. 

```
shred /dev/sdc ... CTRL+C

# On marque le disque comme défaillant 
mdadm --manage /dev/md0 --fail /dev/sdc1

cat /proc/mdstat
```

On peut maintenant simuler qu'on change le disque et qu'on l'ajoute dans le RAID
```
# On supprime le disque du RAID
mdadm --manage /dev/md0 --remove /dev/sdc1

# On ajoute le nouveau disque
...

# On copie la table de partition du disque valide vers le nouveau disque
sfdisk -d /dev/sdb | sfdisk --force /dev/sdc

# On ajoute le nouveau disque dans le RAID
mdadm --add /dev/md0 /dev/sdc1

/usr/sbin/mdadm  --detail /dev/md0
cat /proc/mdstat
```

