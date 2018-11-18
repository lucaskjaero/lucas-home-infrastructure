#
# Cookbook:: home_media_server
# Recipe:: sonarr
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

user "sonarr" do
  shell "/sbin/nologin"
  comment "Service user for sonarr"
  system true
  manage_home false
end

directory "/config/sonarr" do
  owner "sonarr"
  group "sonarr"
  mode "0777"
  action :create
  not_if { Dir.exist? "/config/sonarr" }
end

docker_image "Sonarr image" do
  repo "linuxserver/sonarr"
  action :pull
end

docker_container "Sonarr container" do
  container_name "sonarr"
  repo "linuxserver/sonarr"
  port "8989:8989"
  volumes ["/config/sonarr:/config", "/video:/tv", "/atlantis:/downloads:ro"]
  env ['TZ="America/Los_Angeles"']
  action :run
end
