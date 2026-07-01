#!/usr/bin/env bash

set -e

if [ "$1" == "rails" ] || [ "$1" == "bin/rails" ]; then
  rm -f tmp/pids/server.pid

  if ! psql -h $POSTGRES_HOST $POSTGRES_DATABASE $POSTGRES_USER -c '\q'; then
    bin/rails db:create
  fi

  if [ "$RAILS_ENV" = "development"  ]; then
    bin/bundle install

    pnpm i

    bin/rails db:migrate

    bin/rails db:seed

    bin/rake dc:update
  fi

  exec "$@"
elif [ "$1" == "rake" ] || [ "$1" == "bin/rake" ]; then
  if [ "$RAILS_ENV" = "development"  ]; then
    bin/bundle install

    pnpm i
  fi

  exec "$@"
else
  exec "$@"
fi
