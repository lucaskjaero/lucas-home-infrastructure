#
# Cookbook:: home_media_server
# Recipe:: jackett
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

bazarr_config_dir = "#{node["home_media_server"]["config_dir"]}/bazarr"
media_dir = node["home_media_server"]["media_dir"]

user "bazarr" do
  shell "/sbin/nologin"
  uid 6767
  comment "Service user for bazarr"
  system true
  manage_home false
end

directory bazarr_config_dir do
  owner "bazarr"
  group "media_server"
  mode "0775"
  action :create
  not_if { Dir.exist? bazarr_config_dir }
end

docker_image "Bazarr image" do
  repo "linuxserver/bazarr"
  action :pull
end

docker_container "Bazarr container" do
  container_name "bazarr"
  repo "linuxserver/bazarr"
  port "6767:6767"
  volumes ["#{bazarr_config_dir}:/config", "#{media_dir}:/movies", "#{media_dir}:/tv"]
  env [node["home_media_server"]["timezone"], "PUID=6767", "PGID=8888"]
  restart_policy "unless-stopped"
  action :run
end
