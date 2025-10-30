#!/usr/bin/env sh
set -e 

aws s3 sync ./hugo/public s3://mandos.net.pl --delete

aws cloudfront create-invalidation --distribution-id E27OAT8VBN5AJ --paths "/*"
