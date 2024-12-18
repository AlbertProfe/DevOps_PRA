---
title: "Laboratorio 6"
---

## Documentacion cureso DevOPs



* #### Fuentes oficiales para el laboratorio
    +  Documentacion pagina  [Albert Profe](https://albertprofe.dev)
    +  Documentacion oficial Github [GitHub](https://github.com/g)
    +  Documentacion oficial Jenkins [Jenkins](https://www.jenkins.io/doc/book/)
    +  Documentacion oficial AWS [AWS](hhttps://aws.amazon.com/es/documentation-overview/?nc2=h_ql_doc_do)<br>
  

* #### Creacion de la cuenta de AWS
* Una vez creada la cuenta de amazon y elegido el plan gratuito 
  proseguiremos con el laboratorio
* Creare el budget y la alerta  desde la configuracion budgets 
* En Amazon ECR Creare repositorio con el nombre spring-boot-Repo 
* En Amazon ECS Creare el clúster, lo creare con Fargate para no crear la maquina virtual entera
* En Amazon ECS, creare  una nueva  task Escogiendo  Fargate como motor de del task tambien definire la  CPU y memoria  ram 


-- En aquesta part per fer el push a docker no he conseguit que em puji a ECR --


* #### Push del docker hub a ECR AWS

  + desde la consola del cloudshell pondre estos comandos
     * aws ecr-public get-login-password --region us-east-1 | 
       docker login --username AWS --password-stdin public.ecr.aws/t6n8o5j9
     * docker pull pedro052/books
     * docker tag pedro052/books:latest public.ecr.aws/t6n8o5j9/spring-boot-repsitori:l
     * docker push public.ecr.aws/t6n8o5j9/spring-boot-repsitori:latest

##### tot seguit intentare fer la pipeline desde el meu dockerhub

#### Pipeline en jenkins


     pipeline {
            agent any

            environment {
                AWS_ACCOUNT_ID="Id_Amazon"
                AWS_DEFAULT_REGION="eu-central-1"
                IMAGE_REPO_NAME="pedro052/books"
                MAGE_TAG="${latest}"
                REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${pedro052/books}"
            }

            stages {
                // Previous stages (build, test) here

                stage('Push to ECR') {
                    steps {
                        script {
                            sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                            sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
                            sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
                        }
                    }
                }

                stage('Deploy to ECS') {
                    steps {
                        script {
                            sh "aws ecs update-service --cluster your-cluster-name --service your-service-name --force-new-deployment"
                        }
                    }
                }
            }
        }

##### finalitzacio del exercici

* he intentat fer el deploi pro no he pogut fer el docker pull a ERC 
* he intentat que a la paipline de jenkins me agafes la imatge
  per pujarla automaticament pro no ha complilat