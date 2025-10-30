#!/usr/bin/env sh
set -e

PUBLIC_DIR="$1"
if [ -z "$PUBLIC_DIR" ]; then
    PUBLIC_DIR="./hugo/public"
fi

aws s3 sync "$PUBLIC_DIR" s3://mandos.net.pl --delete 

aws cloudfront create-invalidation --distribution-id E27OAT8VBN5AJ --paths "/*" 
