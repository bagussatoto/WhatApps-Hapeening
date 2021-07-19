#!/usr/bin/env bash

sudo apt-get -y install git
sudo apt-get -y install make
sudo apt-get -y install libsqlite3-dev
sudo apt-get -y install nodejs

git clone https://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
git clone https://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile

source ~/.bash_profile

rbenv install 2.2.2
rbenv global 2.2.2
cd /vagrant
gem install bundle
bundle install --without production
rake db:migrate RAILS_ENV=development