#!/bin/bash

# Universal Script Installer 
# Script created by Claudio Proietti v. 1.0 created on 28/04/2016

# This script is intended to allows an easy deploy of a standalone Debian server
# the scope is to allow the user to have an easy menu pretty similar to tasksel but with
# more options like LAMP, OS_HARDENING, DBs or other common setup and configurations.

function main ()
{
# This is the main function that show the menu and allows the user to make a choice
	
	# declared integer for user's choice
	declare -i OPT
	while true
	do
		menu
		# readed input from keyboard
		read OPT
		
		# error handling if, it checks if the user insert something different from a number between 1 and 6
		if [ $OPT -ge 1 -a $OPT -le 6 ] 
		then
		# case to select the right option from 1 to 6
			case $OPT in 
				1 ) OS_HARDENING 
				;;
				2 ) LAMP 
				;;
				3 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nThank you for using this script!$(tput sgr 0)\n"
				break
				;;
			esac
		else
			echo $OPT
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi

	done

}

function menu () 
{
# The scope of this function is only to show the contextual menu
	echo "$(tput setaf 5)Welcome to U.S.I. - Universal Script Installer v. 1.0"
	echo -e "Script created by Claudio Proietti under MIT license$(tput sgr 0)\n"
	echo -e "These are the available options:\n"
	echo "1 - OS_HARDENING (hostname, ifconfig, ssh, fail2ban, ufw)"
	echo "2 - LAMP (Apache, MySQL, PHP)" 
	echo -e "\n3 - Exit the script\n"
	echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
}

function OS_HARDENING ()
{
# This function is used to complete the hardening of the OS
# It will use the following commands hostname, ifconfig, ssh, sudo, fail2ban and ufw.
	
	clear	
	hst_cfg
	echo -e "$(tput setaf 0)$(tput setab 2)\nOS_HARDENING COMPLETED!$(tput sgr 0)\n"
}

function LAMP ()
{
# This function install the default LAMP server
# the following packages will be installed Apache, MySQL and PHP with the most common modules
	clear	
	echo -e "$(tput setaf 0)$(tput setab 2)\nSERVER LAMP INSTALLED!$(tput sgr 0)\n"
}

function hst_cfg ()
{

	echo "$(tput setaf 3)The actual hostname is: $(tput sgr 0)"
	echo $HOSTNAME	
	echo "$(tput setaf 3)Write the new hostname and press enter: $(tput sgr 0)"	
	read NEW_HOSTNAME

	if [ ! -f /etc/exim4/update-exim4.conf.conf ]; then
	echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: /etc/exim4/update-exim4.conf not found!!!$(tput sgr 0)\n"
	else
    	echo -e "$(tput setaf 0)$(tput setab 2)\nThe file: /etc/exim4/update-exim4.conf.con is present!$(tput sgr 0)\n"
	sed -i.bak s/$HOSTNAME/$NEW_HOSTNAME/g /etc/exim4/update-exim4.conf
	fi

	if [ ! -f /etc/printcap ]; then
	echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: /etc/printcap not found!!!$(tput sgr 0)\n"
	else
    	echo -e "$(tput setaf 0)$(tput setab 2)\nThe file: /etc/printcap is present!$(tput sgr 0)\n"
	sed -i.bak s/$HOSTNAME/$NEW_HOSTNAME/g /etc/printcap
	fi

	if [ ! -f /etc/hostname ]; then
	echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: /etc/hostname not found!!!$(tput sgr 0)\n"
	else
    	echo -e "$(tput setaf 0)$(tput setab 2)\nThe file: /etc/hostname is present!$(tput sgr 0)\n"
	sed -i.bak s/$HOSTNAME/$NEW_HOSTNAME/g /etc/hostname
	fi

	if [ ! -f /etc/hosts ]; then
	echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: /etc/hosts not found!!!$(tput sgr 0)\n"
	else
    	echo -e "$(tput setaf 0)$(tput setab 2)\nThe file: /etc/hosts is present!$(tput sgr 0)\n"
	sed -i.bak s/$HOSTNAME/$NEW_HOSTNAME/g /etc/hosts
	fi

	if [ ! -f /etc/ssh/ssh_host_rsa_key.pub ]; then
	echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: /etc/ssh/ssh_host_rsa_key.pub not found!!!$(tput sgr 0)\n"
	else
    	echo -e "$(tput setaf 0)$(tput setab 2)\nThe file: /etc/ssh/ssh_host_rsa_key.pub is present!$(tput sgr 0)\n"
	sed -i.bak s/$HOSTNAME/$NEW_HOSTNAME/g /etc/ssh/ssh_host_rsa_key.pub
	fi

	if [ ! -f /etc/ssh/ssh_host_dsa_key.pub ]; then
	echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: /etc/ssh/ssh_host_dsa_key.pub not found!!!$(tput sgr 0)\n"
	else
    	echo -e "$(tput setaf 0)$(tput setab 2)\nThe file: /etc/ssh/ssh_host_dsa_key.pub is present!$(tput sgr 0)\n"
	sed -i.bak s/$HOSTNAME/$NEW_HOSTNAME/g /etc/ssh/ssh_host_dsa_key.pub
	fi

	if [ ! -f /etc/motd ]; then
	echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: /etc/motd not found!!!$(tput sgr 0)\n"
	else
    	echo -e "$(tput setaf 0)$(tput setab 2)\nThe file: /etc/motd is present!$(tput sgr 0)\n"
	sed -i.bak s/$HOSTNAME/$NEW_HOSTNAME/g /etc/motd
	fi

	if [ ! -f /etc/ssmtp/ssmtp.conf ]; then
	echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: /etc/ssmtp/ssmtp.conf not found!!!$(tput sgr 0)\n"
	else
    	echo -e "$(tput setaf 0)$(tput setab 2)\nThe file: /etc/ssmtp/ssmtp.conf is present!$(tput sgr 0)\n"
	sed -i.bak s/$HOSTNAME/$NEW_HOSTNAME/g /etc/ssmtp/ssmtp.conf
	fi
	
	hostname $NEW_HOSTNAME	
	
	/etc/init.d/hostname.sh start
	HOSTNAME=$NEW_HOSTNAME	
	echo -e "$(tput setaf 0)$(tput setab 2)\nYOUR NEW HOSTNAME IS: $HOSTNAME anyway to apply it reboot is required!$(tput sgr 0)\n"

}

# Call to the main function
main
