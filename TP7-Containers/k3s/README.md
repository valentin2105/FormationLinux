## k3s

```
export KUBECONFIG="$(k3d get-kubeconfig --name='dev')" 

# Kubetail
wget https://raw.githubusercontent.com/johanhaleby/kubetail/master/kubetail && chmod +x kubetail && sudo mv kubetail /usr/local/bin
```

