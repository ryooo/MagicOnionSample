# 構築
## clone
git clone xxx

## IDE
- Rider

## minikube
```sh
minikube start \
  --kubernetes-version 1.18.17 \
  --vm \
  --cpus 4 \
  --memory 8gb \
  --disk-size 20gb \
  --addons=dashboard \
  --addons=metrics-server
```
※ kubernetesについて2021/4時点の最新（1.21.0）だとagones-mutation-webhookのcaBundleが以下のエラーを引き起こす模様。
```
Error from server (InternalError): error when creating "./Kubernetes/game_server.yaml": Internal error occurred: failed calling webhook "mutations.agones.dev": Post "https://agones-controller-service.agones-system.svc:443/mutate?timeout=10s": x509: certificate relies on legacy Common Name field, use SANs or temporarily enable Common Name matching with GODEBUG=x509ignoreCN=0
```
※ Agonesのチュートリアルページで公式確認済みのバージョンを使う。

## Server Build
```sh
# minikube内のdockerを利用するための環境変数設定
eval $(minikube docker-env)
docker build -t hekk/g-server .
```

## Agones
```sh
kubectl create namespace agones-system

# Agones Install
# 2021/4での最新
kubectl apply -f https://raw.githubusercontent.com/googleforgames/agones/release-1.13.0/install/yaml/install.yaml

# Fleetを作成(Agones systemが起動するまで1分ほど待ってから)
kubectl apply -f ./Kubernetes/g_server.yaml

# GameServerAllocationを作成
kubectl apply -f ./Kubernetes/g_server_allocation.yaml

kubectl get gs -w
```

# Client
https://github.com/Cysharp/MagicOnion/releases/tag/4.2.0
https://github.com/neuecc/MessagePack-CSharp/releases/tag/v2.1.152
https://packages.grpc.io/archive/2021/04/4f81c3b706deed639cf4ecc9f3fc97da36230899-afd74cad-163d-41a6-bda1-22ef59b48e33/csharp/grpc_unity_package.2.38.0-dev202104120954.zip