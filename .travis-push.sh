#!/bin/sh
# Credit: https://gist.github.com/willprice/e07efd73fb7f13f917ea

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_country_json_files() {
  dateAndMonth=`date "+%b %Y"`
  git add -f dist/output/*.json
  git commit --message "Travis build: $dateAndMonth ($TRAVIS_BUILD_NUMBER)"
}

upload_files() {
  git remote add origin https://${GH_TOKEN}@github.com/vinaygopinath/visa-req-wiki-scraper.git > /dev/null 2>&1
  git push --quiet
}

setup_git

commit_country_json_files

if [ $? -eq 0 ]; then
  upload_files
fi