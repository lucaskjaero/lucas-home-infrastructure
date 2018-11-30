#
# Cookbook:: home_media_server
# Recipe:: jackett
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

user "jackett" do
  shell "/sbin/nologin"
  uid 9117
  comment "Service user for jackett"
  system true
  manage_home false
end

directory "/config/jackett" do
  owner "jackett"
  group "media_server"
  mode "0775"
  action :create
  not_if { Dir.exist? "/config/jackett" }
end

docker_image "Jackett image" do
  repo "linuxserver/jackett"
  action :pull
end

docker_container "Jackett container" do
  container_name "jackett"
  repo "linuxserver/jackett"
  port "9117:9117"
  volumes ["/config/jackett:/config"]
  env ['TZ="America/Los_Angeles"', "PUID=9117", "PGID=8888"]
  action :run
end
