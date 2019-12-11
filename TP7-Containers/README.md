# TP7-Containers


### Objectif:


> Installer et utiliser Docker

> Créer notre première image pour une application Python puis la déployer sur un registre privé. 

> Installer Portainer pour gérer nos containers

> Utiliser Docker-compose pour déployer une stack Wordpress

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


# On va lancer notre vrai premier container
docker run -it docker.ntl.nc/debian:buster bash

```
### PyApp
```
# On va builder notre première image
cd TP7-Containers/PyApp

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

## Registre privé

```
$ docker run -d  \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  -v /mnt/registry:/var/lib/registry \
  docker.ntl.nc/registry


$ docker tag MY_IMAGE localhost:5000/my-image

$ docker push localhost:5000/my-image
```

## Portainer 

```
$ docker volume create portainer_data
$ docker run -d -p 8000:8000 -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data docker.ntl.nc/portainer:latest
```

## k3s

```
curl -sfL https://get.k3s.io | sh -
        
# Wait 30s
k3s kubectl get node
	  

sudo k3s server &
# Kubeconfig is written to /etc/rancher/k3s/k3s.yaml
sudo k3s kubectl get node

# On a different node run the below. NODE_TOKEN comes from /var/lib/rancher/k3s/server/node-token
# on your server
sudo k3s agent --server https://myserver:6443 --token ${NODE_TOKEN}

```

## Minikube
```
$ sudo apt-get install -y apt-transport-https
$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
$ sudo touch /etc/apt/sources.list.d/kubernetes.list 
$ echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
$ sudo apt-get update
$ sudo apt-get install -y kubectl
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.5.2/minikube-linux-amd64
$ chmod +x minikube && sudo mv minikube /usr/local/bin/

$ minikube start
$ kubectl api-versions
```
