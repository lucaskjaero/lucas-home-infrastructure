#
# Cookbook:: linux_base
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Set up ssh server
include_recipe "::setup_ssh"

# Block repeat password attempts
include_recipe "::fail2ban"

apt_update "daily apt update" do
  frequency 86400
  action :periodic
end

# System monitoring
package "netdata" do
  action :install
  ignore_failure true
end

# ifconfig, probably others
package "net-tools"

# Access file shares from other servers
include_recipe "samba::client"

# Allow remote desktop viewing of this machine
include_recipe "::setup_vnc"
