#!/usr/bin/env bash

aws s3 sync ./_site s3://mandos.net.pl --delete

aws cloudfront create-invalidation --distribution-id E27OAT8VBN5AJ --paths "/*"
