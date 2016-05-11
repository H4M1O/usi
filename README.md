U.S.I. - Universal Script Installer (abbr. USI)
================================================

USI is a textual bash script that allows to install or configure easily a Linux machine.
The concept is to have something similar to tasksel but something that will works at least on Debian, Ubuntu, CentOS and Fedora (probably in the future will be extended).
Why a bash script? It's for fun I could do it in other languages but I don't want.
Why should I need this script when I can install everything manually? You are not enforced to use it, so if you enjoy to it manually go for it, I prefer to automatize things ;)
Or why should I use this script when I can prepare a container (LXC, docker or any other virtualized enviroment) and simply clone it? Because if you clone a machine, that one, will not be updated to the latest releases of the packages and in any case this script allows me to setup a machine completely in few minutes from scratch that is for me a best practise in some cases, especially when you are not wortking on your server but maybe on a customer's one and they are asking you a fresh setup.

Documentation
-------------

To mantain this script really simple I'll try to keep all the files inside this "container" and for this there will not be any documentation apart from this readme file where I'll insert every news regarding bug fixed or new features inside the script.

Installation
------------

The installation of this script it's really easy the only passages to do are the following:If all the dependencies are met (i.e. you have the Python and libpq
development packages installed in your system) the standard::

	# access as root
	su -
	# download the script 
	wget https://raw.githubusercontent.com/H4M1O/usi/master/usi.sh
	# modify the permission on it
	chmod 755 usi.sh
	# launch it and enjoy :)
	./usi.sh

News
------------

Under this line you'll find all the news regarding this project.
The verson of the script will be written via a comment inside the script itself.
The versoning will follow this rule: v.A.B.C where A is the main release, B is the incresing number on every new functionality and C is the incrising number for every bug fixed.

Current Release::

	usi-v.1.0.0

What's new in usi-v.1.0.0
-------------------------

It's the first official release and ovously a lot of things to be modified or fixed but it works :)

New features:

- The menu contains 2 choices HARDENING OS or LAMP INSTALLATION
- When it starts automatically update and upgrade the system
- Under HARDENING OS there are the following features: change the hostname, setup the network, install sudo, install and setup ssh-fail2ban-ufw
- Under LAMP installation you can install a DB (MySQL or PostGres) a web server (Apache or NGIX) and PHP with all the modules
