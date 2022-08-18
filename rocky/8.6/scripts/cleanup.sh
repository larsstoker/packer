#!/bin/bash -eux

# Uninstall Ansible as it's only used for inital setup
python -m pip uninstall -y ansible

# Remove logs
logrotate -f /etc/logrotate.conf 
rm -f /var/log/*-???????? /var/log/*.gz 
rm -f /var/log/dmesg.old 
rm -rf /var/log/anaconda 
rm -rf /var/cache/yum
cat /dev/null > /var/log/audit/audit.log 
cat /dev/null > /var/log/wtmp 
cat /dev/null > /var/log/lastlog 
cat /dev/null > /var/log/grubby

# Additional cleaning
rm -f /root/anaconda-ks.cfg
rm -rf /tmp/*

# Clean yum/dnf
dnf clean all
yum clean all

# Remove bash history
cat /dev/null > ~/.bash_history && history -c

# Zero out the rest of the free space using dd, then delete the written file.
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync