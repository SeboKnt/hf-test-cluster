#!/bin/bash

# This script is used to encrypt the secrets in the autoscaler
# Must be run manually from the user's machine
# Prerequisites: Admin access to the cluster

kubectl create secret generic hcloud-token-secret \ 
    --from-file=hcloud-token-secret.yaml \
    --dry-run=client -o json | kubeseal --format yaml > hcloud-token-secret-sealed.yaml
    
kubectl create secret generic cloud-init-secret \
    --from-file=hcloud-token-secret.yaml \
    --dry-run=client -o json | kubeseal --format yaml > hcloud-token-secret-sealed.yaml