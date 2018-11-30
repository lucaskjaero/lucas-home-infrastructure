#
# Cookbook:: home_media_server
# Recipe:: radarr
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

user "radarr" do
  shell "/sbin/nologin"
  uid 7878
  comment "Service user for radarr"
  system true
  manage_home false
end

directory "/config/radarr" do
  owner "radarr"
  group "media_server"
  mode "0775"
  action :create
  not_if { Dir.exist? "/config/radarr" }
end

docker_image "Radarr image" do
  repo "linuxserver/radarr"
  action :pull
end

docker_container "Radarr container" do
  container_name "radarr"
  repo "linuxserver/radarr"
  port "7878:7878"
  volumes ["/config/radarr:/config", "/video/movies:/movies", "/atlantis:/downloads:ro"]
  env ['TZ="America/Los_Angeles"', "PUID=7878", "PGID=8888"]
  action :run
end
