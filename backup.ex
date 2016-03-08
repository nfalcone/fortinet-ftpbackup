#!/usr/bin/expect
#created on 3/11/15
#For backing up Fortinet configuration files to an ftp server, dated as well
#Tested to work on a FortiWifi60D

SET VARIABLES FOR SCRIPT
#########################
set HOST "MyFirewall"
set IP "192.168.1.1"
set PASS "your-password-here"
set timeout 10
set FTP 192.168.1.100
set FTPUSER fortinet
set FTPPASS password
#########################


spawn ssh admin@$IP
expect "admin@$IP's password:"
send "$PASS\n"
expect "# "
#if you want tftp, bleh
#send "execute backup full-config tftp dump_config.txt xxx.xxx.xxx.xxx\n"
send "execute backup full-config ftp [clock format [clock seconds] -format %Y.%m.%d]-$HOST-config.txt $FTP $FTPUSER $FTPPASS\n"
#have to check for '#' twice because it outputs two after a tftp starts
expect "# "
send "\n"
expect "# "
send "exit \n"

