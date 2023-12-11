# Django-ssl
Dockerized django template with nginx and automated ssl support with certbot.

# Requirements
A functioning available domain to attach to the server instance you wanna host with this configuration.

# How to deploy
I recommend AWS Lightsail cause it's simple and fast to set up.

Just create a Lightsail instance (or a classic EC2 instance) with both http and https ports allowed.
The first connection will be in http, and then you're gonna have to reboot to use https.

Install and enable docker as background service, assign the domain and configure name servers.

# Details on how to set up your instance (AWS)

Set up the host environment
```bash
sudo yum install git -y
sudo yum install -y docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker ec2-user
```

And then install the latest docker-compose straight from the official repo.
```bash
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
```

Exit the remote terminal, reconnect to it to refresh user permissions.
Check if the installation was successful by running version check commands.

```bash
docker --version
docker-compose --version
```

Now git pull this repo on the host machine.

(Optional) if the repo is a private repo, establish an ssh key.
```bash
ssh-keygen -t ed25519 -C "GitHub Deploy Key"
cat ~/.shh/id_ed25519.pub
```
Then copy the whole printed line starting with `ssh-ed25519...` and ending with `...GitHub Deploy Key`.
Go to your github repo settings/deploy keys, add new by title "aws-server" (example).

Pull the repo and cd into it.

At this point, verify if the domain (Hosted Zone) is configured on AWS end.
You should have a CNAME record of the exact same value as the public IPv4 DNS.

Create and configure a .env file.

Generate the initial certificates.
```bash
docker-compose -f docker-compose.deploy.yml run --rm certbot /opt/certify-init.sh
```

After receiving certificate, recreate containers to serve in https instead of http.

```bash
docker-compose -f docker-compose.deploy.yml down
docker-compose -f docker-compose.deploy.yml up
```

# Command logs
```bash
mkdir app
docker-compose run --rm app sh -c "django-admin startproject app ."
docker-compose run --rm app sh -c "python manage.py startapp home"
```
