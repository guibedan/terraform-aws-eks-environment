# 🚀 Projeto de Estudo: AWS EKS + RDS com Terraform

![Terraform](https://img.shields.io/badge/Terraform-1.5%2B-7B42BC?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-326CE5?logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/Containers-Docker-2496ED?logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?logo=postgresql&logoColor=white)

Este projeto tem como objetivo criar um ambiente completo na AWS usando
Terraform, incluindo:

-   VPC com subnets públicas e privadas
-   ECR (repositórios de container)
-   IAM Roles para EKS
-   Cluster EKS com Node Group
-   Configuração de kubectl
-   Add-ons essenciais do Kubernetes
-   RDS (PostgreSQL) integrado ao EKS para testes
-   Bootstrap de infraestrutura para backend remoto do Terraform (S3 +
    DynamoDB)

------------------------------------------------------------------------

## 📁 Estrutura do Projeto

``` text
.
├── bootstrap/
│   ├── main.tf
│   ├── outputs.tf
│   ├── versions.tf
│   └── providers.tf

├── modules/
│   ├── vpc/
│   ├── eks/
│   ├── iam/eks/
│   ├── ecr/
│   └── rds/
├── envs/
│   └── dev/
│       ├── main.tf
│       └── backend.tf
└── README.md
```

-   `bootstrap/` → cria o S3 e DynamoDB para armazenar o **state
    remoto** e realizar **lock de estado** do Terraform\
-   `modules/` → módulos reutilizáveis do Terraform\
-   `envs/dev/` → configuração do ambiente de desenvolvimento\
-   `README.md` → documentação do projeto

------------------------------------------------------------------------

## 🧱 Bootstrap do Backend Remoto (S3 + DynamoDB)

Antes de aplicar a infraestrutura principal, é necessário criar os
recursos de backend do Terraform:

-   Bucket S3 para armazenar o **terraform.tfstate**
-   Tabela DynamoDB para **lock de state** (evita concorrência em
    execuções simultâneas)

### Passos

``` bash
cd bootstrap
terraform init
terraform plan
terraform apply
```

Após o bootstrap, configure o backend remoto nos ambientes (`envs/dev`):

``` hcl
terraform {
  backend "s3" {
    bucket         = "<nome-do-bucket>"
    key            = "envs/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "<nome-da-tabela>"
    encrypt        = true
  }
}
```

------------------------------------------------------------------------

## ✅ Pré-requisitos

-   Terraform \>= 1.14.4
-   AWS CLI configurada com credenciais válidas
-   kubectl instalado
-   Conta AWS com permissões para criar VPC, EKS, RDS, IAM, ECR, S3 e
    DynamoDB

------------------------------------------------------------------------

## 🧩 Fases do Projeto

### Fase 1: Criação da VPC

-   Criar VPC principal
-   2 subnets públicas
-   2 subnets privadas
-   Internet Gateway, NAT Gateway e Route Tables

Outputs: - `vpc_id` - `public_subnet_ids` - `private_subnet_ids` -
`nat_gateway_id`

### Fase 2: Repositórios ECR

-   Criar repositórios para cada aplicação
-   Configurar scan on push

Outputs: - `repository_url` - `repository_arn`

### Fase 3: IAM Roles para EKS

Criar roles: - `eks_cluster_role` - `eks_node_role`

Associar policies: - `AmazonEKSClusterPolicy` -
`AmazonEKSWorkerNodePolicy` - `AmazonEC2ContainerRegistryReadOnly` -
`AmazonEKS_CNI_Policy`

### Fase 4: Cluster EKS

-   Criar cluster EKS
-   Associar VPC e subnets privadas
-   Associar `cluster_role`

### Fase 5: Node Group

-   Criar Node Group
-   Associar `node_role`
-   Configurar quantidade de nodes
-   Configurar scaling (min, max, desired)

### Fase 6: Configurar kubectl

-   Gerar kubeconfig
-   Testar conexão:

``` bash
kubectl get nodes
```

### Fase 7: Add-ons essenciais

-   VPC CNI
-   CoreDNS
-   kube-proxy
-   (Opcional) metrics-server

### Fase 8: RDS

-   Criar Subnet Group em subnets privadas
-   Criar Security Group permitindo acesso apenas do EKS
-   Criar instância PostgreSQL
-   Instância privada (`publicly_accessible = false`)

### Fase 9: Integração EKS ↔ RDS

-   Criar Secret com credenciais
-   Subir pod de teste
-   Testar conexão com psql

------------------------------------------------------------------------

## ▶️ Instruções de Uso

``` bash
cd envs/dev
terraform init
terraform validate
terraform plan
terraform apply
kubectl get nodes
```

Teste do RDS:

``` bash
kubectl run psql-client --image=postgres:15 --restart=Never -- sleep 3600
kubectl exec -it psql-client -- psql -h <rds-endpoint> -U <user>
```

------------------------------------------------------------------------

## ⚠️ Observações

-   Node Group em Free Tier exige instâncias `t3.micro` ou superiores.
-   Se ocorrer erro de *Too many pods*, aumente nodes ou instâncias.
-   O RDS é privado e acessível apenas pelo EKS.
-   Em produção, ajuste segurança, escalabilidade, versionamento de
    state e políticas de acesso ao bucket S3.

------------------------------------------------------------------------

## 🏷️ Tags padrão

``` text
Environment = dev
Project     = eks-study
```

------------------------------------------------------------------------

## 🧠 Estrutura de Variáveis

-   `vpc_name`, `vpc_cidr`, `availability_zones`
-   `private_subnet_ids`, `public_subnet_ids`
-   `cluster_name`, `cluster_role_arn`, `node_role_arn`
-   `node_instance_type`, `node_desired_size`, `node_max_size`,
    `node_min_size`
-   `eks_node_sg_id`
