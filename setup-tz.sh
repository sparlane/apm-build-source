DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
ln -fs /usr/share/zoneinfo/UTC /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
