#!/bin/bash

apt-get update

# Install development packages
apt-get install -y python3 python3-pip npm nodejs-legacy git apt-file screen postgresql python-psycopg2 libpq-dev dos2unix
pip3 install virtualenvwrapper django djangorestframework markdown django-filter
npm install -g grunt-cli bower

# Install sound
apt-get install -y alsa alsa-utils
apt-get install -y linux-image-extra-`uname -r`

# Repair any dos crlf checkout issues
dos2unix /vagrant/files/*

# Copy profile settings
cp /vagrant/files/bashrc /home/ubuntu/.bashrc
cp /vagrant/files/bash_aliases /home/ubuntu/.bash_aliases
chown -R ubuntu.ubuntu /home/ubuntu
cp /vagrant/files/bashrc /root/.bashrc

# screen settings
cp /vagrant/files/screenrc /root/.screenrc
cp /vagrant/files/screenrc /etc/screenrc

# Prevent flash from visual bell
cp /vagrant/files/inputrc /etc/inputrc
# Git
cp /vagrant/files/gitconfig /home/ubuntu/.gitconfig
chown ubuntu.ubuntu /home/ubuntu/.gitconfig

# Install espeak development environments
apt-get install -y emacs25-nox espeak-ng espeak-ng-espeak libespeak-ng-libespeak-dev tcl8.6 tcl8.6-dev tclx
cp /vagrant/files/espeak.voice.default /usr/lib/x86_64-linux-gnu/espeak-ng-data/voices/default

# get emacs
git clone https://github.com/katekligman/.emacs.d.git emacs
mv emacs/linux /home/ubuntu/.emacs.d
rm -rf emacs

# get emacspeak
git clone https://github.com/tvraman/emacspeak.git /home/ubuntu/.emacspeak
rmdir /home/ubuntu/.emacs.d/emacspeak
ln -s /home/ubuntu/.emacspeak /home/ubuntu/.emacs.d/emacspeak
cd /home/ubuntu/.emacspeak
make
cd servers/linux-espeak
make
chown -R ubuntu.ubuntu /home/ubuntu/.emacspeak
chown -R ubuntu.ubuntu /home/ubuntu/.emacs.d

# screen -- disable the flash of the visual bell, etc
cp /vagrant/files/screenrc /etc/screenrc
chmod 644 /etc/screenrc

# Install Heroku CLI
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
