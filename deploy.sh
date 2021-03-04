#!/bin/sh
echo "starting deploy process"
git remote add gigalixir https://git.gigalixir.com/blogelxpro.git
BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR"
echo "------------------------------------"
echo "BRANCH=$BRANCH"
if [ "$BRANCH" == "master" ]; then
  echo "Pushing HEAD to master branch on Gigalixir."
  git push -f gigalixir HEAD:master --verbose
  echo "Deploy completed."
fi
echo "Exiting."
