# Cloud_project
# Securing Container Deployments with Cosign 
Enforced secure image deployment in Kubernetes using Sigstore Policy Controller and Cosign by verifying container signatures with stored public keys.
## Key generation and signing
```shell
  cosign generate-key-pair
```
This command generates two key files `cosign.key` and `cosign.pub`.
Push the Docker image you want to sign into a container registry and sign it using cosign.key
```shell
  docker push docker.io/yourname/yourimage:tag
  cosign sign --key cosign.key docker.io/yourname/yourimage:tag
```
## Enforcing Image Signature Verification in Kubernetes
Install `policy-controller` using Helm:

```shell
helm repo add sigstore https://sigstore.github.io/helm-charts
helm repo update
kubectl create namespace cosign-system
helm install policy-controller -n cosign-system sigstore/policy-controller --devel
```
Apply the label to enable policy enforcement in your namespace:
```shell
kubectl label namespace default policy.sigstore.dev/include=true
```
Store cosign public key in kubernetes secret
```shell
kubectl create secret generic mysecret -n cosign-system --from-file=cosign.pub=./cosign.pub
```
Apply cluster-image-policy.yaml to specify trusted signers and image rules.
```shell
kubectl apply -f cluster-image-policy.yaml
```
Validate secure deployment
```shell
kubectl apply deploy_signed.yaml
kubectl apply deploy_unsigned.yaml
```



