#!/bin/sh
# Credit: https://gist.github.com/willprice/e07efd73fb7f13f917ea

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_country_json_files() {
  git checkout master
  dateAndMonth=`date "+%b %Y"`
  git status
  git add -f dist/output/*.json
  git commit -m "Travis update: $dateAndMonth (Build $TRAVIS_BUILD_NUMBER)" -m "[skip ci]"
}

upload_files() {
  git remote rm origin
  git remote add origin https://vinaygopinath:${GH_TOKEN}@github.com/vinaygopinath/visa-req-wiki-scraper.git > /dev/null 2>&1
  git push origin master --quiet > /dev/null 2>&1
}

setup_git

commit_country_json_files

if [ $? -eq 0 ]; then
  echo "A new commit with changed country JSON files exists. Uploading to GitHub"
  upload_files
else
  echo "No changes in country JSON files. Nothing to do"
fi