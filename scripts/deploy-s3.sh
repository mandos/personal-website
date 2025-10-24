#!/usr/bin/env bash

aws --profile mandos.net.pl s3 sync ./hugo/public s3://mandos.net.pl --delete

aws --profile mandos.net.pl cloudfront create-invalidation --distribution-id E27OAT8VBN5AJ --paths "/*"
