# django-ssl
Dockerized django template with nginx and automated ssl support with certbot.





# Command logs
```bash
mkdir app
docker-compose run --rm app sh -c "django-admin startproject app ."
docker-compose run --rm app sh -c "python manage.py startapp home"
```
