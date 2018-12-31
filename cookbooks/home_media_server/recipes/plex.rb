#
# Cookbook:: home_media_server
# Recipe:: plex_docker
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

plex_config_dir = "#{node["home_media_server"]["config_dir"]}/plex"
media_dir = node["home_media_server"]["media_dir"]

package "ubuntu-restricted-extras"
package "vlc"

user "plex" do
  shell "/sbin/nologin"
  comment "Service user for plex"
  system true
  manage_home false
end

directory plex_config_dir do
  owner "plex"
  group "plex"
  mode "0777"
  action :create
  not_if { Dir.exist? plex_config_dir }
end
directory "/transcode" do
  owner "plex"
  group "plex"
  mode "0777"
  action :create
  not_if { Dir.exist? "/transcode" }
end

docker_image "Plex image" do
  repo "plexinc/pms-docker"
  tag "plexpass"
  action :pull
end

docker_container "Plex container" do
  container_name "plex"
  repo "plexinc/pms-docker"
  tag "plexpass"
  network_mode "host"
  volumes ["#{plex_config_dir}:/config", "/transcode:/transcode", "#{media_dir}:/data"]
  env ['TZ="America/Los_Angeles"']
  restart_policy "unless-stopped"
  action :run
end
