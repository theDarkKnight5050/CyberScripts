#!/bin/bash

run() {
	starter
	apt
	auditing
	cron
	hacking_tools
	firewall
	sysCtl
	users
	media
}

starter() {
	echo "Welcome to the Ultimate Script \n"

	echo "Configuring aliases..."
	unalias -a
	alias ll='ls -lh'
	alias ls='ls --color=auto'
	alias vi='vim '
	alias c='clear'
	alias d='/usr/local/bin/chkdomain $@'
}

apt() {
	echo "Updating..."
	cp "/etc/apt/sources.bak" "/etc/apt/sourceslist"
	apt-get update && apt-get upgrade
}

auditing() {
	apt-get install auditd
	auditctl -e 1
}

cron() {
	crontab -r
	rm -f cron.deny at.deny
	echo root > cron.allow
	echo root > at.allow
	
	echo "exit 0" > /etc/rc.local
}

hacking_tools() {
	echo "Basically removing everything in kali linux..."
	apt-get autoremove --purge -y
		airbase-ng acccheck ace-voip amap apache-users arachni android-sdk apktool arduino armitage asleap automater
		backdoor-factory bbqsql bed beef bing-ip2hosts binwalk blindelephant bluelog bluemaho bluepot blueranger bluesnarfer bulk-extractor	bully burpsuite braa
		capstone casefile cdpsnarf cewl chntpw cisco-auditing-tool cisco-global-exploiter cisco-ocs cisco-torch cisco-router-config cmospwd cookie-cadger commix cowpatty crackle creddump crunch cryptcat cymothoa copy-router-config cuckoo cutycapt
		davtest dbd dbpwaudit dc3dd ddrescue deblaze dex2jar dff dhcpig dictstat dirb dirbuster distorm3 dmitry dnmap dns2tcp dnschef dnsenum dnsmap dnsrecon dnstracer dnswalk doona dos2unix dotdotpwn dradis dumpzilla
		eapmd5pass edb-debugger enum4linux enumiax exploitdb extundelete
		fern-wifi-cracker fierce fiked fimap findmyhash firewalk fragroute foremost funkload
		galleta ghost-fisher giskismet grabber go-lismero goofile gpp-decrypt gsad gsd gqrx guymager gr-scan
		hamster-sidejack hash-identifier hexinject hexorbase http-tunnel httptunnel hping3 hydra
		iaxflood inguma intrace inundator inviteflood ipv6-toolkit iphone-backup-analyzer intersect ismtp isr-evilgrade
		jad javasnoop jboss-autopwn jd-gui john johnny joomscan jsql
		kalibrate-rtl keepnote killerbee kismet keimpx
		linux-exploit-suggester ldb lynis
		maltego-teeth magictree masscan maskgen maskprocessor mdk3 metagoofil metasploit mfcuk mfoc mfterm miranda mitmproxy multiforcer multimon-ng
		ncrack netcat nishang nipper-ng nmap ntop
		oclgausscrack ohwurm ollydpg openvas-administrator openvas-cli openvas-manager openvas-scanner oscanner
		p0f padbuster paros parsero patator pdf-parser pdfid pdgmail peepdf phrasendrescher pipal pixiewps plecost polenum policygen powerfuzzer powersploit protos-sip proxystrike pwnat
		rcrack rcrack-mt reaver rebind recon-ng redfang regripper responder ridenum rsmangler rtlsdr-scanner rtpbreak rtpflood rtpinsertsound rtpmixsound
		sakis3g sbd sctpscan setoolkit sfuzz shellnoob sidguesser siparmyknife sipp sipvicious skipfish slowhttptest smali smtp-user-enum sniffjoke snmpcheck spooftootph sslcaudit sslsplit sslstrip sslyze sqldict sqlmap sqlninja sqlsus statprocessor
		t50 termineter thc-hydra thc-ipv6 thc-pptp-bruter thc-ssl-dos tnscmd10g truecrack theharverster tlssled twofi
		u3-pwn uatester urlcrazy uniscan unix-privesc-check
		vega  valgrind volatility voiphopper
		w3af webscarab webshag webshells webslayer websploit weevely wfuzz wifi-honey wifitap wifite wireshark winexe wpscan wordlists wol-e
		xspy xplico xsser
		yara yersinia
		zaproxy
}

firewall() {
	apt-get autoremove --purge -y ufw
	apt-get install ufw
	ufw enable

	read -p "Is ssh a required service: " ssh
	echo $ssh
	apt-get autoremove --purge -y ssh
	if [ $ssh="y" ]; then
		apt-get install ssh
		cp "lib/sshd_config" "/etc/ssh/sshd_config"
		ufw allow 22
	else
		ufw deny 22
	fi

	read -p "Is ftp a required service: " ftp
	apt-get autoremove --purge -y ftp
	if [ $ftp="y" ]; then
		apt-get install ftp
		cp "lib/vsftpd.conf" "/etc/vsftpd/vsftpd.conf"
		ufw allow 21
	else
		ufw deny 21
	fi
}

sysCtl() {
	cp "lib/klaver" "/etc/sysctl.conf"
	sysctl -p
}

users() {
	echo "Setting password policy..."
	apt-get autoremove --purge -y libpam-cracklib
	apt-get install libpam-cracklib
	cp "lib/common-password" "/etc/pam.d/common-password"
	cp "lib/common-auth" "/etc/pam.d/common-auth"
	echo "allow-guest = false" >> /etc/lightdm/lightdm.conf

#	read -p "Add user: " newUser
#	while [ "$newUser"!="n" ] do;
#		useradd $newUser
#	done

	echo "Setting secure passwords..."
	users = "lib/userList.txt"
	cat users | while read $line
	do
		useradd $line
		echo 'Cyb3rP@triot!' | passwd --stdin $line
		echo "Password set for $line"
	done < "$users"
}

media() {
	echo "Finding possible media files..."

	touch mediaFiles.txt
	echo "Possible Media Files" >> lib/mediaFiles.txt
	find /home | grep "*.mp3" >> lib/mediaFiles.txt
	find /home | grep "*.jpeg" >> lib/mediaFiles.txt
	find /home | grep "*.png" >> lib/mediaFiles.txt
	find /home | grep "*.gif" >> lib/mediaFiles.txt
	find /home | grep "*.txt" >> lib/mediaFiles.txt
}

run
