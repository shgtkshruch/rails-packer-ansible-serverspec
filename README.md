# Rails Packer Ansible Serverspec

Building and testing Amazon Linux 2 and Vagrant Box with Packer, Ansible and Serverspec.

## Stacks
- [AWS CLI](https://aws.amazon.com/jp/cli/)
- [Packer](https://www.packer.io/)
- [Ansible](https://www.ansible.com/)
- [Vagrant](https://www.vagrantup.com/)
- [Serverspec](https://serverspec.org/)

## AWS

Create IAM user for Packer.

```sh
$ aws iam create-user --user-name rails-packer-ansible-serverspec
$ aws iam create-policy \
  --policy-name rails-packer-ansible-serverspec \
  --policy-document file://packer/policy.json
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
$ packer inspect packer/rails.json

$ packer validate packer/rails.json

$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"

$ packer build packer/rails.json
```

### Deregister Image

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

### Provisioning

- Nginx
- Ruby with [rbenv](https://github.com/rbenv/rbenv)
- Node.js

```sh
# Check playbook format
$ ansible-playbook ansible/playbook.yml -i ansible/hosts --check
```

## Vagrant

### Install

```sh
$ brew install vagrant
$ vagrant --version
Vagrant 2.2.14

$ brew install virtualbox
# https://stackoverflow.com/questions/52689672/virtualbox-ns-error-failure-0x80004005-macos

$ vboxmanage --version
6.1.16r140961
```

### Build Box

```sh
$ packer build -force -only=vagrant packer/rails.json
```

```sh
$ vagrant up
$ vagrant ssh
```
### Update Box

Add new version box configuration to `packer/metadata.json`, then run command below.

```sh
$ vagrant box update
```
## Serverspec

### Install gems

```sh
$ bundle install
```

### Test
```
$ bundle exec rake spec
```
