#!/bin/bash
# ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`
# CodeCommitRepoName="codecommit-repo-$ACCOUNT_ID"
# git remote remove origin
# git remote add origin $CodeCommitRepoName
cd ..
git add *
git commit -m "Update Commit Messgae"
git push --force origin main
