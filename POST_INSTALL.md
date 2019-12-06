# Post-Install 

Pour donner des droits Root à USER
```
usermod -a -G sudo USER
```

Pour configurer les locales

> .bashrc

```
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

```
locale-gen en_US.UTF-8
dpkg-reconfigure locales
```
