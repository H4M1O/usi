#!/bin/bash
# Script: Universal Script Installer
# Description: USI is a textual bash script that allows to install or configure easily a Linux machine.
# Version: 1.3.5
# Date: 03-07-2016
# Author: Claudio Proietti
# License: The MIT License (MIT) - Copyright (c) 2016 Claudio Proietti

function main ()
{
# This is the main function that show the menu and allows the user to make a choice
	# declared integer for user's choice
	clear
	declare -i OPT
	while true
	do
		menu
		# read input from keyboard
		read OPT
		if [ $OPT -ge 0 -a $OPT -le 4 ] 
		then
			case $OPT in 
				1 ) OS_HARDENING 
				;;
				2 ) LAMP 
				;;
				3 ) UTILITIES
				;;
                4 ) LIZMAP
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
	clear
	declare -i SUP
	while true
	do
		menu_update
		# read input from keyboard
		read SUP
		if [ $SUP -ge 0 -a $SUP -le 2 ] 
		then
			case $SUP in 
				1 ) apt-get update && sudo apt-get upgrade -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nUPDATE AND UPGRADE COMPLETED!$(tput sgr 0)\n"
				cnt
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
	title
	echo -e "These are the available options:\n"
	echo "1 - OS_HARDENING (hostname, ifconfig, ssh, sudo, fail2ban, ufw)"
	echo "2 - LAMP (WebServer Apache or NGIX, DB MySQL or PostGres, PHP and PHP Modules)" 
	echo "3 - UTILITIES (Vim, I3, Aliasies, ecc..)"
	echo "4 - LIZMAP (Always latest version!!!)"
	echo -e "\n0 - Exit the script\n"
	echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
}

function menu_update ()
{
# The scope of this function is only to show the contextual menu for the update
	title
	echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: THE UPDATE OF THE PACKAGES IS REQUIRED!!!$(tput sgr 0)\n"
	echo -e "These are the available options:\n"
	echo "1 - UPDATE AND UPGRADE THE SYSTEM"
	echo "2 - CONTINUE WITHOUT THE UPDATE (not recommended!!!)" 
	echo -e "\n0 - Exit the script\n"
	echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
}

function title ()
{
	echo "$(tput setaf 3)$(tput bold)Welcome to U.S.I. - Universal Script Installer"
	echo -e "Script created by Claudio Proietti under MIT license$(tput sgr 0)\n"
}

function cnt () 
{
echo "Press ENTER to continue..."
read
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
	auto_updates
	echo -e "$(tput setaf 0)$(tput setab 2)\nOS_HARDENING COMPLETED!$(tput sgr 0)\n"
	cnt
}

function hst_cfg ()
{
	clear
	# declared integer for user's choice
	declare -i OPT2
	while true
	do
		title
		echo "$(tput setaf 5)Do you want change the HOSTNAME:"
		echo "1 - YES. ATTENTION: This will restart your machine!!!"
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
				echo -e "$(tput setaf 0)$(tput setab 2)\nYOUR NEW HOSTNAME IS: $HOSTNAME This machine will be restarted!$(tput sgr 0)\n"
				init 6
				cnt
				break
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
	clear
	# declared integer for user's choice
	declare -i OPT3
	while true
	do
		title
		echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: This is an Experimental function, don't use it!!!$(tput sgr 0)\n"
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
				/etc/init.d/networking restart
				echo -e "$(tput setaf 0)$(tput setab 2)\nDHCP CONFIGURED CORRECTLY!$(tput sgr 0)\n"
				cnt
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
				/etc/init.d/networking restart
				echo -e "$(tput setaf 0)$(tput setab 2)\nSTATIC IPV4 CONFIGURED CORRECTLY!$(tput sgr 0)\n"
				cnt
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
	clear
	# declared integer for user's choice
	declare -i OPT4
	while true
	do
		title
		echo "$(tput setaf 5)Choose the type of the SSH software to install and configure:"
		echo "1 - SSH CLIENT"
		echo "2 - SSH SERVER (ATTENTION: it will modify sshd_config and disable the password login!!!)" 
		echo -e "\n3 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT4
		if [ $OPT4 -ge 0 -a $OPT4 -le 3 ] 
		then
			case $OPT4 in 
				1 ) apt-get install openssh-client -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nSSH CLIENT INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				2 ) apt-get install openssh-server -y
				sshd_config
                echo -e "$(tput setaf 0)$(tput setab 2)\nSSH SERVER INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
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
	clear
	# declared integer for user's choice
	declare -i OPT5
	while true
	do
		title
		echo "$(tput setaf 5)Select the option to install sudo and configure it for a new user:"
		echo "1 - ADD A NEW USER (Experimental and actually broken, don't use it!)"
        echo "2 - INSTALL SUDO (Not recommended!)" 
		echo "3 - MODIFY SSH CONNECTIONS AND AUTORIZATIONS" 
		echo "4 - CHANGE USER PASSWORD" 
		echo -e "\n5 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT5
		if [ $OPT5 -ge 0 -a $OPT5 -le 5 ] 
		then
			case $OPT5 in 
				1 ) echo "$(tput setaf 3)Insert the Full Name of the new user (ex. Claudio Proietti): $(tput sgr 0)" 
				read FULL_NAME
				echo "$(tput setaf 3)Insert the userame of the new user (ex. cproietti): $(tput sgr 0)" 
				read USER_NAME
				echo "$(tput setaf 3)Insert the password of the new user (ex. cproietti): $(tput sgr 0)" 
				read PWD
				useradd -c $FULL_NAME -m -p $PWD -s "/bin/bash" -U $USER_NAME
				echo -e "$(tput setaf 0)$(tput setab 2)\nNEW USER ADDED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				2 ) apt-get install sudo -y
				echo "$USER_NAME ALL=(ALL) ALL" >> /etc/sudoers
				visudo
				echo -e "$(tput setaf 0)$(tput setab 2)\nVISUDO CONFIGURED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				3 ) ssh-keygen -b 4096 -t rsa
                /etc/init.d/sshd restart
                service ssh restart
                service ssh status
                clear
			    echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have the following key before continue or you will not be able to access this machine!!!$(tput sgr 0)\n"
                cat ~/.ssh/id_rsa
			    echo -e "\n$(tput setaf 7)$(tput setab 1)ATTENTION: You have the following key before continue or you will not be able to access this machine!!!$(tput sgr 0)\n"
                rm ~/.ssh/id_rsa
                echo -e "$(tput setaf 0)$(tput setab 2)\nSSHD CONFIGURED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				4 ) passwd
				echo -e "$(tput setaf 0)$(tput setab 2)\nUSER PASSWORD CHANGED CORRECTLY!$(tput sgr 0)\n"
				cnt
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
	clear
	# declared integer for user's choice
	declare -i OPT6
	while true
	do
		title
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
				1 ) apt-get install fail2ban -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nFAIL2BAN INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				2 ) f2b_local
                cp /etc/fail2ban/fail2ban.conf etc/fail2ban/fail2ban.local
				cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
				vi /etc/fail2ban/jail.local
				echo -e "$(tput setaf 0)$(tput setab 2)\nFAIL2BAN CONFIGURED CORRECTLY!$(tput sgr 0)\n"
				fail2ban-client reload
				cnt
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

function f2b_local () 
{
echo -e '
# Fail2Ban configuration file.                                                                                                                       
#                                                                                
# This file was composed for Debian systems from the original one                
# provided now under /usr/share/doc/fail2ban/examples/jail.conf                  
# for additional examples.                                                       
#                                                                                
# Comments: use '#' for comment lines and ';' for inline comments                
#                                                                                
# To avoid merges during upgrades DO NOT MODIFY THIS FILE                        
# and rather provide your changes in /etc/fail2ban/jail.local                        
#                                                                                
                                                                                 
# The DEFAULT allows a global definition of the options. They can be overridden  
# in each jail afterwards.                                                       
                                                                                 
[DEFAULT]                                                                        
                                                                                 
# "ignoreip" can be an IP address, a CIDR mask or a DNS host. Fail2ban will not  
# ban a host which matches an address in this list. Several addresses can be     
# defined using space separator.                                                 
ignoreip = 127.0.0.1/8                                                           
                                                                                 
# External command that will take an tagged arguments to ignore, e.g. <ip>,      
# and return true if the IP is to be ignored. False otherwise.                   
#                                                                                    
# ignorecommand = /path/to/command <ip>                                              
ignorecommand =                                                                  
                                                                                 
# "bantime" is the number of seconds that a host is banned.                      
bantime  = -1                                                                    
                                                                                 
# A host is banned if it has generated "maxretry" during the last "findtime"     
# seconds.                                                                       
findtime = 600                                                                   
maxretry = 3  

# "backend" specifies the backend used to get files modification.                
# Available options are "pyinotify", "gamin", "polling" and "auto".              
# This option can be overridden in each jail as well.                            
#                                                                                
# pyinotify: requires pyinotify (a file alteration monitor) to be installed.     
#            If pyinotify is not installed, Fail2ban will use auto.              
# gamin:     requires Gamin (a file alteration monitor) to be installed.         
#            If Gamin is not installed, Fail2ban will use auto.                  
# polling:   uses a polling algorithm which does not require external libraries. 
# auto:      will try to use the following backends, in order:                   
#            pyinotify, gamin, polling.                                          
backend = auto                                                                   
                                                                                 
# "usedns" specifies if jails should trust hostnames in logs,                    
#   warn when reverse DNS lookups are performed, or ignore all hostnames in logs 
#                                                                                
# yes:   if a hostname is encountered, a reverse DNS lookup will be performed.   
# warn:  if a hostname is encountered, a reverse DNS lookup will be performed,   
#        but it will be logged as a warning.                                     
# no:    if a hostname is encountered, will not be used for banning,             
#        but it will be logged as info.                                          
usedns = warn                                                                    
                                                                                 
#                                                                                
# Destination email address used solely for the interpolations in                
# jail.{conf,local} configuration files.                                         
destemail = root@localhost                                                       
                                                                                 
#                                                                                
# Name of the sender for mta actions                                             
sendername = Fail2Ban                                                            
                                                                                 
# Email address of the sender                                                    
sender = fail2ban@localhost 

#                                                                                                                                                    
# ACTIONS                                                                        
#                                                                                
                                                                                 
# Default banning action (e.g. iptables, iptables-new,                           
# iptables-multiport, shorewall, etc) It is used to define                       
# action_* variables. Can be overridden globally or per                          
# section within jail.local file                                                 
banaction = iptables-multiport                                                   
                                                                                 
# email action. Since 0.8.1 upstream fail2ban uses sendmail                      
# MTA for the mailing. Change mta configuration parameter to mail                
# if you want to revert to conventional mail.                                  
mta = sendmail                                                                   
                                                                                 
# Default protocol                                                               
protocol = tcp                                                                   
                                                                                 
# Specify chain where jumps would need to be added in iptables-* actions         
chain = INPUT                                                                    
                                                                                 
#                                                                                
# Action shortcuts. To be used to define action parameter                        
                                                                                 
# The simplest action to take: ban only                                          
action_ = %(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]
                                                                                 
# ban & send an e-mail with whois report to the destemail.                       
action_mw = %(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]
              %(mta)s-whois[name=%(__name__)s, dest="%(destemail)s", protocol="%(protocol)s", chain="%(chain)s", sendername="%(sendername)s"]
                                                                                 
# ban & send an e-mail with whois report and relevant log lines                  
# to the destemail.                                                              
action_mwl = %(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]
               %(mta)s-whois-lines[name=%(__name__)s, dest="%(destemail)s", logpath=%(logpath)s, chain="%(chain)s", sendername="%(sendername)s"]

# Choose default action.  To change, just override value of 'action' with the    
# interpolation to the chosen action shortcut (e.g.  action_mw, action_mwl, etc) in jail.local
# globally (section [DEFAULT]) or per specific section                           
action = %(action_)s                                                             
                                                                                 
#                                                                                
# JAILS                                                                          
#                                                                                
                                                                                 
# Next jails corresponds to the standard configuration in Fail2ban 0.6 which     
# was shipped in Debian. Enable any defined here jail by including               
#                                                                                
# [SECTION_NAME]                                                                 
# enabled = true                                                                 
                                                                                 
#                                                                                
# in /etc/fail2ban/jail.local.                                                   
#                                                                                
# Optionally you may override any other parameter (e.g. banaction,               
# action, port, logpath, etc) in that section within jail.local                  
                                                                                 
[ssh]                                                                            
                                                                                 
enabled  = true                                                                  
port     = ssh                                                                   
filter   = sshd                                                                  
logpath  = /var/log/auth.log                                                     
maxretry = 6                                                                     
                                                                                 
[dropbear]          

enabled  = false                                                                 
port     = ssh                                                                   
filter   = dropbear                                                              
logpath  = /var/log/auth.log                                                     
maxretry = 6                                                                     
                                                                                 
# Generic filter for pam. Has to be used with action which bans all ports        
# such as iptables-allports, shorewall                                           
[pam-generic]                                                                    
                                                                                 
enabled  = false                                                                 
# pam-generic filter can be customized to monitor specific subset of 'tty's      
filter   = pam-generic                                                           
# port actually must be irrelevant but lets leave it all for some possible uses  
port     = all                                                                   
banaction = iptables-allports                                                    
port     = anyport                                                               
logpath  = /var/log/auth.log                                                     
maxretry = 6                                                                     
                                                                                 
[xinetd-fail]                                                                    
                                                                                 
enabled   = false                                                                
filter    = xinetd-fail                                                          
port      = all                                                                  
banaction = iptables-multiport-log                                               
logpath   = /var/log/daemon.log                                                  
maxretry  = 2                                                                    
                            
[ssh-ddos]                                                                       
                                                                                 
enabled  = false                                                                 
port     = ssh                                                                   
filter   = sshd-ddos                                                             
logpath  = /var/log/auth.log                                                     
maxretry = 6                                                                     
                                                                                 
                                                                                 
# Here we use blackhole routes for not requiring any additional kernel support   
# to store large volumes of banned IPs                                           
                                                                                 
[ssh-route]                                                                      
                                                                                 
enabled = false                                                                  
filter = sshd                                                                    
action = route                                                                   
logpath = /var/log/sshd.log                                                      
maxretry = 6                                                                     
                                                                                 
# Here we use a combination of Netfilter/Iptables and IPsets                     
# for storing large volumes of banned IPs                                        
#                                                                                
# IPset comes in two versions. See ipset -V for which one to use                 
# requires the ipset package and kernel support.                                 
[ssh-iptables-ipset4]                                                            
                                                                                 
enabled  = false                                                                 
port     = ssh                                                                   
filter   = sshd                                                                  
banaction = iptables-ipset-proto4                                                
logpath  = /var/log/sshd.log                                                     
maxretry = 6                     

[ssh-iptables-ipset6]                                                            
                                                                                 
enabled  = false                                                                 
port     = ssh                                                                   
filter   = sshd                                                                  
banaction = iptables-ipset-proto6                                                
logpath  = /var/log/sshd.log                                                     
maxretry = 6                                                                     
                                                                                 
                                                                                 
#                                                                                
# HTTP servers                                                                   
#                                                                                
                                                                                 
[apache]                                                                         
                                                                                 
enabled  = false                                                                 
port     = http,https                                                            
filter   = apache-auth                                                           
logpath  = /var/log/apache*/*error.log                                           
maxretry = 6                                                                     
                                                                                 
# default action is now multiport, so apache-multiport jail was left             
# for compatibility with previous (<0.7.6-2) releases                            
[apache-multiport]                                                               
                                                                                 
enabled   = false                                                                
port      = http,https                                                           
filter    = apache-auth                                                          
logpath   = /var/log/apache*/*error.log                                          
maxretry  = 6              

[apache-noscript]                                                                
                                                                                 
enabled  = false                                                                 
port     = http,https                                                            
filter   = apache-noscript                                                       
logpath  = /var/log/apache*/*error.log                                           
maxretry = 6                                                                     
                                                                                 
[apache-overflows]                                                               
                                                                                 
enabled  = false                                                                 
port     = http,https                                                            
filter   = apache-overflows                                                      
logpath  = /var/log/apache*/*error.log                                           
maxretry = 2                                                                     
                                                                                 
[apache-modsecurity]                                                             
                                                                                 
enabled  = false                                                                 
filter   = apache-modsecurity                                                    
port     = http,https                                                            
logpath  = /var/log/apache*/*error.log                                           
maxretry = 2                                                                     
                                                                                 
[apache-nohome]                                                                  
                                                                                 
enabled  = false                                                                 
filter   = apache-nohome                                                         
port     = http,https                                                            
logpath  = /var/log/apache*/*error.log                                           
maxretry = 2                                                                     
                                                                                 
# Ban attackers that try to use PHPs URL-fopen() functionality                  
# through GET/POST variables. - Experimental, with more than a year              
# of usage in production environments.

[php-url-fopen]                                                                  
                                                                                 
enabled = false                                                                  
port    = http,https                                                             
filter  = php-url-fopen                                                          
logpath = /var/www/*/logs/access_log                                             
                                                                                 
# A simple PHP-fastcgi jail which works with lighttpd.                           
# If you run a lighttpd server, then you probably will                           
# find these kinds of messages in your error_log:                                
#   ALERT – tried to register forbidden variable ‘GLOBALS’                       
#   through GET variables (attacker '1.2.3.4', file '/var/www/default/htdocs/index.php')
                                                                                 
[lighttpd-fastcgi]                                                               
                                                                                 
enabled = false                                                                  
port    = http,https                                                             
filter  = lighttpd-fastcgi                                                       
logpath = /var/log/lighttpd/error.log                                            
                                                                                 
# Same as above for mod_auth                                                     
# It catches wrong authentifications                                             
                                                                                 
[lighttpd-auth]                                                                  
                                                                                 
enabled = false                                                                  
port    = http,https                                                             
filter  = suhosin                                                                
logpath = /var/log/lighttpd/error.log

[nginx-http-auth]                                                                
                                                                                 
enabled = false                                                                  
filter  = nginx-http-auth                                                        
port    = http,https                                                             
logpath = /var/log/nginx/error.log                                               
                                                                                 
# Monitor roundcube server                                                       
                                                                                 
[roundcube-auth]                                                                 
                                                                                 
enabled  = false                                                                 
filter   = roundcube-auth                                                        
port     = http,https                                                            
logpath  = /var/log/roundcube/userlogins                                         
                                                                                 
                                                                                 
[sogo-auth]                                                                      
                                                                                 
enabled  = false                                                                 
filter   = sogo-auth                                                             
port     = http, https                                                           
# without proxy this would be:                                                   
# port    = 20000                                                                
logpath  = /var/log/sogo/sogo.log                                                
                                                                                 
                                                                                 
#                                                                                
# FTP servers                                                                    
#                                                                                
                                
[vsftpd]                                                                         
                                                                                 
enabled  = false                                                                 
port     = ftp,ftp-data,ftps,ftps-data                                           
filter   = vsftpd                                                                
logpath  = /var/log/vsftpd.log                                                   
# or overwrite it in jails.local to be                                           
# logpath = /var/log/auth.log                                                    
# if you want to rely on PAM failed login attempts                               
# vsftpds failregex should match both of those formats                          
maxretry = 6                                                                     
                                                                                 
                                                                                 
[proftpd]                                                                        
                                                                                 
enabled  = false                                                                 
port     = ftp,ftp-data,ftps,ftps-data                                           
filter   = proftpd                                                               
logpath  = /var/log/proftpd/proftpd.log                                          
maxretry = 6                                                                     
                                                                                 
                                                                                 
[pure-ftpd]                                                                      
                                                                                 
enabled  = false                                                                 
port     = ftp,ftp-data,ftps,ftps-data                                           
filter   = pure-ftpd                                                             
logpath  = /var/log/syslog                                                       
maxretry = 6                                                                     

[wuftpd]                                                                         
                                                                                 
enabled  = false                                                                 
port     = ftp,ftp-data,ftps,ftps-data                                           
filter   = wuftpd                                                                
logpath  = /var/log/syslog                                                       
maxretry = 6                                                                     
                                                                                 
                                                                                 
#                                                                                
# Mail servers                                                                   
#                                                                                
                                                                                 
[postfix]                                                                        
                                                                                 
enabled  = false                                                                 
port     = smtp,ssmtp,submission                                                 
filter   = postfix                                                               
logpath  = /var/log/mail.log                                                     
                                                                                 
                                                                                 
[couriersmtp]                                                                    
                                                                                 
enabled  = false                                                                 
port     = smtp,ssmtp,submission                                                 
filter   = couriersmtp                                                           
logpath  = /var/log/mail.log                                                     
                                                                                 
                                                                                 
#                                                                                
# Mail servers authenticators: might be used for smtp,ftp,imap servers, so       
# all relevant ports get banned                                                  
#                              

[courierauth]                                                                    
                                                                                 
enabled  = false                                                                 
port     = smtp,ssmtp,submission,imap2,imap3,imaps,pop3,pop3s                    
filter   = courierlogin                                                          
logpath  = /var/log/mail.log                                                     
                                                                                 
                                                                                 
[sasl]                                                                           
                                                                                 
enabled  = false                                                                 
port     = smtp,ssmtp,submission,imap2,imap3,imaps,pop3,pop3s                    
filter   = postfix-sasl                                                          
# You might consider monitoring /var/log/mail.warn instead if you are            
# running postfix since it would provide the same log lines at the               
# "warn" level but overall at the smaller filesize.                              
logpath  = /var/log/mail.log                                                     
                                                                                 
[dovecot]                                                                        
                                                                                 
enabled = false                                                                  
port    = smtp,ssmtp,submission,imap2,imap3,imaps,pop3,pop3s                     
filter  = dovecot                                                                
logpath = /var/log/mail.log                                                      
                                                                                 
# To log wrong MySQL access attempts add to /etc/my.cnf:                         
# log-error=/var/log/mysqld.log                                                  
# log-warning = 2                                                                
[mysqld-auth]                                                                    
                                                                                 
enabled  = false                                                                 
filter   = mysqld-auth                                                           
port     = 3306                                                                  
logpath  = /var/log/mysqld.log     
                     
# DNS Servers                                                                    
                                                                                 
                                                                                 
# These jails block attacks against named (bind9). By default, logging is off    
# with bind9 installation. You will need something like this:                    
#                                                                                
# logging {                                                                      
#     channel security_file {                                                    
#         file "/var/log/named/security.log" versions 3 size 30m;                
#         severity dynamic;                                                      
#         print-time yes;                                                        
#     };                                                                         
#     category security {                                                        
#         security_file;                                                         
#     };                                                                         
# };                                                                             
#                                                                                
# in your named.conf to provide proper logging                                   
                                                                                 
# !!! WARNING !!!                                                                
#   Since UDP is connection-less protocol, spoofing of IP and imitation          
#   of illegal actions is way too simple.  Thus enabling of this filter          
#   might provide an easy way for implementing a DoS against a chosen            
#   victim. See                                                                  
#    http://nion.modprobe.de/blog/archives/690-fail2ban-+-dns-fail.html          
#   Please DO NOT USE this jail unless you know what you are doing.              
#[named-refused-udp]                                                             
#                                                                                
#enabled  = false                                                                
#port     = domain,953                                                           
#protocol = udp                                                                  
#filter   = named-refused                                                        
#logpath  = /var/log/named/security.log

[named-refused-tcp]                                                              
                                                                                 
enabled  = false                                                                 
port     = domain,953                                                            
protocol = tcp                                                                   
filter   = named-refused                                                         
logpath  = /var/log/named/security.log                                           
                                                                                 
[freeswitch]                                                                     
                                                                                 
enabled  = false                                                                 
filter   = freeswitch                                                            
logpath  = /var/log/freeswitch.log                                               
maxretry = 10                                                                    
action   = iptables-multiport[name=freeswitch-tcp, port="5060,5061,5080,5081", protocol=tcp]
           iptables-multiport[name=freeswitch-udp, port="5060,5061,5080,5081", protocol=udp]
                                                                                 
[ejabberd-auth]                                                                  
                                                                                 
enabled  = false                                                                 
filter   = ejabberd-auth                                                         
port     = xmpp-client                                                           
protocol = tcp                                                                   
logpath  = /var/log/ejabberd/ejabberd.log                                        
                                                                                 
                                                                                 
# Multiple jails, 1 per protocol, are necessary ATM:                             
# see https://github.com/fail2ban/fail2ban/issues/37                             
[asterisk-tcp]                                                                   
                                                      
enabled  = false                                                                 
filter   = asterisk                                                              
port     = 5060,5061                                                             
protocol = tcp                                                                   
logpath  = /var/log/asterisk/messages                                            
                                                                                 
[asterisk-udp]                                                                   
                                                                                 
enabled  = false                                                                 
filter   = asterisk                                                              
port     = 5060,5061                                                             
protocol = udp                                                                   
logpath  = /var/log/asterisk/messages                                            
                                                                                 
                                                                                 
# Jail for more extended banning of persistent abusers                           
# !!! WARNING !!!                                                                
#   Make sure that your loglevel specified in fail2ban.conf/.local               
#   is not at DEBUG level -- which might then cause fail2ban to fall into        
#   an infinite loop constantly feeding itself with non-informative lines        
[recidive]                                                                       
                                                                                 
enabled  = false                                                                 
filter   = recidive                                                              
logpath  = /var/log/fail2ban.log                                                 
action   = iptables-allports[name=recidive]                                      
           sendmail-whois-lines[name=recidive, logpath=/var/log/fail2ban.log]    
bantime  = 604800  ; 1 week                                                      
findtime = 86400   ; 1 day                                                       
maxretry = 5

# See the IMPORTANT note in action.d/blocklist_de.conf for when to               
# use this action                                                                
#                                                                                
# Report block via blocklist.de fail2ban reporting service API                   
# See action.d/blocklist_de.conf for more information                            
[ssh-blocklist]                                                                  
                                                                                 
enabled  = false                                                                 
filter   = sshd                                                                  
action   = iptables[name=SSH, port=ssh, protocol=tcp]                            
           sendmail-whois[name=SSH, dest="%(destemail)s", sender="%(sender)s", sendername="%(sendername)s"]
           blocklist_de[email="%(sender)s", apikey="xxxxxx", service="%(filter)s"]
logpath  = /var/log/sshd.log                                                     
maxretry = 20                                                                    
                                                                                 
                                                                                 
# consider low maxretry and a long bantime                                       
# nobody except your own Nagios server should ever probe nrpe                    
[nagios]                                                                         
enabled  = false                                                                 
filter   = nagios                                                                
action   = iptables[name=Nagios, port=5666, protocol=tcp]                        
           sendmail-whois[name=Nagios, dest="%(destemail)s", sender="%(sender)s", sendername="%(sendername)s"]
logpath  = /var/log/messages     ; nrpe.cfg may define a different log_facility  
maxretry = 1
' > /etc/fail2ban/jail.local
}

function inst_ufw ()
{
	clear
	# declared integer for user's choice
	declare -i OPT7
	while true
	do
		title
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
				1 ) apt-get install ufw -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nUFW INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				2 ) ufw enable
				ufw default deny incoming
				ufw default allow outgoing
				ufw allow ssh
				ufw allow http
				ufw status verbose
				echo -e "$(tput setaf 0)$(tput setab 2)\nUFW CONFIGURED CORRECTLY!$(tput sgr 0)\n"
				cnt
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

function auto_updates ()
{
	clear
	# declared integer for user's choice
	declare -i OPT6
	while true
	do
		title
		echo "$(tput setaf 5)Choose the options to install and configure automatic updates:"
		echo "1 - INSTALL AUTO-UPDATES"
		echo "2 - CONFIGURE AUTO-UPDATES" 
		echo -e "\n3 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT6
		if [ $OPT6 -ge 0 -a $OPT6 -le 3 ] 
		then
			case $OPT6 in 
				1 ) apt-get install unattended-upgrades apt-listchanges -y
				touch  /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "// Control parameters for cron jobs by /etc/cron.daily/apt //" > /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "// Enable the update/upgrade script (0=disable)" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "APT::Periodic::Enable "1";" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "// Do "apt-get update" automatically every n-days (0=disable)" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "APT::Periodic::Update-Package-Lists "1";" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "// Do "apt-get upgrade --download-only" every n-days (0=disable)" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "APT::Periodic::Download-Upgradeable-Packages "1";" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "// Run the "unattended-upgrade" security upgrade script" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "// every n-days (0=disabled)" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "// Requires the package "unattended-upgrades" and will write" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "// a log in /var/log/unattended-upgrades" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "APT::Periodic::Unattended-Upgrade "1";" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "// Do "apt-get autoclean" every n-days (0=disable)" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "APT::Periodic::AutocleanInterval "21";" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "// Send report mail to root" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "//     0:  no report             (or null string)" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "//     1:  progress report       (actually any string)" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "//     2:  + command outputs     (remove -qq, remove 2>/dev/null, add -d)" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "//     3:  + trace on" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "APT::Periodic::Verbose "2";" >> /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "$(tput setaf 0)$(tput setab 2)\nAUTOMATIC UPDATES INSTALLED AND CONFIGURED CORRECTLY (Security Updates)!$(tput sgr 0)\n"
				cnt
				;;
				2 ) vi /etc/apt/apt.conf.d/50unattended-upgrades 
				vi /etc/apt/apt.conf.d/20auto-upgrades
				echo -e "$(tput setaf 0)$(tput setab 2)\nAUTO UPDATES CONFIGURED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				3 )  
				echo -e "$(tput setaf 7)$(tput setab 0)\nAutomatic Updates configuration skipped!$(tput sgr 0)\n"
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

function sshd_config () 
{
echo -e '
# Package generated configuration file                             
# See the sshd_config(5) manpage for details                                                            
# What ports, IPs and protocols we listen for                   
Port 22                                                        
# Use these options to restrict which interfaces/protocols sshd will bind to     
#ListenAddress ::                                                
#ListenAddress 0.0.0.0                                      
Protocol 2                                                          
# HostKeys for protocol version 2                               
HostKey /etc/ssh/ssh_host_rsa_key                               
HostKey /etc/ssh/ssh_host_dsa_key                               
HostKey /etc/ssh/ssh_host_ecdsa_key                                
HostKey /etc/ssh/ssh_host_ed25519_key                         
#Privilege Separation is turned on for security               
UsePrivilegeSeparation yes                                       
                                                           
# Lifetime and size of ephemeral version 1 server key     
KeyRegenerationInterval 3600                             
ServerKeyBits 1024                                     
                                                          
# Logging                                                           
SyslogFacility AUTH
LogLevel INFO                                                            

# Authentication:                                                  
LoginGraceTime 120
PermitRootLogin no
StrictModes yes                                                          

RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile /home/%u/.ssh/id_rsa.pub

# Dont read the users ~/.rhosts and ~/.shosts files                 
IgnoreRhosts yes                                                         
# For this to work you will also need host keys in /etc/ssh_known_hosts  
RhostsRSAAuthentication no                                            
# similar for protocol version 2                                         
HostbasedAuthentication no                                               
# Uncomment if you dont trust ~/.ssh/known_hosts for RhostsRSAAuthentication    
#IgnoreUserKnownHosts yes                                                                                                                  
# To enable empty passwords, change to yes (NOT RECOMMENDED)             
PermitEmptyPasswords no                                                  
                                                                         
# Change to yes to enable challenge-response passwords (beware issues with       
# some PAM modules and threads)                                          
ChallengeResponseAuthentication no                                       
                                                                         
# Change to no to disable tunnelled clear text passwords                 
PasswordAuthentication no                                                
                                                                         
# Kerberos options                                                       
#KerberosAuthentication no                                               
#KerberosGetAFSToken no                                                  
#KerberosOrLocalPasswd yes                                               
#KerberosTicketCleanup yes                                               
                                                                         
# GSSAPI options                                                         
#GSSAPIAuthentication no                                                 
#GSSAPICleanupCredentials yes                                            
                                                                         
X11Forwarding yes                                                        
X11DisplayOffset 10                                                      
PrintMotd no                                                             
PrintLastLog yes                                                         
TCPKeepAlive yes     
#UseLogin no                                                             
                                                                         
#MaxStartups 10:30:60                                                    
#Banner /etc/issue.net                                                   
                                                                         
# Allow client to pass locale environment variables                      
AcceptEnv LANG LC_*                                                      
                                                                         
Subsystem sftp /usr/lib/openssh/sftp-server                              
                                                                         
# Set this to yes to enable PAM authentication, account processing,    
# and session processing. If this is enabled, PAM authentication will    
# be allowed through the ChallengeResponseAuthentication and             
# PasswordAuthentication.  Depending on your PAM configuration,          
# PAM authentication via ChallengeResponseAuthentication may bypass      
# the setting of "PermitRootLogin without-password".                     
# If you just want the PAM account and session checks to run without     
# PAM authentication, then enable this but set PasswordAuthentication    
# and ChallengeResponseAuthentication to no.                           
UsePAM no
' > /etc/ssh/sshd_config
}

function LAMP ()
{
# This function is used to install and configure a LAMP Server
# It will use the following other functions.
	clear	
	inst_webserv	
	inst_db 
	inst_php
	echo -e "$(tput setaf 0)$(tput setab 2)\nLAMP INSTALLATION COMPLETED!$(tput sgr 0)\n"
	cnt
}

function inst_webserv ()
{
	clear
	# declared integer for user's choice
	declare -i OPT8
	while true
	do
		title
		echo "$(tput setaf 5)Choose the Web Server to install and configure:"
		echo "1 - INSTALL APACHE"
		echo "2 - INSTALL NGIX (Experimental!) " 
		echo -e "\n3 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT8
		if [ $OPT8 -ge 0 -a $OPT8 -le 3 ] 
		then
			case $OPT8 in 
				1 ) apt-get install apache2 apache2-doc -y
				service apache2 restart
				echo -e "$(tput setaf 0)$(tput setab 2)\nAPACHE2 INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				break
				;;
				2 )  apt-get install nginx -y
				systemctl restart nginx.service
				echo -e "$(tput setaf 0)$(tput setab 2)\nNGIX INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
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
	clear
	# declared integer for user's choice
	declare -i OPT9
	while true
	do
		title
		echo "$(tput setaf 5)Choose the Database to install and configure:"
		echo "1 - INSTALL MYSQL SERVER AND CLIENT"
		echo "2 - INSTALL MYSQL CLIENT ONLY"
		echo "3 - INSTALL POSTGRES SERVER AND CLIENT (Experimental!)"
		echo "4 - INSTALL POSTGRES CLIENT ONLY (Experimental!)"
		echo -e "\n5 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT9
		if [ $OPT9 -ge 0 -a $OPT9 -le 5 ] 
		then
			case $OPT9 in 
				1 ) apt-get install mysql-server -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nMYSQL-SERVER AND CLIENT INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				break
				;;
				2 ) apt-get install mysql-client -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nMYSQL-CLIENT INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				break
				;;
				3 ) apt-get install postgresql-9.4 postgresql-client-9.4 postgresql-doc -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nPOSTGRES-SERVER AND CLIENT INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				break	
				;;
				4 ) apt-get install postgresql-client-9.4 postgresql-doc -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nPOSTGRES-CLIENT INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				break	
				;;
				5 )  
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
	clear
	# declared integer for user's choice
	declare -i OPT10
	while true
	do
		title
		echo "$(tput setaf 5)Choose the options to install and configure PHP with its modules:"
		echo "1 - INSTALL AND CONFIGURE PHP FOR APACHE"
		echo "2 - INSTALL AND CONFIGURE PHP FOR NGIX (Experimental!)"
		echo "3 - INSTALL AND CONFIGURE PHP MODULES FOR MYSQL"
		echo "4 - INSTALL AND CONFIGURE PHP MODULES FOR POSTGRES"
		echo -e "\n5 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT10
		if [ $OPT10 -ge 0 -a $OPT10 -le 5 ] 
		then
			case $OPT10 in 
				1 ) apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
				touch /var/www/html/info.php
				echo "<?php phpinfo(); ?>" > /var/www/html/info.php
				chmod 777 /var/www/html/info.php
				echo -e "$(tput setaf 0)$(tput setab 2)\nPHP FOR APACHE INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				2 ) apt-get install php5-fpm -y
				touch /usr/share/ngix/www/info.php
				echo "<?php phpinfo(); ?>" > /var/www/html/info.php
				chmod 777 /var/www/html/info.php
				echo -e "$(tput setaf 0)$(tput setab 2)\nPHP FOR NIGIX INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				3 ) apt-get install php5-mysql -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nPHP MODULES FOR MYSQL INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				4 ) apt-get install php5-pgsql -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nPHP MODULES FOR POSTGRES INSTALLED CORRECTLY!$(tput sgr 0)\n"
				cnt
				;;
				5)  
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

function UTILITIES ()
{
	clear
	# declared integer for user's choice
	declare -i OPT5
	while true
	do
		title
		echo "$(tput setaf 5)Select the option to install and configure the following utilities:"
		echo "1 - INSTALL AND CONFIGURE VIM"
		echo "2 - INSTALL CURL" 
		echo "3 - INSTALL I3" 
		echo "4 - INSTALL TMUX" 
		echo -e "\n5 - Skip this configuration..." 
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT5
		if [ $OPT5 -ge 0 -a $OPT5 -le 4 ] 
		then
			case $OPT5 in 
				1 ) apt-get install vim -y
				touch .vimrc
				mkdir ~/.vim/
				mkdir ~/.vim/colors
				touch molokai.vim
				molokai > molokai.vim
				echo ":colorscheme slate" > .vimrc
				echo ":set cursorcolumn" >> .vimrc
				echo ":set cursorline" >> .vimrc
				echo ":set number" >> .vimrc
				echo ":set numberwidth=5" >> .vimrc
				echo ":set autoindent" >> .vimrc
				echo ":syntax on" >> .vimrc
				echo ":colorscheme molokai" >> .vimrc
				echo ":let g:netrw_liststyle=3" >> .vimrc
				echo ":nnoremap <F2> :set invpaste paste?<CR>" >> .vimrc 
				echo ":set pastetoggle=<F2>" >> .vimrc
 				echo ":set showmode" >> .vimrc
				echo ":set hystory=50" >> .vimrc
				echo ":set ruler" >> .vimrc
				echo ":set showcmd" >> .vimrc
				echo ":set laststatus=2" >> .vimrc
				echo ":set autowrite" >> .vimrc
				echo ":set reload" >> .vimrc
				echo ":set visualbell" >> .vimrc
				echo ":set gdefault" >> .vimrc
				echo ":set ignorecase" >> .vimrc
				echo ":set smartcase" >> .vimrc
				echo ":set hlsearch" >> .vimrc
				echo ":set incsearch" >> .vimrc
				echo ":set showmatch" >> .vimrc
				echo ":set tabstop=4" >> .vimrc
				echo ":set colorcolumn=+1" >> .vimrc
				mv .vimrc ~/
				mv molokai.vim ~/.vim/colors/
				echo -e "$(tput setaf 0)$(tput setab 2)\nINSTALLATION AND CONFIGURATION OF VIM COMPLETED!$(tput sgr 0)\n"
				cnt
				break
				;;
				2 ) apt-get install curl -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nINSTALLATION OF CURL COMPLETED!$(tput sgr 0)\n"
				cnt
				;;
				3 ) apt-get install i3 -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nINSTALLATION OF I3 COMPLETED!$(tput sgr 0)\n"
				cnt
				;;
				4 ) apt-get install tmux -y
				echo -e "$(tput setaf 0)$(tput setab 2)\nINSTALLATION OF TMUX COMPLETED!$(tput sgr 0)\n"
				cnt
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

function molokai () 
{
echo -e '
" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"
" Note: Based on the Monokai theme for TextMate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"

hi clear

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokai"

if exists("g:molokai_original")
    let s:molokai_original = g:molokai_original
else
    let s:molokai_original = 0
endif


hi Boolean         guifg=#AE81FF
hi Character       guifg=#E6DB74
hi Number          guifg=#AE81FF
hi String          guifg=#E6DB74
hi Conditional     guifg=#F92672               gui=bold
hi Constant        guifg=#AE81FF               gui=bold
hi Cursor          guifg=#000000 guibg=#F8F8F0
hi iCursor         guifg=#000000 guibg=#F8F8F0
hi Debug           guifg=#BCA3A3               gui=bold
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=italic,bold

hi Directory       guifg=#A6E22E               gui=bold
hi Error           guifg=#E6DB74 guibg=#1E0010
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=bold
hi Exception       guifg=#A6E22E               gui=bold
hi Float           guifg=#AE81FF
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#F92672               gui=bold
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic

hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

hi PreCondit       guifg=#A6E22E               gui=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF
hi Repeat          guifg=#F92672               gui=bold
hi Search          guifg=#000000 guibg=#FFE792
" marks
hi SignColumn      guifg=#A6E22E guibg=#232526
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#7E8E91               gui=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#F92672               gui=bold
hi StatusLine      guifg=#455354 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#F92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

hi TabLineFill     guifg=#1B1D1E guibg=#1B1D1E
hi TabLine         guibg=#1B1D1E guifg=#808080 gui=none

if s:molokai_original == 1
   hi Normal          guifg=#F8F8F2 guibg=#272822
   hi Comment         guifg=#75715E
   hi CursorLine                    guibg=#3E3D32
   hi CursorLineNr    guifg=#FD971F               gui=none
   hi CursorColumn                  guibg=#3E3D32
   hi ColorColumn                   guibg=#3B3A32
   hi LineNr          guifg=#BCBCBC guibg=#3B3A32
   hi NonText         guifg=#75715E
   hi SpecialKey      guifg=#75715E
else
   hi Normal          guifg=#F8F8F2 guibg=#1B1D1E
   hi Comment         guifg=#7E8E91
   hi CursorLine                    guibg=#293739
   hi CursorLineNr    guifg=#FD971F               gui=none
   hi CursorColumn                  guibg=#293739
   hi ColorColumn                   guibg=#232526
   hi LineNr          guifg=#465457 guibg=#232526
   hi NonText         guifg=#465457
   hi SpecialKey      guifg=#465457
end

"
" Support for 256-color terminal
"
if &t_Co > 255
   if s:molokai_original == 1
      hi Normal                   ctermbg=234
      hi CursorLine               ctermbg=235   cterm=none
      hi CursorLineNr ctermfg=208               cterm=none
   else
      hi Normal       ctermfg=252 ctermbg=233
      hi CursorLine               ctermbg=234   cterm=none
      hi CursorLineNr ctermfg=208               cterm=none
   endif
   hi Boolean         ctermfg=135
   hi Character       ctermfg=144
   hi Number          ctermfg=135
   hi String          ctermfg=144
   hi Conditional     ctermfg=161               cterm=bold
   hi Constant        ctermfg=135               cterm=bold
   hi Cursor          ctermfg=16  ctermbg=253
   hi Debug           ctermfg=225               cterm=bold
   hi Define          ctermfg=81
   hi Delimiter       ctermfg=241

   hi DiffAdd                     ctermbg=24
   hi DiffChange      ctermfg=181 ctermbg=239
   hi DiffDelete      ctermfg=162 ctermbg=53
   hi DiffText                    ctermbg=102 cterm=bold

   hi Directory       ctermfg=118               cterm=bold
   hi Error           ctermfg=219 ctermbg=89
   hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
   hi Exception       ctermfg=118               cterm=bold
   hi Float           ctermfg=135
   hi FoldColumn      ctermfg=67  ctermbg=16
   hi Folded          ctermfg=67  ctermbg=16
   hi Function        ctermfg=118
   hi Identifier      ctermfg=208               cterm=none
   hi Ignore          ctermfg=244 ctermbg=232
   hi IncSearch       ctermfg=193 ctermbg=16

   hi keyword         ctermfg=161               cterm=bold
   hi Label           ctermfg=229               cterm=none
   hi Macro           ctermfg=193
   hi SpecialKey      ctermfg=81

   hi MatchParen      ctermfg=233  ctermbg=208 cterm=bold
   hi ModeMsg         ctermfg=229
   hi MoreMsg         ctermfg=229
   hi Operator        ctermfg=161

   " complete menu
   hi Pmenu           ctermfg=81  ctermbg=16
   hi PmenuSel        ctermfg=255 ctermbg=242
   hi PmenuSbar                   ctermbg=232
   hi PmenuThumb      ctermfg=81

   hi PreCondit       ctermfg=118               cterm=bold
   hi PreProc         ctermfg=118
   hi Question        ctermfg=81
   hi Repeat          ctermfg=161               cterm=bold
   hi Search          ctermfg=0   ctermbg=222   cterm=NONE

   " marks column
   hi SignColumn      ctermfg=118 ctermbg=235
   hi SpecialChar     ctermfg=161               cterm=bold
   hi SpecialComment  ctermfg=245               cterm=bold
   hi Special         ctermfg=81
   if has("spell")
       hi SpellBad                ctermbg=52
       hi SpellCap                ctermbg=17
       hi SpellLocal              ctermbg=17
       hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse
   endif
   hi Statement       ctermfg=161               cterm=bold
   hi StatusLine      ctermfg=238 ctermbg=253
   hi StatusLineNC    ctermfg=244 ctermbg=232
   hi StorageClass    ctermfg=208
   hi Structure       ctermfg=81
   hi Tag             ctermfg=161
   hi Title           ctermfg=166
   hi Todo            ctermfg=231 ctermbg=232   cterm=bold

   hi Typedef         ctermfg=81
   hi Type            ctermfg=81                cterm=none
   hi Underlined      ctermfg=244               cterm=underline

   hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
   hi VisualNOS                   ctermbg=238
   hi Visual                      ctermbg=235
   hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
   hi WildMenu        ctermfg=81  ctermbg=16

   hi Comment         ctermfg=59
   hi CursorColumn                ctermbg=236
   hi ColorColumn                 ctermbg=236
   hi LineNr          ctermfg=250 ctermbg=236
   hi NonText         ctermfg=59

   hi SpecialKey      ctermfg=59

   if exists("g:rehash256") && g:rehash256 == 1
       hi Normal       ctermfg=252 ctermbg=234
       hi CursorLine               ctermbg=236   cterm=none
       hi CursorLineNr ctermfg=208               cterm=none

       hi Boolean         ctermfg=141
       hi Character       ctermfg=222
       hi Number          ctermfg=141
       hi String          ctermfg=222
       hi Conditional     ctermfg=197               cterm=bold
       hi Constant        ctermfg=141               cterm=bold

       hi DiffDelete      ctermfg=125 ctermbg=233

       hi Directory       ctermfg=154               cterm=bold
       hi Error           ctermfg=222 ctermbg=233
       hi Exception       ctermfg=154               cterm=bold
       hi Float           ctermfg=141
       hi Function        ctermfg=154
       hi Identifier      ctermfg=208

       hi Keyword         ctermfg=197               cterm=bold
       hi Operator        ctermfg=197
       hi PreCondit       ctermfg=154               cterm=bold
       hi PreProc         ctermfg=154
       hi Repeat          ctermfg=197               cterm=bold

       hi Statement       ctermfg=197               cterm=bold
       hi Tag             ctermfg=197
       hi Title           ctermfg=203
       hi Visual                      ctermbg=238

       hi Comment         ctermfg=244
       hi LineNr          ctermfg=239 ctermbg=235
       hi NonText         ctermfg=239
       hi SpecialKey      ctermfg=239
   endif
end

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
'
}

function LIZMAP ()
{
	clear
	# declared integer for user's choice
	declare -i OPT10
	while true
	do
		title
		echo "$(tput setaf 5)Choose the options to install and configure LIZMAP:"
        echo "1 - INSTALL AND CONFIGURE LIZMAP (Apache must be installed first!!!)"
		echo -e "\n0 - Return to the main menu\n"
		echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
		# readed input from keyboard
		read OPT10
		if [ $OPT10 -ge 0 -a $OPT10 -le 1 ] 
		then
			case $OPT10 in 
				1 ) apt-get install unzip curl apache2 apache2-doc php5 libapache2-mod-php5 php5-mcrypt php5-sqlite php5-gd php5-xmlrpc -y 
                wget https://github.com/3liz/lizmap-web-client/archive/master.zip -P /var/www/
				unzip /var/www/master.zip -d /var/www/
				mv /var/www/lizmap-web-client-master /var/www/mylizmap
				rm /var/www/master.zip
                cd /var/www/mylizmap/
				/var/www/mylizmap/lizmap/install/set_rights.sh www-data www-data
				cp /var/www/mylizmap/lizmap/var/config/lizmapConfig.ini.php.dist /var/www/mylizmap/lizmap/var/config/lizmapConfig.ini.php
				cp /var/www/mylizmap/lizmap/var/config/localconfig.ini.php.dist /var/www/mylizmap/lizmap/var/config/localconfig.ini.php
				cp /var/www/mylizmap/lizmap/var/config/profiles.ini.php.dist /var/www/mylizmap/lizmap/var/config/profiles.ini.php
				echo "[modules]" >> /var/www/mylizmap/lizmap/var/config/localconfig.ini.php
				echo "lizmap.installparam=demo" >> /var/www/mylizmap/lizmap/var/config/localconfig.ini.php
				php /var/www/mylizmap/lizmap/install/installer.php				
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
