export VERSION=v3.5.0

kubectl create namespace argo
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/$VERSION/install.yaml

kubectl patch deployment argo-server --namespace argo --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": ["server","--auth-mode=server"]}]'

kubectl -n argo port-forward deployment/argo-server 2746:2746


kubectl delete -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.4.10/install.yaml

kubectl create -n argo role jenkins --verb=list,get,patch,update --resource=workflows.argoproj.io,pods
kubectl create -n argo sa jenkins
kubectl create -n argo rolebinding jenkins --role=jenkins --serviceaccount=argo:jenkins

kubectl -n argo apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: jenkins.service-account-token
  annotations:
    kubernetes.io/service-account.name: jenkins
type: kubernetes.io/service-account-token
EOF

ARGO_TOKEN="Bearer $(kubectl get secret -n argo jenkins.service-account-token -o=jsonpath='{.data.token}' | base64 --decode)"
echo $ARGO_TOKEN


export ARGO_SERVER='localhost:2746'
export ARGO_HTTP1=true
export ARGO_SECURE=true
export ARGO_BASE_HREF=
export ARGO_TOKEN=""
export ARGO_NAMESPACE=argo ;# or whatever your namespace is
export KUBECONFIG=/dev/null ;# recommended
export ARGO_INSECURE_SKIP_VERIFY=true
