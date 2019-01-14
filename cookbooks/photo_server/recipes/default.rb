#
# Cookbook:: default
# Recipe:: plex_docker
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

user "lychee" do
  shell "/sbin/nologin"
  uid 10101
  comment "Service user for lychee"
  system true
  manage_home false
end

group "photo_server" do
  append true
  gid 10101
end

directory "#{node["config_dir"]}/lychee" do
  owner "lychee"
  group "photo_server"
  mode "0777"
  action :create
  not_if { Dir.exist? "#{node["config_dir"]}/lychee" }
end

directory node["photo_server"]["photo_library_location"] do
  owner "lychee"
  group "photo_server"
  mode "0777"
  action :create
  not_if { Dir.exist? node["photo_server"]["photo_library_location"] }
end

docker_image "Lychee image" do
  repo "linuxserver/lychee"
  action :pull
end

docker_container "Lychee container" do
  container_name "lychee"
  repo "linuxserver/lychee"
  port "10101:10101"
  volumes ["#{node["config_dir"]}/lychee:/config", "#{node["photo_server"]["photo_library_location"]}:/pictures"]
  env ["PUID=10101", "PGID=10101"]
  restart_policy "unless-stopped"
  action :run
end
