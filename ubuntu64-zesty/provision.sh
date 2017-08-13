#!/bin/bash

apt-get update

# Install development packages
apt-get install -y python3 python3-pip npm nodejs-legacy git
pip3 install virtualenvwrapper django djangorestframework markdown django-filter
npm install -g grunt-cli bower

echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> /home/vagrant/.profile

# Install sound
apt-get install -y alsa alsa-utils
apt-get install -y linux-image-extra-`uname -r`
