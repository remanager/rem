REM (Real Estate Manager)
===

[![Build Status](https://travis-ci.org/remanager/rem.png)](https://travis-ci.org/coopdevs/rem)
[![Code Climate](https://codeclimate.com/github/remanager/rem.png)](https://codeclimate.com/github/remanager/rem)

How to get started
---

Download vagrant from [vagrantup.com](http://www.vagrantup.com/downloads.html)
To start the vagrant virtual machine just type `vagrant up`. It downloads an image and prepare it to deploy the project.
To open the vagrant shell type `vagrant ssh`. Here we recommend to open guard.
The project folder is on `/vagrant`.
```bash
cd /vagrant
bundle install
bundle exec guard
```
To get guard getting file changes, you must run `vagrant rsync-auto` in the project folder on the guest machine. I recommend running it in the background.

Links
---

[Vagrant template](https://github.com/rails/rails-dev-box)
