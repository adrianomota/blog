#!/bin/sh
echo "starting deploy process"

git remote add gigalixir https://adrianowshgmail.com:0b0630f7-3bfc-4bd5-aa31-84ce941e5c90@git.gigalixir.com/blogelxpro.git

BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR"
echo "------------------------------------"
echo "BRANCH=$BRANCH"

if [ "$BRANCH" == "master" ]; then
  echo "Pushing HEAD to master branch on Gigalixir."
  git push -f gigalixir HEAD:refs/heads/master
  echo "Deploy completed."
fi

echo "Exiting."
