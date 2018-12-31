#
# Cookbook:: home_media_server
# Recipe:: radarr
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

radarr_config_dir = "#{node["home_media_server"]["config_dir"]}/radarr"
download_dir = node["home_media_server"]["download_dir"]
media_dir = node["home_media_server"]["media_dir"]

user "radarr" do
  shell "/sbin/nologin"
  uid 7878
  comment "Service user for radarr"
  system true
  manage_home false
end

directory radarr_config_dir do
  owner "radarr"
  group "media_server"
  mode "0775"
  action :create
  not_if { Dir.exist? radarr_config_dir }
end

docker_image "Radarr image" do
  repo "linuxserver/radarr"
  action :pull
end

docker_container "Radarr container" do
  container_name "radarr"
  repo "linuxserver/radarr"
  port "7878:7878"
  volumes ["#{radarr_config_dir}:/config", "#{media_dir}:/movies", "#{download_dir}:/downloads:ro"]
  env [node["home_media_server"]["timezone"], "PUID=7878", "PGID=8888"]
  restart_policy "unless-stopped"
  action :run
end
