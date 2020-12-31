# Rails Packer Ansible Serverspec

## Stacks
- [AWS CLI](https://aws.amazon.com/jp/cli/)
- [Packer](https://www.packer.io/)
- [Ansible](https://www.ansible.com/)
- [Vagrant](https://www.vagrantup.com/)
- [Serverspec](https://serverspec.org/)

## AWS

create iam user.

```sh
$ aws iam create-user --user-name rails-packer-ansible-serverspec
$ aws iam create-policy \
  --policy-name rails-packer-ansible-serverspec \
  --policy-document file://policy.json
$ aws iam attach-user-policy \
  --user-name rails-packer-ansible-serverspec \
  --policy-arn arn:aws:iam::ACCONT_ID:policy/rails-packer-ansible-serverspec
$ aws iam create-access-key --user-name rails-packer-ansible-serverspec
```
### Cleaning

```sh
$ aws iam detach-user-policy \
  --user-name rails-packer-ansible-serverspec \
  --policy-arn arn:aws:iam::ACCONT_ID:policy/rails-packer-ansible-serverspec
$ aws iam delete-policy --policy-arn arn:aws:iam::ACCONT_ID:policy/rails-packer-ansible-serverspec
$ aws iam delete-access-key \
  --access-key-id ACCESSKEY_ID \
  --user-name rails-packer-ansible-serverspec
$ aws iam delete-user --user-name rails-packer-ansible-serverspec
```

## Packer

### Install
```sh
$ brew tap hashicorp/tap
$ brew install hashicorp/tap/packer
$ packer --version
1.6.6
```

### Build Image

```sh
$ packer inspect rails.json

$ packer validate rails.json

$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"

$ packer build rails.json
```

## Deregister Image

```sh
$ aws ec2 deregister-image --image-id IMAGE_ID
```

## Ansible

### Install

```sh
$ brew install ansible
$ ansible --version
ansible 2.10.4
```

### Provision

- Nginx
- Ruby
- Node.js
- systemd

## Serverspec
