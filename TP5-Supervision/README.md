# TP5-Supervision


### Objectif:

> Installer une système de supervision sur notre serveur, Netdata pour les métriques et Monit pour les services.

> Configurer un système de backup incrémental sur notre serveur avec Rsnapshot sur le RAID précédemment configuré.


### Procédure:

Monitoring / Supervision

```
apt-get update

# On install les paquets depuis APT
apt-get install -y rsync monit curl

# On installe Netdata depuis leur site. 
curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh
service netdata status

# On configure Monit
nano /etc/monit/monitrc

# On met cela à la fin du fichier
set httpd port 2812
allow admin:monit

# On vérifie son bon fonctionnement
monit summary
monit status

# On peut créer le fichier /etc/monit/conf.d/nginx.conf

check process nginx with pidfile /var/run/nginx.pid
    start program = "/bin/systemctl start nginx.service" with timeout 15 seconds
    stop program  = "/bin/systemctl stop nginx.service"
    restart program = "/bin/systemctl restart nginx.service"

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

mkdir -p /srv/datas/backups

> Mettre en place le backup de notre répertoire /var/www/html dans /srv/datas/backups


```

Backup chiffré (restic)

```
# On télécharge restic
cd /opt && wget https://github.com/restic/restic/releases/download/v0.17.0/restic_0.17.0_linux_amd64.bz2

# On décompresse
bzip2 -d restic_0.17.0_linux_amd64.bz2

chmod +x restic_0.17.0_linux_amd64
mv restic_0.17.0_linux_amd64 /usr/local/bin/restic

# On initialise le dépôt
restic init --repo /srv/datas/backups/restic
enter password for new repository: PASSWORDCHIFFREMENT
enter password again: PASSWORDCHIFFREMENT


# On backup le dossier /root
restic backup /root --repo /srv/datas/backups/restic/


# On liste les backups
restic snapshots --repo /srv/datas/backups/restic/
```
