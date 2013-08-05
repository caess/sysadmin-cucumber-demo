This is a demo environment put together for the blog post ["An Introduction to Cucumber for System Administrators"](FIXME).

# Requirements
You will need [Vagrant](http://www.vagrantup.com) installed.  As written, you will also need [VirtualBox](www.virtualbox.org) installed.  (If you instead use the VMware integration methods for Vagrant, you can edit `Vagrantfile` accordingly.)

#To Use
1. Download the base box `[ithiriel-CentOS-6.4-i386-20130714.box](http://files.ithiriel.com/vagrant/ithiriel-CentOS-6.4-i386-20130714.box)`.
2. Import the base box: `vagrant box add ithiriel-CentOS-6.4-i386-20130714.box`
3. Start the environment: `vagrant up`

If desired, you can instead build the box using the definitions found in my `[vagrant-base-boxes](https://github.com/caess/vagrant-base-boxes)` git repo.  You should also be able to use any other CentOS 6.x base box but I haven't tested it.  If you use a different base box, import that box and edit `Vagrantfile` accordingly.