#!/usr/bin/env bash

# install gigalixir-cli
echo "Install gigalixir......"
sudo apt-get install -y python3 python3-pip
pip3 install gigalixir
echo "Finish install gigalixir......"

# deploy

echo "Login gigalixir....."
gigalixir login -e "$GIGALIXIR_EMAIL" -p "$GIGALIXIR_PASSWORD" -y
gigalixir git:remote $GIGALIXIR_APP_NAME
git push -f gigalixir HEAD:refs/heads/master

echo "Finish login gigalixir....."
# some code to wait for new release to go live

echo "git remote add gigalixir...."
git remote add gigalixir https://$GIGALIXIR_EMAIL:$GIGALIXIR_API_KEY@git.gigalixir.com/$GIGALIXIR_APP_NAME.git

BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR"
echo "------------------------------------"
echo "BRANCH=$BRANCH"

if [ "$BRANCH" == "master" ]; then
  echo "Pushing HEAD to master branch on Gigalixir."
  git push gigalixir HEAD:master --verbose
  echo "Deploy completed."
fi

echo "Exiting."
