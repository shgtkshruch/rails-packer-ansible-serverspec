# Rails Packer Ansible Serverspec

## AWS

create iam user.

```sh
$ aws iam create-user --user-name rails-packer-ansible-serverspec
$ aws iam create-policy \
  --policy-name rails-packer-ansible-serverspec \
  --policy-document file://policy.json
$ aws iam attach-user-policy \
  --user-name rails-packer-ansible-serverspec \
  --policy-arn arn:aws:iam::<ACCONT_ID>:policy/rails-packer-ansible-serverspec
$ aws iam create-access-key --user-name rails-packer-ansible-serverspec
```

### Cleaning

```sh
$ aws iam detach-user-policy \
  --user-name rails-packer-ansible-serverspec \
  --policy-arn arn:aws:iam::<ACCONT_ID>:policy/rails-packer-ansible-serverspec
$ aws iam delete-policy --policy-arn arn:aws:iam::<ACCONT_ID>:policy/rails-packer-ansible-serverspec
$ aws iam delete-access-key \
  --access-key-id <ACCESSKEY_ID> \
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

$ packer fmt -check rails.json
$ packer fmt rails.json

$ packer validate rails.json

$ packer build rails.json
```

## Ansible

## Serverspec
