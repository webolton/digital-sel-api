# Provision notes for deploying the app on AMI 2 with Capistrano

### Make deploy user and setup SSH

    sudo adduser deploy
    sudo su deploy
    cd
    mkdir ~/.ssh/
    chmod 700 .ssh
    touch ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys

Add `id_rsa.pub` to `authorized_keys` and update `~/.ssh/config` with alias.


### Install RVM on the host (for deploy user)

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

    \curl -sSL https://get.rvm.io | bash

    source /home/deploy/.rvm/scripts/rvm

### Install Ruby and Prerequisite gems

    rvm install ruby-2.4.4

    gem install bundler --no-document

    gem install rails -v 5.2.1.1 --no-document

    rvm use 2.4.4

### Install Postgres and git (as ec2-user)

    sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs

    sudo service postgresql initdb

    sudo service postgresql start

    sudo -u postgres createuser deploy

    sudo yum install git

I manually created the database, users, and added users.


### Make project directory (as ec2-user)

    sudo mkdir -p /var/www/digital-sel-api

    sudo chown -R deploy /var/www/digital-sel-api



