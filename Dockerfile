FROM ubuntu:bionic
MAINTAINER Fmstrat <fmstrat@NOSPAM.NO>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y

#This allows us to use future version of samba, but they're currently broken
#RUN apt-get install -y wget gnupg
#RUN wget -O - http://apt.van-belle.nl/louis-van-belle.gpg-key.asc | apt-key add -
#RUN echo "deb http://apt.van-belle.nl/debian bionic-samba410 main contrib non-free" > /etc/apt/sources.list.d/van-belle.list

RUN apt-get update

# Install all apps
# The third line is for multi-site config (ping is for testing later)
RUN apt-get install -y pkg-config
RUN apt-get install -y attr acl samba smbclient ldap-utils winbind libnss-winbind libpam-winbind krb5-user krb5-kdc supervisor dnsutils joe
RUN apt-get install -y openvpn inetutils-ping

# Set up script and run
ADD init.sh /init.sh
RUN chmod 755 /init.sh
CMD /init.sh setup
