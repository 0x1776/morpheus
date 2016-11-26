#!/bin/sh


# Resize terminal windows size befor running the tool (gnome terminal)
# Special thanks to h4x0r Milton@Barra for this little piece of heaven! :D
resize -s 29 86 > /dev/null
# inicio




# ---------------------
# check if user is root
# ---------------------
if [ $(id -u) != "0" ]; then
echo "[☠ ] we need to be root to run this script..."
echo "[☠ ] execute [ sudo ./venom.sh ] on terminal"
exit
else
echo "root user" > /dev/null 2>&1
fi




# -----------------------------------
# Colorise shell Script output leters
# -----------------------------------
Colors() {
Escape="\033";
  white="${Escape}[0m";
  RedF="${Escape}[31m";
  GreenF="${Escape}[32m";
  YellowF="${Escape}[33m";
  BlueF="${Escape}[34m";
  CyanF="${Escape}[36m";
Reset="${Escape}[0m";
}




# pass arguments to script [ -h ]
# we can use: ./morpheus.sh -h for help menu
while getopts ":h" opt; do
  case $opt in
    h)
cat << !
---
-- Author: r00t-3xp10it | SSA RedTeam @2016
-- Supported: Linux Kali, Ubuntu, Mint, Parrot OS
-- Suspicious-Shell-Activity (SSA) RedTeam develop @2016
---

   morpheus.sh framework automates tcp/udp packet manipulation tasks by using
   ettercap filters to manipulate target http requests under MitM attacks
   replacing the http packet contents by our own contents befor sending the
   packet back to the host that have request for it (tcp/ip hijacking).

   morpheus ships with a collection of etter filters writen be me to acomplish
   various tasks: replacing images in webpages, replace text in webpages, inject
   payloads using html <form> tag, denial-of-service attack (drop packets from source)
   https/ssh downgrade attacks, redirect target browser traffic to another ip address
   and also gives you the ability to build/compile your filter from scratch and lunch
   it through morpheus framework.
!
   exit
    ;;
    \?)
      echo ${RedF}[x]${white} Invalid option:${RedF} -$OPTARG ${Reset}; >&2
      exit
    ;;
  esac
done




# ---------------------
# Variable declarations
# ---------------------
V3R="1.1" # module version number
DiStR0=`awk '{print $1}' /etc/issue` # grab distribution -  Ubuntu or Kali




# ---------------------------------------------
# grab Operative System distro to store IP addr
# output = Ubuntu OR Kali OR Parrot OR BackBox
# ---------------------------------------------
InT3R=`netstat -r | grep "default" | awk {'print $8'}` # grab interface in use
case $DiStR0 in
    Kali) IP=`ifconfig $InT3R | egrep -w "inet" | awk '{print $2}'`;;
    Debian) IP=`ifconfig $InT3R | egrep -w "inet" | awk '{print $2}'`;;
    Ubuntu) IP=`ifconfig $InT3R | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
    Parrot) IP=`ifconfig $InT3R | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
    BackBox) IP=`ifconfig $InT3R | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
    elementary) IP=`ifconfig $InT3R | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
    *) IP=`zenity --title="☠ Input your IP addr ☠" --text "example: 192.168.1.68" --entry --width 300`;;
  esac
clear

ping -c 3 www.google.com | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Storing current IP settings" --percentage=0 --auto-close --width 300 > /dev/null 2>&1








sh_stage1 () {
echo ""
echo "[☠] stage 1 running..."
sleep 2
}


sh_FAQ () {
echo ""
echo "[☠] stage 2 running..."
sleep 2
}

sh_exit () {
clear
exit
}


Colors;
# -----------------------------
# MAIN MENU SHELLCODE GENERATOR
# -----------------------------
# Loop forever
while :
do
clear
echo ${BlueF}
cat << !
               - Automated Ettercap TCP/IP Hijacking Tool -
    ███╗   ███╗ ██████╗ ██████╗ ██████╗ ██╗  ██╗███████╗██╗   ██╗███████╗
    ████╗ ████║██╔═══██╗██╔══██╗██╔══██╗██║  ██║██╔════╝██║   ██║██╔════╝
    ██╔████╔██║██║   ██║██████╔╝██████╔╝███████║█████╗  ██║   ██║███████╗
    ██║╚██╔╝██║██║   ██║██╔══██╗██╔═══╝ ██╔══██║██╔══╝  ██║   ██║╚════██║
    ██║ ╚═╝ ██║╚██████╔╝██║  ██║██║     ██║  ██║███████╗╚██████╔╝███████║
    ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝
    +--------+----------------------------------------------------------+
    | OPTION |         DESCRIPTION(filters)                             |
    +--------+----------------------------------------------------------+
    |   1    -  Drop all packets from source ip addr (packet drop)      |
    |   2    -  Redirect browser traffic to another ip addr (domain)    |
    |   3    -  Replace website images (img src=http://another.png)     |
    |   4    -  Replace website text   (replace: a,e,i by f,h,k)        |
    |   5    -  https downgrade attack (replace: https y http)          |
    |   6    -  ssh downgrade attack   (replace: SSH-1.99 by SSH-1.51)  |
    |   7    -  Rotate website document 180 degrees (CSS3 injection)    |
    |   8    -  Inject backdoor into html request (executable.exe)      |
    |   9    -  Write your own filter and use morpheus to inject it     |
    |                                                                   |
    |   F    -  FAQ (frequent ask questions)                            |
    |   E    -  exit/close Morpheus tool                                |
    +-------------------------------------------------------------------+
                                                       SSA-RedTeam@2016_|
!
echo ${Reset};
echo ${BlueF}[☠]${white} tcp/udp hijacking tool${RedF}! ${Reset};
sleep 1
echo ${BlueF}[➽]${white} Chose Your Option[filter]${RedF}: ${Reset};
read choice
case $choice in
1) sh_stage1 ;;
f) sh_FAQ ;;
F) sh_FAQ ;;
e) sh_exit ;;
E) sh_exit ;;
-h) sh_FAQ ;;
--help) sh_FAQ ;;
-help) sh_FAQ ;;
help) sh_FAQ ;;
*) echo "\"$choice\": is not a valid Option"; sleep 2 ;;
esac
done

