#
# Cookbook:: home_media_server
# Recipe:: jackett
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

jackett_config_dir = "#{node["home_media_server"]["config_dir"]}/jackett"
jackett_download_dir = node["home_media_server"]["jackett"]["download_dir"]

user "jackett" do
  shell "/sbin/nologin"
  uid 9117
  comment "Service user for jackett"
  system true
  manage_home false
end

directory jackett_config_dir do
  owner "jackett"
  group "media_server"
  mode "0775"
  action :create
  not_if { Dir.exist? jackett_config_dir }
end

# Even if we don't need use this, we need to have it to avoid orphaned volumes
directory jackett_download_dir do
  owner "jackett"
  group "media_server"
  mode "0775"
  action :create
  not_if { Dir.exist? jackett_download_dir }
end

docker_image "Jackett image" do
  repo "linuxserver/jackett"
  action :pull
end

docker_container "Jackett container" do
  container_name "jackett"
  repo "linuxserver/jackett"
  port "9117:9117"
  volumes ["#{jackett_config_dir}:/config", "#{jackett_download_dir}:/downloads"]
  env [node["home_media_server"]["timezone"], "PUID=9117", "PGID=8888"]
  restart_policy "unless-stopped"
  action :run
end
