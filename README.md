# Terraform AWS EKS Environment

Este projeto provisiona uma infraestrutura **AWS completa e profissional** utilizando **Terraform**, com foco em boas práticas de mercado, segurança, modularização e controle de custos.

O objetivo é criar um **ambiente de estudo realista**, próximo de produção, envolvendo **EKS, RDS, ECR e VPC customizada**, sem exagerar em recursos para evitar custos desnecessários.

---

## 🧱 Arquitetura

A infraestrutura criada inclui:

- **VPC dedicada**
  - Subnets públicas e privadas
  - Internet Gateway
  - NAT Gateway (configuração econômica)
- **Amazon EKS**
  - Cluster Kubernetes gerenciado
  - Node Group mínimo para estudo
  - Nodes em subnets privadas
- **Amazon RDS (PostgreSQL)**
  - Banco privado (sem acesso público)
  - Free Tier friendly
- **Amazon ECR**
  - Repositório para imagens Docker
- **Terraform Remote Backend**
  - State armazenado no S3
  - Lock de state via DynamoDB

Arquitetura em alto nível:

VPC
├── Public Subnets
│ ├── Internet Gateway
│ └── NAT Gateway
│
├── Private Subnets
│ ├── EKS Node Group
│ └── RDS (PostgreSQL)
│
└── S3 + DynamoDB (Terraform Backend)


---

## 📁 Estrutura do Projeto

.
├── bootstrap/ # Criação do backend remoto (S3 + DynamoDB)
├── envs/
│ └── dev/ # Ambiente de desenvolvimento
├── modules/
│ ├── vpc/
│ ├── eks/
│ ├── rds/
│ └── ecr/
├── backend.tf # Configuração do backend remoto
├── providers.tf # Providers
├── versions.tf # Versões do Terraform e providers
└── README.md


---

## 🔐 Backend Remoto (Terraform State)

O projeto utiliza **S3 + DynamoDB** para armazenar e travar o state do Terraform, seguindo o padrão profissional utilizado em ambientes reais.

O backend é criado separadamente no diretório `bootstrap/` para evitar dependência circular.

---

## 🚀 Como usar

### Pré-requisitos

- AWS CLI configurado
- Terraform >= 1.5
- Conta AWS ativa
- Acesso SSH configurado para o GitHub

---

### 1️⃣ Criar o backend remoto

```bash
cd bootstrap
terraform init
terraform apply
