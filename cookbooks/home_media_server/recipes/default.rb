#
# Cookbook:: atlantis_ftp_connection
# Recipe:: default
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

user 'atlantis' do
  comment 'A random user'
  home '/home/atlantis'
  shell '/bin/bash'
  password 'atlantis'
end

# Mount Atlantis here
directory '/Atlantis' do
  owner 'atlantis'
  group 'atlantis'
  mode '0777'
  action :create
  not_if { Dir.exist? '/Atlantis' }
end

# Handle first time connection -- gotta accept the host name
directory '/root/.ssh' do
  owner 'root'
  group 'root'
  mode '0777'
  action :create
  not_if { Dir.exist? '/root/.ssh' }
end
cookbook_file '/root/.ssh/known_hosts' do
  source 'known_hosts'
  owner 'root'
  group 'root'
  mode '0755'
end

# Set up public key auth to connect to atlantis
directory '/home/atlantis/' do
  owner 'atlantis'
  group 'atlantis'
  mode '0755'
  action :create
end
directory '/home/atlantis/.ssh' do
  owner 'atlantis'
  group 'atlantis'
  mode '0755'
  action :create
end
cookbook_file '/home/atlantis/.ssh/id_rsa' do
  source 'privatekey'
  owner 'atlantis'
  group 'atlantis'
  mode '0755'
end
cookbook_file '/home/atlantis/.ssh/id_rsa.pub' do
  source 'publickey'
  owner 'atlantis'
  group 'atlantis'
  mode '0755'
end

# Add to fstab for automatic mounting, and then kick it off
append_if_no_line "Add to fstab" do
  path "/etc/fstab"
  line "sshfs#sanjid@atlantis.whatbox.ca:/home/sanjid/files /Atlantis fuse IdentityFile=/home/atlantis/.ssh/id_rsa,allow_other,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3, 0 0"
end
bash 'Mount atlantis' do
  user 'root'
  code 'mount  /Atlantis/'
  not_if '[ "$(ls -A /Atlantis)" ]'
end
