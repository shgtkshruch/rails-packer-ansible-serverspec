#!/usr/bin/env bash

ACCONT_ID="YOUR_ACCOUNT_ID"
USER_NAME="rails-packer-ansible-serverspec"

aws iam create-user --user-name "$USER_NAME"

aws iam create-policy \
  --policy-name "$USER_NAME" \
  --policy-document file://aws/policy.json

aws iam attach-user-policy \
  --user-name "$USER_NAME" \
  --policy-arn arn:aws:iam::"$ACCONT_ID":policy/"$USER_NAME"

ACCESS_KEY=$(aws iam create-access-key --user-name "$USER_NAME")

echo "Create $ACCESS_KEY"
