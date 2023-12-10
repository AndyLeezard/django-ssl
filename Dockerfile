FROM python:3.12-alpine3.18

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install Python dependencies from requirements.txt
COPY requirements.txt /requirements.txt

# Install build-base and linux-headers
RUN apk add --upgrade --no-cache build-base linux-headers

RUN pip install --upgrade pip && \
    pip install -r /requirements.txt

# Copy the required files
COPY app/ /app
WORKDIR /app

RUN adduser --disabled-password --no-create-home django

USER django

CMD ["uwsgi", "--socket", ":9000", "--workers", "4", "--master", "--enabled-threads", "--module", "app.wsgi"]

