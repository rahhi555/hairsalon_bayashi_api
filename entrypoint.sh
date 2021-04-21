#!/bin/bash
set -e

echo $FRONT_URL
echo $RAILS_DB_HOST
echo $APP_DATABASE_PASSWORD

cd $APP_ROOT

rm -f $APP_ROOT/tmp/pids/server.pid
rails db:create RAILS_ENV=production
rails db:migrate RAILS_ENV=production
rails server -b 0.0.0.0 -p 3000 -e production