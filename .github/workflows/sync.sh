#!/bin/bash

# Get the last non-merge pull request commit
COMMITID=$(git log --no-merges -n1 | grep ^commit | awk -F " " '{print $2}')

# Only need to sync images that changed in current commit
FILES=$(git diff-tree --no-commit-id --name-only -r $COMMITID |grep rules)

for FILE in $FILES
do
     echo "=======> Syncing: $FILES <========"
    ./image-syncer --proc=6 --auth=./auth.json --images=$FILE
done