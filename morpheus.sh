#!/bin/sh


# Resize terminal windows size befor running the tool (gnome terminal)
# Special thanks to h4x0r Milton@Barra for this little piece of heaven! :D
resize -s 38 89 > /dev/null
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




# pass arguments to script [ -h | -v | -m ]
# we can use: ./morpheus.sh -h for help menu
# we can use: ./morpheus.sh -v to list mac vendors
while getopts ":h,:v" opt; do
  case $opt in
    h)
cat << !
---
-- Author: r00t-3xp10it | SSA RedTeam @2016
-- Supported: Linux Kali1, Kali2, Kali3
---

  When using NetworkManager (NM9) to access the net, any spoofed mac address (MAC)
  produced thru the terminal window (TW) using macchanger tool will be over-writen by
  NM9. If no cloned mac address exists in NM menu settings, then the device is returned
  to the device MAC (permanent) and any mac spoofing set by user thru the TW disappears.

  [ script arguments available ]
  sudo ./spoof-mac.sh for execution
  sudo ./spoof-mac.sh -h for help menu
  sudo ./spoof-mac.sh -v to list mac vendors
  sudo ./spoof-mac.sh -m show current mac and ip address

  "The follow script its my attempt to build the macchanger funtion thru TW"
!
   exit
    ;;
    v)
cat << !
---
-- Author: r00t-3xp10it | SSA RedTeam @2016
---


!
   exit
    ;;
    \?)
      echo ${RedF}[x]${white} Invalid option:${RedF} -$OPTARG ${Reset}; >&2
      exit
    ;;
  esac
done




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
sleep 1
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
   +--------+--------------------------------------------------------+
   | OPTION |         DESCRIPTION                                    |
   +--------+--------------------------------------------------------+
   |   1    -  Drop all packets from source ip addr (packet drop)    |
   |   2    -  Redirect browser traffic to another ip addr(domain)   |
   |   3    -  Replace website images (img src=http://another.png)   |
   |   4    -  Replace website text   (replace: a,e,i by f,h,k)      |
   |   5    -  https downgrade attack (replace: https y http)        |
   |   6    -  ssh downgrade attack   (replace: SSH-1.99 by SSH-1.51)|
   |   7    -  Inject backdoor into html request (executable.exe)    |
   |   8    -  Write your own filter and use morpheus to inject it   |
   |                                                                 |
   |   F    -  FAQ (frequent ask questions)                          |
   |   E    -  exit Morpheus tool                                    |
   +-----------------------------------------------------------------+
                                                    SSA-RedTeam@2016_|

!
echo ${Reset};
echo "[☠] tcp/udp hijacking tool!"
sleep 1
echo -n "[➽] Chose Your Option:"
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

