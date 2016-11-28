[![Version](https://img.shields.io/badge/MORPHEUS-1.4-brightgreen.svg?maxAge=259200)]()
[![Stage](https://img.shields.io/badge/Release-developing-red.svg)]()
[![Build](https://img.shields.io/badge/Supported_OS-linux-orange.svg)]()
[![Github All Releases](https://img.shields.io/github/downloads/atom/atom/total.svg)]()
[![AUR](https://img.shields.io/aur/license/yaourt.svg)]()

# Morpheus - automated ettercap TCP/IP Hijacking tool
![morpheus v1.2-Alpha](https://dl.dropboxusercontent.com/u/21426454/morpheus-banner.png)

    Version release : v1.4-Alpha
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
    2º - target requests webpage from network (wan)
    3º - attacker modifies webpage response (contents)
    4º - modified packet its forward back to target host

    "morpheus automates the above described steps in a easy-automated-user-friendly-interface"

# What can we acomplish by using filters?
    morpheus ships with a collection of etter filters writen be me to acomplish various tasks:
    replacing images in webpages, replace text in webpages, inject payloads using html <form> tag
    denial-of-service attack (drop,kill packets from source), https/ssh downgrade attacks, redirect
    target browser traffic to another ip address (domain) and also gives you the ability to build
    compile your filter from scratch and lunch it through morpheus framework.

> filters can be extended using browser languages like: javascript,css,flash,etc"...
![morpheus v1.2-Alpha](https://dl.dropboxusercontent.com/u/21426454/morpheus-css.png)

# Framework limitations
    1º - morpheus will fail if target system its protected againt arp poison atacks
    2º - downgrade attacks will fail if browser target as installed no-http addon's
    3º - target system sometimes needs to clear netcache to arp poison be effective
    4º - replacement string must have the same length as original string to replace
         "eg. replace("word_hello", "hello_word"); <-- the same number of leters"

> incorrect number of token (///) in TARGET !!
![morpheus v1.2-Alpha](https://dl.dropboxusercontent.com/u/21426454/morpheus-error1.png)

    morpheus by default will run ettercap using IPv6 (USE_IPV6=ACTIVE) like its previous
    configurated into 'settings' file, if you are reciving this error than edit settings
    file befor runing morpheus and set (USE_IPV6=DISABLED) to force ettercap to use IPV4

# Dependencies
    ettercap, nmap, zenity

# Credits
    alor&naga (ettercap framework)  | nmap framework (fyodor)
    filters: irongeek (replace img) | seannicholls (rotate 180º)
    Most of the filters in morpheus framework have been writen be me except the ones described
    above, but this project will contemplate new external (authors) addictions found in the
    fast network as the project continues to grow up (new releases), also new examples can
    be found editing ettercap's etter.filter.examples file that will help us write new ones.
[ettercap linux man pages](https://linux.die.net/man/8/ettercap)

<br />
# Framework help argument
![morpheus v1.2-Alpha](https://dl.dropboxusercontent.com/u/21426454/morpheus-description.png)

# Framework option [9] running
![morpheus v1.2-Alpha](https://dl.dropboxusercontent.com/u/21426454/morpheus-option9.png)

# Credentials capture
![morpheus v1.2-Alpha](https://dl.dropboxusercontent.com/u/21426454/morpheus-creds1.png)

![morpheus v1.2-Alpha](https://dl.dropboxusercontent.com/u/21426454/morpheus-creds2.png)

<br />
---


_EOF
