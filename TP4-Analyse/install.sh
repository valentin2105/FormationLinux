#!/bin/bash

apt-get update && apt-get install -y apache2

# Changer le port apache vers 81
sed -i 's/Listen 80/Listen 81/g' /etc/apache2/ports.conf 
service apache2 restart

# Install et démarre Nginx
apt-get install -y nginx
sed -i 's/index index.html index.htm index.nginx-debian.html/index index.nginx-debian.html/g' /etc/nginx/sites-enabled/default
echo "Hello World from apache2" > /var/www/html/index.nginx-debian.html 
service nginx restart

# Changer les droits des fichiers www
chmod 400 /var/www/index.html

# Firewall close port 80
iptables -A INPUT -p tcp --dport http -j REJECT


