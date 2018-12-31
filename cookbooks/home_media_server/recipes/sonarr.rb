#
# Cookbook:: home_media_server
# Recipe:: sonarr
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

sonarr_config_dir = "#{node["home_media_server"]["config_dir"]}/sonarr"
download_dir = node["home_media_server"]["download_dir"]
media_dir = node["home_media_server"]["media_dir"]

user "sonarr" do
  shell "/sbin/nologin"
  uid 8989
  comment "Service user for sonarr"
  system true
  manage_home false
end

directory sonarr_config_dir do
  owner "sonarr"
  group "media_server"
  mode "0775"
  action :create
  not_if { Dir.exist? sonarr_config_dir }
end

docker_image "Sonarr image" do
  repo "linuxserver/sonarr"
  action :pull
end

docker_container "Sonarr container" do
  container_name "sonarr"
  repo "linuxserver/sonarr"
  port "8989:8989"
  volumes ["#{sonarr_config_dir}:/config", "#{media_dir}:/tv", "#{download_dir}:/downloads:ro"]
  env [node["home_media_server"]["timezone"], "PUID=8989", "PGID=8888"]
  restart_policy "unless-stopped"
  action :run
end
