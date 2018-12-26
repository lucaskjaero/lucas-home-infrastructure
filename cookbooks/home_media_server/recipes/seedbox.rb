#
# Cookbook:: home_media_server
# Recipe:: mount_seedbox
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

seedbox_config_dir = "#{node["home_media_server"]["config_dir"]}/seedbox"
seedbox_mount_point = node["home_media_server"]["download_dir"]

include_recipe "fuse"

package "sshfs"

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
directory seedbox_config_dir do
  owner "root"
  group "root"
  mode "0755"
  action :create
end
directory "#{seedbox_config_dir}/.ssh" do
  owner "root"
  group "root"
  mode "0700"
  action :create
end
cookbook_file "#{seedbox_config_dir}/.ssh/id_rsa" do
  source "privatekey"
  owner "root"
  group "root"
  mode "0700"
end
cookbook_file "#{seedbox_config_dir}/.ssh/id_rsa.pub" do
  source "publickey"
  owner "root"
  group "root"
  mode "0700"
end

username = node["home_media_server"]["seedbox"]["remote_username"]
host = node["home_media_server"]["seedbox"]["remote_host"]
path = node["home_media_server"]["seedbox"]["remote_path"]

# Add to fstab for automatic mounting, and then kick it off
append_if_no_line "Add to fstab" do
  path "/etc/fstab"
  line "sshfs##{username}@#{host}:#{path} #{seedbox_mount_point} fuse IdentityFile=#{seedbox_config_dir}/.ssh/id_rsa,allow_other,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3, 0 0"
end
bash "Mount seedbox" do
  user "root"
  code "mount #{seedbox_mount_point}"
  only_if { Dir.empty?(seedbox_mount_point) }
end
