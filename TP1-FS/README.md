# TP1-File System


### Objectif:

> Monter un RAID avec deux disque secondaire en utilisant mdadm. Puis créer une partition LVM afin de formater et monter un volume logique en BTRFS dans notre système. 


##### Procédure:

```
# On liste les disques et partitions
fdisk -l 

# On récupère le status du RAID
cat /proc/mdstat

# On liste les disques avec lsblk
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT

# On va formater en type RAID le disque /dev/sdb
fdisk /dev/sdb

# On va formater en type RAID le disque /dev/sdb
fdisk /dev/sdc

# On initialise le RAID
/usr/sbin/mdadm  --create /dev/md0 --level=mirror --raid-devices=2 /dev/sdb1 /dev/sdc1

# On affiche le détail du RAID 
/usr/sbin/mdadm  --detail /dev/md0

# On install lvm
apt update && apt instal lvm2


# On créer un VolumeGroup (VG)
vgcreate deb /dev/md0p1

# On vérifie
vgdisplay

# On créer un LogicalVolume (LV) pour accueillir notre partition BTRFS
lvcreate -L 1G  deb -n lvbrt

# On vérifie
lvs

# On install les outils BTRFS
apt install btrfs-tools 

# On formate notre LV (lvbrt) 
mkfs.btrfs /dev/mapper/deb-lvbrt

# On créer le point de montage
mkdir -p /mnt/lvbrt

# On édite le fichier fstab de montage des partitions
vim /etc/fstab
 
/dev/deb/lvbrt  /mnt/lvbrt      btrfs      rw,noatime,ssd,discard,autodefrag      0      0

# On monte notre partition
mount -a

# On vérifie
df -h
btrfs filesystem show 
```
