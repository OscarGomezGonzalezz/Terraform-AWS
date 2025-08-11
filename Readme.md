# Guide for how deploying AWS services with terraform

### 1º Login with your aws access key:
```
aws configure
```
### 2º Initialize the terraform script:
```
terraform init
terraform plan (for checking what will be deployed)
```
IMPORTANT: Check that everything you will deploy is inside the [always-free plan](https://aws.amazon.com/es/free/?ams%23interactive-card-vertical%23pattern-data-339318104.filter=%257B%2522filters%2522%253A%255B%257B%2522id%2522%253A%2522GLOBAL%2523local-tags-free-tier-products-plan-type.and%2522%252C%2522value%2522%253A%255B%2522always-free%2522%255D%257D%255D%257D)
### 3º Execute the terraform script:
```
terraform apply
```
### 4º Clean up the resources after using them:
```
terraform destroy
```