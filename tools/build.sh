#!/usr/bin/env bash
#
# Run jekyll serve and then launch the site

npx gulp
JEKYLL_ENV=production bundle exec jekyll b
