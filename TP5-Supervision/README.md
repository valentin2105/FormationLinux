# TP5-Supervision


### Objectif:

> Installer une système de Supervision sur notre serveur, Netdata pour les métriques et Monit pour les services.
> Configurer un système de backup incrémental sur notre serveur avec Rsnapshot. 


### Procédure:

```
# On install les paquets depuis APT
apt-get install -y rsnapshot rsync monit curl


# On install et compile Netdata depuis leur site. 
bash <(curl -Ss https://my-netdata.io/kickstart-static64.sh)
service netdata status
```
