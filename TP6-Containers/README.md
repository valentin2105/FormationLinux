# TP6-Containers


### Objectif:


> Installer et utiliser Docker
> Créer notre première image Docker pour une application en Python puis la déployer sur un registre Privé. 

### Procédure:

```
apt-get install apt-transport-https ca-certificates gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

apt-get update && apt-get install docker-ce docker-ce-cli containerd.io

service docker start

docker ps

docker run hello-world
```
