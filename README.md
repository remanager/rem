REM (Real Estate Manager)
===

[![Build Status](https://travis-ci.org/remanager/rem.png)](https://travis-ci.org/coopdevs/rem)
[![Code Climate](https://codeclimate.com/github/remanager/rem.png)](https://codeclimate.com/github/remanager/rem)

How to get started
---

Download vagrant from [vagrantup.com](http://www.vagrantup.com/downloads.html)
Install rsync-back plugin [github](https://github.com/smerrill/vagrant-rsync-back) with `vagrant plugin install vagrant-rsync-back`
To start the vagrant virtual machine just type `vagrant up`. It downloads an image and prepares it to deploy the project the first run.
To open the vagrant shell type `vagrant ssh`. Here we recommend to open guard.
The project folder is on `/vagrant`.
```bash
cd /vagrant
bundle install
bundle exec guard
```
To get guard getting file changes, you must run `vagrant rsync-auto` in the project folder on the host machine. I recommend running it in the background and redirecting output.
TIP: you can run `./vagrant-up` script to up vagrant, run rsync-auto and open ssh connection.

Guard requires to install Growl notifier to notify from guest machine to host machine.
Get Growl from: [OS X](http://growl.info/downloads) [Linux](http://mattn.github.io/growl-for-linux/)

Links
---

[Vagrant template](https://github.com/rails/rails-dev-box)
