#
# Cookbook:: home_media_server
# Recipe:: mount_atlantis
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

include_recipe "fuse"

package "sshfs"

# Mount atlantis here
directory "/atlantis" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if { Dir.exist? "/atlantis" }
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

# Set up public key auth to connect to atlantis
directory "/config/atlantis" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end
directory "/config/atlantis/.ssh" do
  owner "root"
  group "root"
  mode "0700"
  action :create
end
cookbook_file "/config/atlantis/.ssh/id_rsa" do
  source "privatekey"
  owner "root"
  group "root"
  mode "0700"
end
cookbook_file "/config/atlantis/.ssh/id_rsa.pub" do
  source "publickey"
  owner "root"
  group "root"
  mode "0700"
end

# Add to fstab for automatic mounting, and then kick it off
append_if_no_line "Add to fstab" do
  path "/etc/fstab"
  line "sshfs#sanjid@atlantis.whatbox.ca:/home/sanjid/files /atlantis fuse IdentityFile=/config/atlantis/.ssh/id_rsa,allow_other,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3, 0 0"
end
bash "Mount atlantis" do
  user "root"
  code "mount /atlantis/"
  only_if { Dir.empty?("/atlantis/") }
end
