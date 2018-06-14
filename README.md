# space
Setup files for my VPS

## Steps to setup

### Setup VM

- login as root
- disable ssh for root
- add user: `adduser <username>`
- move and chown ssh keys from root to the new user
- add user to sudo: `sudo usermod -aG sudo <username>`
- setup firewall to allow/disallow ports
- logout and login as the new user

### Install docker

```bash
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
$ sudo apt-get update
$ sudo apt-get install -y docker-ce docker-compose
$ sudo gpasswd -a $USER docker
```

### Setup space

- copy/clone this repo to `~/space`
- setup SSL certificates (optional)

```bash
$ wget https://dl.eff.org/certbot-auto
$ chmod a+x ./certbot-auto
$ sudo ./certbot-auto certonly --server https://acme-v02.api.letsencrypt.org/directory --manual --preferred-challenges dns -d *.abhinavsarkar.net
$ sudo cp /etc/letsencrypt/live/abhinavsarkar.net/* ~/space/certs/
$ sudo chown -R $USER:$USER ~/space/certs/
```
- stop and disable resolvd

```bash
$ sudo service systemd-resolved stop
$ sudo systemctl disable systemd-resolved.service
```
- edit `/etc/resolv.conf` to set the nameserver to `8.8.8.8`
- edit `~/space/space.service` to set environment variables
    - set passwords to random values if new setup
    - set passwords to the previous values if a copy setup
    - set `PH_SERVER_IP` to the static IP of the server
- setup the service and start

```bash
$ sudo cp ~/space/space.service /etc/systemd/system/
$ sudo systemctl enable space
$ sudo systemctl start space
```
- edit `/etc/resolv.conf` to set the nameserver to `127.0.0.1`
