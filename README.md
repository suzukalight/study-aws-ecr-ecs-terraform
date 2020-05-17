# About

Terraform(AWS/Fargate) + Nodejs(GraphQL) + MySQL sample

## Using

- ECS (Fargate)
  - nodejs
    - graphql server
  - nginx
    - reverse proxy
- RDS (Aurora)
- Route53 + ACM
- ALB
- VPC

## Setup

## Run

### local

```
docker-compose up
```

## Deployment

### Setup ECR

```
cd terraform/roots/permanent
terraform init
terraform apply
```

### Upload docker image to ECR

```
$ yarn iac:push-image
```

### Setup servers for development

```
cd terraform/roots/dev
terraform init
terraform apply
```

## FAQ

### docker image がどんどんたまってしまう

> [Docker のあれこれを断捨離する](https://qiita.com/ksato9700/items/b0075dc54dfffc64b999)

```bash
$ docker image ls --filter dangling=true
$ docker image prune
```

```bash
$ docker container prune
$ docker volume prune
```

### docker-compose down を念入りに行う

> [《滅びの呪文》Docker Compose で作ったコンテナ、イメージ、ボリューム、ネットワークを一括完全消去する便利コマンド](https://qiita.com/suin/items/19d65e191b96a0079417)

```bash
docker-compose down --rmi all --volumes
```

### docker-compose up を念入りに行う

> [How to rebuild docker container in docker\-compose\.yml? \- Stack Overflow](https://stackoverflow.com/questions/36884991/how-to-rebuild-docker-container-in-docker-compose-yml)

```bash
docker-compose up -d --no-deps --build <service_name>
```

### `[emerg] host not found in upstream "app:23456" in /etc/nginx/nginx.conf:11`

Service Discovery を使って、AWS 上でも名称ベースでコンテナを見つけてもらえるようにする。

### `Error requesting certificate: LimitExceededException: Error: you have reached your limit of 20 certificates in the last year.`

証明書を設置できる数は 10、発行できる数はその 2 倍まで（20）なので、Quota に引っかかったエラー。

Terraform で ACM を通した証明書発行は、create_before_destroy しないようにする。

AWS サポートに問い合わせて、解除してもらう。
