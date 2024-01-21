kubeseal --controller-name=sealed-secrets --controller-namespace=kube-system  -f flux-s3-secret.yaml -o yaml > flux-s3-sealed-secret.yaml



### Backup the private key
kubectl get secret -n kube-system -l sealedsecrets.bitnami.com/sealed-secrets-key -o yaml > main.key

echo "---" >> main.key
kubectl get secret -n kube-system sealed-secrets-key -o yaml >> main.key