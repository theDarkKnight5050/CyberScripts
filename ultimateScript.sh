#!/bin/bash

run() {
	starter
	auditing
	configs
	cron
	hacking_tools
	media
	services
	users
	misc
}

starter() {
	echo "Welcome to the Ultimate Script"

	echo "Configuring aliases..."
	#Just in case they set any trick aliases
	unalias -a
	alias ll='ls -lh'
	alias ls='ls --color=auto'
	alias vi='vim '
	alias c='clear'
	alias d='/usr/local/bin/chkdomain $@'
}

auditing() {
	#Download package for auditing
	echo "Installing auditing tools..."
	apt-get install -y auditd
	auditctl -e 1
}

configs() {
	#Set a secure sources file for apt using the backup
	echo "Securing apt source"
	sed -i 's/APT::Periodic::Update-Package-Lists "0";/APT::Periodic::Update-Package-Lists "1";/g' /etc/apt/apt.conf.d/10periodic
	sed -i 's/APT::Periodic::Download-Upgradeable-Packages "0";/APT::Periodic::Download-Upgradeable-Packages "1";/g' /etc/apt/apt.conf.d/10periodic
	sed -i 's/APT::Periodic::AutocleanInterval "0";/APT::Periodic::AutocleanInterval "7";/g' /etc/apt/apt.conf.d/10periodic
	sed -i 's/APT::Periodic::Unattended-Upgrade "0";/APT::Periodic::Unattended-Upgrade "1";/g' /etc/apt/apt.conf.d/10periodic
	rm -f /etc/apt/sources.list
	touch /etc/apt/sources.list
	echo -e "deb http://us.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
	echo -e "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
	echo -e "deb http://security.ubuntu.com/ubuntu/ trusty-security universe main restricted multiverse" >> /etc/apt/sources.list
	echo -e "deb http://us.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
	echo -e "deb http://us.archive.ubuntu.com/ubuntu/ trusty-proposed universe main restricted multiverse" >> /etc/apt/sources.list
	echo -e "deb http://extras.ubuntu.com/ubuntu trusty main" >> /etc/apt/sources.list
	echo -e "deb http://archive.canonical.com/ubuntu trusty partner" >> /etc/apt/sources.list
	echo -e "deb-src http://archive.canonical.com/ubuntu trusty partner" >> /etc/apt/sources.list
	rm -rf /etc/apt/sources.list.d/*

	#Configures sysctl according to klaver
	echo "Configuring systctl"
	cp "lib/klaver" "/etc/sysctl.conf"
	sysctl -p

	#Fix sudo configurations
	echo "Securing sudo configurations"
	cp "lib/sudoers" "/etc/sudoers"
	rm -rf /etc/sudoers.d
	mkdir /etc/sudoers.d
	passwd -l root

	#Disallows guest User
	echo "Configuring lightdm"
	echo -e 'allow-guest=false'>> /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
	echo -e 'greeter-hide-users=true' >> /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
	echo -e 'greeter-show-manual-login=true' >> /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
	sed -i '/autologin-user/d' /etc/lightdm/lightdm.conf
	sed -i '/autologin-user/d' /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
}

cron() {
	#Only allow root access to crontabs
	echo "Doing some stuff to cron and rc.local..."
	crontab -r
	rm -f cron.deny at.deny
	echo root > cron.allow
	echo root > at.allow

	#There shouldn't be anything in rc.local
	echo "exit 0" > /etc/rc.local
}

hacking_tools() {
	#All dem packages doe...
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

media() {
	echo "Finding possible media files..."

	touch mediaFiles.txt
	echo "Possible Media Files" >> ans/mediaFiles.txt
	find /home | grep "*.mp3" >> ans/mediaFiles.txt
	find /home | grep "*.jpeg" >> ans/mediaFiles.txt
	find /home | grep "*.png" >> ans/mediaFiles.txt
	find /home | grep "*.gif" >> ans/mediaFiles.txt
	find /home | grep "*.txt" >> ans/mediaFiles.txt
}

services() {
	#Installs clean version of ufw then enables
	echo "Enabling firewall"
	apt-get autoremove --purge -y ufw
	apt-get install ufw
	ufw enable

	#Configures ssh
	read -p "Is ssh a required service: " ssh
	apt-get autoremove --purge -y ssh
	if [ $ssh="y" ]; then
		apt-get install ssh
		cp "lib/sshd_config" "/etc/ssh/sshd_config"
		cp "lib/ssh_config" "/etc/ssh/ssh_config"
		ufw allow 22
		service restart ssh
	else
		ufw deny 22
	fi

	#Configures ftp
	read -p "Is ftp a required service: " ftp
	if [ $ftp="y" ]; then
		cp "lib/vsftpd.conf" "/etc/vsftpd.conf"
		ufw allow 21
		service restart vsftpd
	else
		apt-get autoremove --purge -y vsftpd
		ufw deny 21
	fi
	service restart ftp

	read -p "Is apache a required service: " apache
	apt-get autoremove --purge -y apache2
	if[ $apache="y" ]; then
		apt-get install apparmor
}

users() {
	#Installs clean libpam with secure configs
	echo "Setting password policy..."
	apt-get autoremove --purge -y libpam-cracklib
	apt-get install libpam-cracklib
	cp "lib/common-password" "/etc/pam.d/common-password"
	cp "lib/common-auth" "/etc/pam.d/common-auth"
	echo "allow-guest = false" >> /etc/lightdm/lightdm.conf

#	read -p "Add user: " newUser
#	while [ "$newUser" != "n" ]; do
#		useradd $newUser
#		read -p "Add user: " newUser
#	done

	#Copy all users from userList.txt DO NOT INCLUDE YOURSELF
	echo "Setting secure passwords..."
	users="lib/userList.txt"
	while IFS= read user; do
		echo "$user"
		useradd $user
		echo -e 'Cyb3rP@triot!' | passwd $user
		echo "Password set for $line"
	done < "$users"

	#Checks for possible hidden users and sends data to ans
	echo "Checking for UID 0..."
	awk -F: '($3 == "0") {print}' /etc/passwd >> ans/rootUser.txt
}

misc() {
	rm /etc/init/control-alt-delete.conf
	echo > /etc/securetty

	echo "Fixing permissions..."
	chown root:root /etc/anacrontab
	chmod og-rwx /etc/anacrontab
	chown root:root /etc/crontab
	chmod og-rwx /etc/crontab
	chown root:root /etc/cron.hourly
	chmod og-rwx /etc/cron.hourly
	chown root:root /etc/cron.daily
	chmod og-rwx /etc/cron.daily
	chown root:root /etc/cron.weekly
	chmod og-rwx /etc/cron.weekly
	chown root:root /etc/cron.monthly
	chmod og-rwx /etc/cron.monthly
	chown root:root /etc/cron.d
	chmod og-rwx /etc/cron.d
	chown root:root /var/spool/cron/crontabs
	chmod og-rwx /var/spool/cron/crontabs
	chmod 644 /etc/passwd
	chown root:root /etc/passwd
	chmod 644 /etc/group
	chown root:root /etc/group
	chmod 600 /etc/shadow
	chown root:root /etc/shadow
	chmod 600 /etc/gshadow
	chown root:root /etc/gshadow
	chown root:root /etc/fstab
}

run
apt-get update && apt-get upgrade

echo "All done couple reminders: "
echo "1) Forensics questions (honestly if you forgot this i dont think i can help you)"
echo "2) nmap and ps aux"
echo "PS Christo dw i got john"
