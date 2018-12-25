#
# Cookbook:: home_media_server
# Recipe:: lidarr
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

user "lidarr" do
  shell "/sbin/nologin"
  uid 8686
  comment "Service user for lidarr"
  system true
  manage_home false
end

directory "/config/lidarr" do
  owner "lidarr"
  group "media_server"
  mode "0775"
  action :create
  not_if { Dir.exist? "/config/lidarr" }
end

docker_image "Lidarr image" do
  repo "linuxserver/lidarr"
  action :pull
end

docker_container "Lidarr container" do
  container_name "lidarr"
  repo "linuxserver/lidarr"
  port "8686:8686"
  volumes ["/config/lidarr:/config", "/video:/music", "/seedbox:/downloads:ro"]
  env ['TZ="America/Los_Angeles"', "PUID=8686", "PGID=8888"]
  action :run
end
