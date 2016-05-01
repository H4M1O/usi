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
		# read input from keyboard
		read OPT
		if [ $OPT -ge 0 -a $OPT -le 2 ] 
		then
			case $OPT in 
				1 ) OS_HARDENING 
				;;
				2 ) LAMP 
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nThank you for using this script!$(tput sgr 0)\n"
				exit 1
				;;
			esac
		else
			echo $OPT
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi
	done
}

function so_update () 
{
# This is the main function that show the menu and allows the user to make a choice
	# declared integer for user's choice
	declare -i SUP
	while true
	do
		menu2
		# read input from keyboard
		read SUP
		if [ $SUP -ge 0 -a $SUP -le 2 ] 
		then
			case $SUP in 
				1 ) apt-get update && sudo apt-get upgrade -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nUPDATE AND UPGRADE COMPLETED!$(tput sgr 0)\n"
				break
				;;
				2 ) break 
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nThank you for using this script!$(tput sgr 0)\n"
				exit 1
				;;
			esac
		else
			echo $SUP
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
	echo "1 - OS_HARDENING (hostname, ifconfig, ssh, sudo, fail2ban, ufw)"
	echo "2 - LAMP (WebServer Apache or NGIX, DB MySQL or PostGres, PHP and PHP Modules)" 
	echo -e "\n0 - Exit the script\n"
	echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
}

function menu2 () 
{
# The scope of this function is only to show the contextual menu for the update
	echo "$(tput setaf 5)Welcome to U.S.I. - Universal Script Installer v. 1.0"
	echo -e "Script created by Claudio Proietti under MIT license$(tput sgr 0)\n"
	echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: THE UPDATE OF THE PACKAGES IS REQUIRED!!!$(tput sgr 0)\n"
	echo -e "These are the available options:\n"
	echo "1 - UPDATE AND UPGRADE THE SYSTEM"
	echo "2 - CONTINUE WITHOUT THE UPDATE (not recommended!!!)" 
	echo -e "\n0 - Exit the script\n"
	echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
}

function OS_HARDENING ()
{
# This function is used to complete the hardening of the OS
# It will use the following commands hostname, ifconfig, ssh, sudo, fail2ban and ufw.
	
	clear	
	hst_cfg 
	ip_addr
	serv_ssh
	inst_sudo
	inst_f2b
	inst_ufw
	echo -e "$(tput setaf 0)$(tput setab 2)\nOS_HARDENING COMPLETED!$(tput sgr 0)\n"
}

function hst_cfg ()
{

	# declared integer for user's choice
	declare -i OPT2
	while true
	do
		echo "$(tput setaf 5)Do you want change the HOSTNAME:"
		echo "1 - YES"
		echo -e "\n2 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT2
		if [ $OPT2 -ge 0 -a $OPT2 -le 2 ] 
		then
			case $OPT2 in 
				1 )  
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
				;;
				2 )  
				echo -e "$(tput setaf 7)$(tput setab 0)\nHostname configuration skipped!$(tput sgr 0)\n"
				break
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nReturn to the main menu!$(tput sgr 0)\n"
				main
				;;
			esac
		else
			echo $OPT2
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi

	done

}

function ip_addr () 
{

	# declared integer for user's choice
	declare -i OPT3
	while true
	do
		echo "$(tput setaf 5)Choose the type of the network configuration to setup:"
		echo "1 - DHCP"
		echo "2 - STATIC IPV4" 
		echo -e "\n3 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT3
		
		# error handling if, it checks if the user insert something different from a number between 1 and 2
		if [ $OPT3 -ge 0 -a $OPT3 -le 3 ] 
		then
		# case to select the right option from 1 to 2
			case $OPT3 in 
				1 ) echo "# This file describes the network interfaces available on your system" > /etc/network/interfaces
				echo "# and how to activate them. For more information, see interfaces(5)." >> /etc/network/interfaces
				echo " " >> /etc/network/interfaces
				echo "source /etc/network/interfaces.d/*" >> /etc/network/interfaces
				echo " " >> /etc/network/interfaces
				echo "# The loopback network interface" >> /etc/network/interfaces
				echo "auto lo" >> /etc/network/interfaces
				echo "iface lo inet loopback" >> /etc/network/interfaces
				echo " " >> /etc/network/interfaces
				echo "auto eth0" >> /etc/network/interfaces
    				echo "allow-hotplug eth0" >> /etc/network/interfaces
    				echo "iface eth0 inet dhcp" >> /etc/network/interfaces
				ifconfig eth0 down
				ifconfig eth0 up
				echo -e "$(tput setaf 0)$(tput setab 2)\nDHCP CONFIGURED CORRECTLY!$(tput sgr 0)\n"
				break
				;;
				2 ) echo "# This file describes the network interfaces available on your system" > /etc/network/interfaces
				echo "# and how to activate them. For more information, see interfaces(5)." >> /etc/network/interfaces
				echo " " >> /etc/network/interfaces
				echo "source /etc/network/interfaces.d/*" >> /etc/network/interfaces
				echo " " >> /etc/network/interfaces
				echo "# The loopback network interface" >> /etc/network/interfaces
				echo "auto lo" >> /etc/network/interfaces
				echo "iface lo inet loopback" >> /etc/network/interfaces
				echo " " >> /etc/network/interfaces
				echo "auto eth0" >> /etc/network/interfaces
    				echo "iface eth0 inet static" >> /etc/network/interfaces
				echo "$(tput setaf 3)Write the new IP address and press enter: $(tput sgr 0)"	
				read IPV4S
				echo "$(tput setaf 3)Write the new subnet mask and press enter: $(tput sgr 0)"	
        			echo "address $IPV4S" >> /etc/network/interfaces
				read SUBNET
        			echo "netmask $SUBNET" >> /etc/network/interfaces
				echo "$(tput setaf 3)Write the new Gateway and press enter: $(tput sgr 0)"	
				read GTW
        			echo "gateway $GTW" >> /etc/network/interfaces
				echo "$(tput setaf 3)Write the Primary DNS and press enter: $(tput sgr 0)"	
				read DNS1
				echo "nameserver $DNS1" >> /etc/resolv.conf
				echo "$(tput setaf 3)Write the Secondary DNS and press enter: $(tput sgr 0)"	
				read DNS2
				echo "nameserver $DNS2" >> /etc/resolv.conf
				ifconfig eth0 down
				ifconfig eth0 up
				echo -e "$(tput setaf 0)$(tput setab 2)\nSTATIC IPV4 CONFIGURED CORRECTLY!$(tput sgr 0)\n"
				break
				;;
				3 )  
				echo -e "$(tput setaf 7)$(tput setab 0)\nNetwork configuration skipped!$(tput sgr 0)\n"
				break
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nReturn to the main menu!$(tput sgr 0)\n"
				main
				;;
			esac
		else
			echo $OPT3
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi

	done

}

function serv_ssh () 
{
	# declared integer for user's choice
	declare -i OPT4
	while true
	do
		echo "$(tput setaf 5)Choose the type of the SSH software to install and configure:"
		echo "1 - SSH CLIENT"
		echo "2 - SSH SERVER" 
		echo -e "\n3 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT4
		if [ $OPT4 -ge 0 -a $OPT4 -le 3 ] 
		then
			case $OPT4 in 
				1 ) apt-get install openssh-client
				break
				;;
				2 )
				break	
				;;
				3 )  
				echo -e "$(tput setaf 7)$(tput setab 0)\nSSH configuration skipped!$(tput sgr 0)\n"
				break
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nReturn to the main menu!$(tput sgr 0)\n"
				main
				;;
			esac
		else
			echo $OPT4
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi
	done
}

function inst_sudo () 
{
	# declared integer for user's choice
	declare -i OPT5
	while true
	do
		echo "$(tput setaf 5)Select the option to install sudo and configure it for a new user::"
		echo "1 - ADD A NEW USER"
		echo "2 - INSTALL SUDO" 
		echo "3 - CALL VISUDO" 
		echo "4 - CHANGE ROOT PASSWORD" 
		echo -e "\n5 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT5
		if [ $OPT5 -ge 0 -a $OPT5 -le 5 ] 
		then
			case $OPT5 in 
				1 )
				break
				;;
				2 )
				break	
				;;
				3 )
				break	
				;;
				4 )
				break	
				;;
				5 )  
				echo -e "$(tput setaf 7)$(tput setab 0)\nUsers configuration skipped!$(tput sgr 0)\n"
				break
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nReturn to the main menu!$(tput sgr 0)\n"
				main
				;;
			esac
		else
			echo $OPT5
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi
	done
}

function inst_f2b ()
{
	# declared integer for user's choice
	declare -i OPT6
	while true
	do
		echo "$(tput setaf 5)Choose the options to install and configure fail2ban:"
		echo "1 - INSTALL FAIL2BAN"
		echo "2 - CONFIGURE FAIL2BAN" 
		echo -e "\n3 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT6
		if [ $OPT6 -ge 0 -a $OPT6 -le 3 ] 
		then
			case $OPT6 in 
				1 )
				break
				;;
				2 )
				break	
				;;
				3 )  
				echo -e "$(tput setaf 7)$(tput setab 0)\nFail2Ban configuration skipped!$(tput sgr 0)\n"
				break
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nReturn to the main menu!$(tput sgr 0)\n"
				main
				;;
			esac
		else
			echo $OPT6
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi
	done
}

function inst_ufw ()
{
	# declared integer for user's choice
	declare -i OPT7
	while true
	do
		echo "$(tput setaf 5)Choose the options to install and configure UFW:"
		echo "1 - INSTALL UFW"
		echo "2 - CONFIGURE UFW" 
		echo -e "\n3 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT7
		if [ $OPT7 -ge 0 -a $OPT7 -le 3 ] 
		then
			case $OPT7 in 
				1 )
				break
				;;
				2 )
				break	
				;;
				3 )  
				echo -e "$(tput setaf 7)$(tput setab 0)\nUFW configuration skipped!$(tput sgr 0)\n"
				break
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nReturn to the main menu!$(tput sgr 0)\n"
				main
				;;
			esac
		else
			echo $OPT7
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi
	done
}

function LAMP ()
{
# This function is used to install and configure a LAMP Server
# It will use the following other functions.
	
	inst_webserv	
	inst_db 
	inst_php
	echo -e "$(tput setaf 0)$(tput setab 2)\nLAMP INSTALLATION COMPLETED!$(tput sgr 0)\n"
}

function inst_webserv ()
{
	# declared integer for user's choice
	declare -i OPT8
	while true
	do
		echo "$(tput setaf 5)Choose the Web Server to install and configure:"
		echo "1 - INSTALL APACHE"
		echo "2 - INSTALL NGIX" 
		echo -e "\n3 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT8
		if [ $OPT8 -ge 0 -a $OPT8 -le 3 ] 
		then
			case $OPT8 in 
				1 )
				break
				;;
				2 )
				break	
				;;
				3 )  
				echo -e "$(tput setaf 7)$(tput setab 0)\nWeb Server configuration skipped!$(tput sgr 0)\n"
				break
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nReturn to the main menu!$(tput sgr 0)\n"
				main
				;;
			esac
		else
			echo $OPT8
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi
	done
}

function inst_db ()
{
	# declared integer for user's choice
	declare -i OPT9
	while true
	do
		echo "$(tput setaf 5)Choose the Database to install and configure:"
		echo "1 - INSTALL MYSQL"
		echo "2 - INSTALL POSTGRES" 
		echo -e "\n3 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT9
		if [ $OPT9 -ge 0 -a $OPT9 -le 3 ] 
		then
			case $OPT9 in 
				1 )
				break
				;;
				2 )
				break	
				;;
				3 )  
				echo -e "$(tput setaf 7)$(tput setab 0)\nDatabase configuration skipped!$(tput sgr 0)\n"
				break
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nReturn to the main menu!$(tput sgr 0)\n"
				main
				;;
			esac
		else
			echo $OPT9
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi
	done
}

function inst_php ()
{
	# declared integer for user's choice
	declare -i OPT10
	while true
	do
		echo "$(tput setaf 5)Choose the options to install and configure PHP with its modules:"
		echo "1 - INSTALL PHP"
		echo "2 - CONFIGURE PHP MODULES" 
		echo -e "\n3 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT10
		if [ $OPT10 -ge 0 -a $OPT10 -le 3 ] 
		then
			case $OPT10 in 
				1 )
				break
				;;
				2 )
				break	
				;;
				3 )  
				echo -e "$(tput setaf 7)$(tput setab 0)\nUFW configuration skipped!$(tput sgr 0)\n"
				break
				;;
				0 ) clear
				echo -e "$(tput setaf 7)$(tput setab 0)\nReturn to the main menu!$(tput sgr 0)\n"
				main
				;;
			esac
		else
			echo $OPT10
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi
	done
}

# Call to the main function
so_update
main
