# Post-Install 

Pour donner des droits Root à USER
```
/sbin/usermod -a -G sudo USER
```

Pour configurer les locales

> .bashrc

```
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="/sbin:$PATH"
```

```
locale-gen en_US.UTF-8
dpkg-reconfigure locales
```
