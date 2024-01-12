#!/bin/bash

# This script is used to encrypt the secrets in the autoscaler
# Must be run manually from the user's machine
# Prerequisites: Admin access to the cluster

# Fetch the public cert used for encryption and store it locally
kubeseal \
  --controller-name=sealed-secrets \
  --controller-namespace=kube-system \
  --fetch-cert > mycert.pem

kubectl create secret generic hcloud \
    --namespace=kube-system \
    --from-literal=token=<hloudToken>== \
    --dry-run=client -o yaml | \
kubeseal \
  --controller-name=sealed-secrets \
  --controller-namespace=kube-system \
  --format yaml --cert mycert.pem > hcloud-token-secret-sealed.yaml

# node token: /var/lib/rancher/rke2/server/node-token
ENCODED_DATA=$(base64 cloud-init.txt | tr -d '\n')
kubectl create secret generic cloud-init \
    --namespace=kube-system \
    --from-literal=data="$ENCODED_DATA" \
    --dry-run=client -o yaml | \
kubeseal \
  --controller-name=sealed-secrets \
  --controller-namespace=kube-system \
  --format yaml --cert mycert.pem > cloud-init-secret-sealed.yaml