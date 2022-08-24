#!/bin/bash

# Create temporary firewall config file
echo "    <rule>
      <type>pass</type>
      <interface>wan</interface>
      <ipprotocol>inet</ipprotocol>
      <statetype>keep state</statetype>
      <descr>Allow HTTPS from WAN</descr>
      <direction>in</direction>
      <quick>1</quick>
      <protocol>tcp</protocol>
      <source>
        <any>1</any>
      </source>
      <destination>
        <network>(self)</network>
        <port>443</port>
      </destination>
    </rule>
    <rule>
      <type>pass</type>
      <interface>wan</interface>
      <ipprotocol>inet</ipprotocol>
      <statetype>keep state</statetype>
      <descr>Allow SSH from WAN</descr>
      <direction>in</direction>
      <quick>1</quick>
      <protocol>tcp</protocol>
      <source>
        <any>1</any>
      </source>
      <destination>
        <network>(self)</network>
        <port>22</port>
      </destination>
    </rule>" >> /tmp/fw_rules.txt

# Create temporary SSH config file
echo "      <enabled>enabled</enabled>
      <passwordauth>1</passwordauth>
      <permitrootlogin>1</permitrootlogin>" >> /tmp/ssh_config.txt

# Apply the configs
sed -i.bak -e "/<filter>/r /tmp/fw_rules.txt" /conf/config.xml
sed -i.bak -e "/<ssh>/r /tmp/ssh_config.txt" /conf/config.xml
sed -i.bak '/<blockpriv>1<\/blockpriv>/d' /conf/config.xml
sed -i.bak '/<blockbogons>1<\/blockbogons>/d' /conf/config.xml

# Remove temporary config files
rm /tmp/fw_rules.txt /tmp/ssh_config.txt

# Reload the OPNsense config
opnsense-shell reload