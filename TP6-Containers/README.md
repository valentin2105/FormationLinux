# TP6-Containers


### Objectif:


> Installer et utiliser Docker
> Créer notre première image Docker pour une application en Python puis la déployer sur un registre Privé. 

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

# Pour cela, on va déjà la lancer sur notre machine, on installe les dépendances
apt-get install -y python3 python3-pip
pip3 install flask jsonify

# On peut maintenant lancer notre code Python
python3 app.py


# Maintenant que notre application fonctionne normalement sur notre machine, on peut commencer à créer son Manifest pour pouvoir construire l'image de notre application.

> Pour cela nous allons créer un Dockerfile
...
```


