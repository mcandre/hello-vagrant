#!/usr/bin/env bash

sudo aptitude -y install build-essential
sudo aptitude -y install splint

if [ ! -f /home/vagrant/.bash_profile ]; then
  ln -s /vagrant/.bash_profile /home/vagrant/.bash_profile
fi
