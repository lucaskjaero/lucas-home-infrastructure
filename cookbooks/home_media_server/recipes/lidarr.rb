#
# Cookbook:: home_media_server
# Recipe:: lidarr
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

lidarr_config_dir = "#{node["home_media_server"]["config_dir"]}/lidarr"
download_dir = node["home_media_server"]["download_dir"]
media_dir = node["home_media_server"]["media_dir"]

user "lidarr" do
  shell "/sbin/nologin"
  uid 8686
  comment "Service user for lidarr"
  system true
  manage_home false
end

directory lidarr_config_dir do
  owner "lidarr"
  group "media_server"
  mode "0775"
  action :create
  not_if { Dir.exist? lidarr_config_dir }
end

docker_image "Lidarr image" do
  repo "linuxserver/lidarr"
  action :pull
end

docker_container "Lidarr container" do
  container_name "lidarr"
  repo "linuxserver/lidarr"
  port "8686:8686"
  volumes ["#{lidarr_config_dir}:/config", "#{media_dir}:/music", "#{download_dir}:/downloads:ro"]
  env [node["home_media_server"]["timezone"], "PUID=8686", "PGID=8888"]
  restart_policy "unless-stopped"
  action :run
end
