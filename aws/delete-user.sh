#!/usr/bin/env bash

ACCONT_ID="YOUR_ACCOUNT_ID"
USER_NAME="rails-packer-ansible-serverspec"

aws iam detach-user-policy \
  --user-name "$USER_NAME" \
  --policy-arn arn:aws:iam::"$ACCONT_ID":policy/"$USER_NAME"

aws iam delete-policy --policy-arn arn:aws:iam::"$ACCONT_ID":policy/"$USER_NAME"

ACCESS_KEY_ID=$(aws iam list-access-keys --user-name "$USER_NAME" | jq -r '.AccessKeyMetadata | .[] | .AccessKeyId')

aws iam delete-access-key \
  --access-key-id "$ACCESS_KEY_ID" \
  --user-name "$USER_NAME"

aws iam delete-user --user-name "$USER_NAME"

echo "Delete $USER_NAME"
