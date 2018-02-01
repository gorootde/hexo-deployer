#!/bin/ash

echo "*** Updating from git"
if [ -d .git ]; then
   git pull
else
   git clone $GIT_URL .
fi

echo "*** install npm packages"
npm install
echo "*** add secrets to config"
sed -i -e "s/@SECRET@/${SECRET}/g" _config.yml


echo "*** hexo generate & deploy"
hexo generate --deploy

echo "*** reset config"
git checkout -- _config.yml

echo "*** git status"
git status
