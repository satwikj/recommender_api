#!/usr/bin/env bash

# TODO: Set to URL of git repo.
PROJECT_GIT_URL='https://github.com/satwikj/recommender_api.git'

PROJECT_BASE_PATH='/usr/local/apps'
VIRTUALENV_BASE_PATH='/usr/local/virtualenvs'

# Set Ubuntu Language
locale-gen en_GB.UTF-8

# Install Python, SQLite and pip
apt-get update
apt-get install -y python3-dev sqlite python-pip supervisor nginx git

# Upgrade pip to the latest version.
pip install --upgrade pip
pip install virtualenv

mkdir -p $PROJECT_BASE_PATH
git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH/movie-recommender-api

mkdir -p $VIRTUALENV_BASE_PATH
virtualenv --python=python3 $VIRTUALENV_BASE_PATH/api_recommender

source $VIRTUALENV_BASE_PATH/api_recommender/bin/activate
pip install -r $PROJECT_BASE_PATH/movie-recommender-api/requirements.txt

# Run migrations
cd $PROJECT_BASE_PATH/movie-recommender-api/src

# Setup Supervisor to run our uwsgi process.
cp $PROJECT_BASE_PATH/movie-recommender-api/deploy/supervisor_api_recommender.conf /etc/supervisor/conf.d/api_recommender.conf
supervisorctl reread
supervisorctl update
supervisorctl restart api_recommender

# Setup nginx to make our application accessible.
cp $PROJECT_BASE_PATH/profiles-rest-api/deploy/nginx_recommender_api.conf /etc/nginx/sites-available/api_recommender.conf
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/api_recommender.conf /etc/nginx/sites-enabled/api_recommender.conf
systemctl restart nginx.service

echo "DONE! :)"
