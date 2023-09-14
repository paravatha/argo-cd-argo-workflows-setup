# argo cd setup

## install

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
## UI

```
kubectl port-forward svc/argocd-server -n argocd 8080:443

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

## delete

```
kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## sa and token

```
argocd admin initial-password -n argocd
argocd login 127.0.0.1:8080
```

```
argocd cluster add rancher-desktop
kubectl config set-context --current --namespace=argocd
```

```
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default
```

