#!/bin/bash

# This script is used to encrypt the secrets in the autoscaler
# Must be run manually from the user's machine
# Prerequisites: Admin access to the cluster


# echo -n 'token' | base64
kubectl create secret generic hcloud \
    --namespace=kube-system \
    --from-file=hcloud-token-secret.yaml \
    --dry-run=client -o json | kubeseal --format yaml \
        --controller-name=sealed-secrets \
        --controller-namespace=kube-system > hcloud-token-secret-sealed.yaml

# base64 /pfad/zur/datei
kubectl create secret generic cloud-init \
    --namespace=kube-system \
    --from-file=cloud-init-secret.yaml \
    --dry-run=client -o json | kubeseal --format yaml \
        --controller-name=sealed-secrets \
        --controller-namespace=kube-system > cloud-init-secret-sealed.yaml

