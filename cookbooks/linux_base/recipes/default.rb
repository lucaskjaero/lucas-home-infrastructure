#
# Cookbook:: linux_base
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Set up ssh server
include_recipe '::setup_ssh'

apt_update 'daily apt update' do
  frequency 86400
  action :periodic
end

# System monitoring
package 'netdata'
