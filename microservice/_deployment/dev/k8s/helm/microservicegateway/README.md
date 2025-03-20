## Add Cert Manager repository to helm
`$ helm repo add jetstack https://charts.jetstack.io`\
`$ helm repo update`

## Install Cert Manager
`$ helm install certmanager jetstack/cert-manager -n cert-manager --create-namespace --version v1.12.0 --set "installCRDs=true,extraArgs={--feature-gates=ExperimentalGatewayAPISupport=true}"`

## Installing NGINX Fabric Gateway
### Installing the Gateway API resources
`$ kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.1" | kubectl apply -f -`

### Installing NGINX Fabric Gateway
`$ helm install ngf oci://ghcr.io/nginx/charts/nginx-gateway-fabric --create-namespace -n nginx-gateway --set nginxGateway.snippetsFilters.enable=true`

### Installing Resources
`$ helm install microservicegateway . -n microservice --create-namespace`
