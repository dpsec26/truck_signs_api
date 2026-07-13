#!/usr/bin/env bash
set -e

echo "Waiting for postgres to connect ..."
while ! nc -z postgres-db 5432; do
  sleep 0.1
done
echo "PostgreSQL is active"

python manage.py migrate
python manage.py collectstatic --noinput
python manage.py create_superuser_from_env

gunicorn truck_signs_designs.wsgi:application --bind 0.0.0.0:8000