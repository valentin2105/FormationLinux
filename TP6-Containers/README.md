# TP6-Containers


### Objectif:


> Installer et utiliser Docker

> Créer notre première image pour une application Python puis la déployer sur un registre privé. 

### Procédure:

```
# On va commencer par installer Docker
apt-get install -y apt-transport-https ca-certificates gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

service docker start


# On vérifie le bon fonctionnement 
docker ps
docker run hello-world

# On va builder notre première image
cd TP6-Containers/PyApp

# On va déjà lancer l'application Python sur notre machine, pour cela, on installe les dépendances 
apt-get install -y python3 python3-pip
pip3 install flask jsonify

# On peut maintenant lancer notre code Python
python3 app.py


# Maintenant que notre application fonctionne normalement sur notre machine,
# on peut commencer à créer son manifeste (Dockerfile) pour pouvoir construire 
# l'image de notre application.
...
```

Registre privé

```
$ docker run -d  \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  -v /mnt/registry:/var/lib/registry \
  registry:2


$ docker tag MY_IMAGE localhost:5000/my-image

$ docker push localhost:5000/my-image
```

Portainer 

```
$ docker volume create portainer_data
$ docker run -d -p 8000:8000 -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
$ docker volume create portainer_data
```

