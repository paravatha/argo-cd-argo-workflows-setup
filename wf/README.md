# argo workflow setup

export VERSION=v3.4.11

## install

```
install.sh
```
## UI

```
kubectl -n argo port-forward deployment/argo-server 2746:2746
```

## delete

```
kubectl delete -n argo -f https://github.com/argoproj/argo-workflows/releases/download/$VERSION/install.yaml
```

## sa and token

```
kubectl apply -f role.yaml
kubectl create -n argo sa argo-sa
kubectl create -n argo rolebinding argo-sa --role=argo-sa --serviceaccount=argo:argo-sa
kubectl apply -f secret.yaml
```

```
ARGO_TOKEN="$(kubectl get secret -n argo argo-sa.service-account-token -o=jsonpath='{.data.token}' | base64 --decode)"
echo $ARGO_TOKEN
```

```
export ARGO_SERVER='localhost:2746'
export ARGO_HTTP1=true
export ARGO_SECURE=true
export ARGO_BASE_HREF=
export ARGO_TOKEN=""
export ARGO_NAMESPACE=argo ;# or whatever your namespace is
export KUBECONFIG=/dev/null ;# recommended
export ARGO_INSECURE_SKIP_VERIFY=true
```

