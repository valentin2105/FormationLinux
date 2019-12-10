# TP5-Supervision


### Objectif:

> Installer une système de supervision sur notre serveur, Netdata pour les métriques et Monit pour les services.

> Configurer un système de backup incrémental sur notre serveur avec Rsnapshot sur le RAID précédemment configuré.


### Procédure:

Monitoring / Supervision

```
echo "deb http://deb.debian.org/debian buster-backports main contrib non-free" > /etc/apt/sources.list.d/backport.list
apt-get update

# On install les paquets depuis APT
apt-get install -y rsync monit curl

# On installe Netdata depuis leur site. 
bash <(curl -Ss https://my-netdata.io/kickstart-static64.sh)
service netdata status

# On configure Monit
vim /etc/monit/monit.conf

set httpd port 2812
allow admin:monit

# On vérifie son bon fonctionnement
monit summary
monit status

# On peut créer le fichier /etc/monit/conf.d/apache2.conf

check process apache2 with pidfile /run/apache2/apache2.pid
    start program = "/bin/systemctl start apache2.service" with timeout 15 seconds
    stop program  = "/bin/systemctl stop apache2.service"
    restart program = "/bin/systemctl restart apache2.service"

# Et relancer Monit
service monit restart

# On vérifie notre nouveau service monitoré
monit summary
monit status

# On active maintenant nos nouveaux services au démarrage
systemctl enable monit
systemctl enable netdata
```

Backup incrémental (rsnapshot)

```
apt-get update && apt-get install rsnapshot

# La configuration de rsnapshot se fait dans /etc/rsnapshot.conf

> Mettre en place le backup de notre répertoire /var/www/html dans /mnt/lvbtrfs

# On télécharge restic
cd /opt && wget https://github.com/restic/restic/releases/download/v0.9.6/restic_0.9.6_linux_amd64.bz2


```

Backup chiffré (restic)

```
# On télécharge restic
cd /opt && wget https://github.com/restic/restic/releases/download/v0.9.6/restic_0.9.6_linux_amd64.bz2

# On décompresse
bzip2 -d restic_0.9.6_linux_amd64.bz2

chmod +x restic_0.9.6_linux_amd64
mv restic_0.9.6_linux_amd64 /usr/local/bin/restic

# On initialise le dépôt
restic init --repo /mnt/lvbtrfs/backup/restic
enter password for new repository: PASSWORDCHIFFREMENT
enter password again: PASSWORDCHIFFREMENT


# On backup le dossier /root
restic backup /root --repo /mnt/lvbtrfs/backup/restic/


# On liste les backups
restic snapshots --repo /mnt/lvbtrfs/backup/restic/
```
