#!/bin/bash

python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic -c

export DJANGO_SUPERUSER_PASSWORD=admin
python manage.py createsuperuser --no-input --username=admin  --email=admin@mail.com