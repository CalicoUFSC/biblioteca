#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    exit 0
fi

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

git checkout $TRAVIS_BRANCH

# Run our compile script
bash scripts/build.sh

# Now let's go have some fun with the cloned repo
git config user.name "Travis-CI"
git config user.email "caiopoliveira@gmail.com"

# If there are no changes (e.g. this is a README update) then just bail.
if [[ -z `git diff --exit-code` ]]; then
    echo "No changes to the spec on this push; exiting."
    exit 0
fi

# Commit the "changes", i.e. the new version.
# The delta will show diffs between new and old versions.
git add -A
git commit -m "Build: ${SHA}"

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}

openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV \
    -in scripts/travis/deploy_key.enc -out scripts/travis/deploy_key -d

chmod 600 scripts/travis/deploy_key
eval `ssh-agent -s`
ssh-add scripts/travis/deploy_key

git log -4

echo "Pushing to ${SSH_REPO} ${TRAVIS_BRANCH}"

# Now that we're all set up, we can push.
git push $SSH_REPO $TRAVIS_BRANCH
