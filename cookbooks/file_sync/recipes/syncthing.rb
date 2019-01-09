#
# Cookbook:: file_sync
# Recipe:: syncthing
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe "docker_base"

user "syncthing" do
  shell "/sbin/nologin"
  uid 8384
  comment "Service user for syncthing"
  system true
  manage_home false
end

directory node["config_dir"] do
  owner "root"
  mode "0777"
  action :create
  not_if { Dir.exist? node["config_dir"] }
end
directory "#{node["config_dir"]}/syncthing" do
  owner node["sync"]["UID"]
  group "syncthing"
  mode "0777"
  action :create
  not_if { Dir.exist? "#{node["config_dir"]}/syncthing" }
end
directory "#{node["config_dir"]}/syncthing/#{node.name}" do
  owner node["sync"]["UID"]
  group "syncthing"
  mode "0777"
  action :create
  not_if { Dir.exist? "#{node["config_dir"]}/syncthing/#{node.name}" }
end

docker_image "Syncthing image" do
  repo "linuxserver/syncthing"
  action :pull
end

# Mount some default folders and then allow the user to add more
default_mounts = ["#{node["config_dir"]}/syncthing/#{node.name}:/config", "#{node["config_dir"]}:/mnt/config/"]
user_passed_folders = node["sync"]["sync_directories"]
syncthing_volumes = (default_mounts + user_passed_folders).uniq

docker_container "Syncthing runtime" do
  container_name "syncthing"
  repo "linuxserver/syncthing"
  env ['TZ="America/Los_Angeles"', "PUID=#{node["sync"]["UID"]}"]
  network_mode "host"
  volumes syncthing_volumes
  action :run
end
