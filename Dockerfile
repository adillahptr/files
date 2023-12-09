FROM python:3.11

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

RUN python manage.py makemigrations
RUN python manage.py migrate
RUN python manage.py collectstatic

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]