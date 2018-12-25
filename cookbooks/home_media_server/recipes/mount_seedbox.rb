#
# Cookbook:: home_media_server
# Recipe:: mount_seedbox
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

include_recipe "fuse"

package "sshfs"

# Mount seedbox here
directory "/seedbox" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if { Dir.exist? "/seedbox" }
end

# Handle first time connection -- gotta accept the host name
directory "/root/.ssh" do
  owner "root"
  group "root"
  mode "0700"
  action :create
  not_if { Dir.exist? "/root/.ssh" }
end
cookbook_file "/root/.ssh/known_hosts" do
  source "known_hosts"
  owner "root"
  group "root"
  mode "0700"
end

# Set up public key auth to connect to seedbox
directory "/config/seedbox" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end
directory "/config/seedbox/.ssh" do
  owner "root"
  group "root"
  mode "0700"
  action :create
end
cookbook_file "/config/seedbox/.ssh/id_rsa" do
  source "privatekey"
  owner "root"
  group "root"
  mode "0700"
end
cookbook_file "/config/seedbox/.ssh/id_rsa.pub" do
  source "publickey"
  owner "root"
  group "root"
  mode "0700"
end

# Add to fstab for automatic mounting, and then kick it off
append_if_no_line "Add to fstab" do
  path "/etc/fstab"
  line "sshfs#sanjid@seedbox.whatbox.ca:/home/sanjid/files /seedbox fuse IdentityFile=/config/seedbox/.ssh/id_rsa,allow_other,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3, 0 0"
end
bash "Mount seedbox" do
  user "root"
  code "mount /seedbox/"
  only_if { Dir.empty?("/seedbox/") }
end
