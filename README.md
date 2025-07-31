## Documentation

## Summary :

- All parts done & tested (including bonus).
- VMs are on AWS, links for deployed apps: [(VM for parts 2 & 3)](http://13.61.180.46:4000/), [(VM for part 4)](http://16.171.253.238:4000/)
- VM configuration for parts (2, 3 & 4) is done totally using Ansible, I didn't touch the terminal of any VM ! (except for debugging)
- There is a separate repo that contains the work for parts 2, 3 & 4. Check : [DevOps-files](https://github.com/hosain-ghoraba/devops-ansible-playbooks)
- Ansible vault is used to store sentitive data (MongoDB url, Github PAT for accessing private images..etc)..the vault file is encrypted & then pushed to the repo, but decryption key (which is the same as encryption key) exists only on my local machine.

## Part 1

- [Dockerfile](./Dockerfile)
- [docker-compose.yaml](./compose.yaml)
- [CI Pipeline](./.github/workflows/ci-pipeline.yml)
- Choosen docker registry : ghcr (for easy integration with GitHub Actions)
- Note that I removed hardcoded port value from "./index.js", and used it as an environment variable.

## Part 2

- [Ansible playbook](https://github.com/hosain-ghoraba/devops-ansible-playbooks/blob/main/part-2/part2-install-docker.yml)

## Part 3

- Deployment on AWS: [Here](http://13.61.180.46:4000/)
- Created [docker compose file](https://github.com/hosain-ghoraba/devops-ansible-playbooks/blob/main/part-3/part3-compose.yaml) to run the application, and used an [Ansible playbook](https://github.com/hosain-ghoraba/devops-ansible-playbooks/blob/main/part-3/part3-deploy_app.yml) to copy it from local machine to the VM and run it.

- Health checks : Done in Docker Compose by periodically checking its HTTP endpoint

- Choosed [Watchtower](https://containrrr.dev/watchtower/) as auto update tool, for its simblicity and ease of integration with docker compose.

- Full CI/CD workflow works well with private images (authentication of docker compose with ghcr works well)

## Part 4

- Deployment on AWS: [Here](http://16.171.253.238:30080/)

- Used an [Ansible notebook](https://github.com/hosain-ghoraba/devops-ansible-playbooks/blob/main/part-4/part4-kubernetes.yml) to install Kubernetes, ArgoCD & ArgoCD Image Updater on the VM

- Main YAML Manifests :

  - [deployment.yaml](https://github.com/hosain-ghoraba/devops-ansible-playbooks/blob/main/part-4/todo-list-k8s-manifests/deployment.yaml) : Deploys the application onto the Kubernetes cluster

  - [service.yaml](https://github.com/hosain-ghoraba/devops-ansible-playbooks/blob/main/part-4/todo-list-k8s-manifests/service.yaml) : Exposes the app outside kubernetes cluster

  - [argocd-application.yaml](https://github.com/hosain-ghoraba/devops-ansible-playbooks/blob/main/part-4/todo-list-k8s-manifests/argocd-application.yaml) : Manages the automated deployment and synchronization of the app using ArgoCD

- Note: full CI/CD workflow works for part 4 if the image is made public, but I was not able to make automatic CD work when the image is private, because I couldn't authenticate image updater with the private image on ghcr, I tried very hard to make it work but for some reason it didn't, so I made the image public, and the workflow worked well.
