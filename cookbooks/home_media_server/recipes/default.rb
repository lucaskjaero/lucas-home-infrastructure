#
# Cookbook:: default
# Recipe:: plex_docker
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

group "media_server" do
  append true
  gid 8888
end

directory node["home_media_server"]["config_dir"] do
  owner "root"
  mode "0777"
  action :create
  not_if { Dir.exist? node["home_media_server"]["config_dir"] }
end

directory node["home_media_server"]["download_dir"] do
  owner "root"
  mode "0777"
  action :create
  not_if { Dir.exist? node["home_media_server"]["download_dir"] }
end

directory node["home_media_server"]["media_dir"] do
  owner "root"
  group "root"
  mode "0777"
  action :create
  not_if { Dir.exist? node["home_media_server"]["media_dir"] }
end

include_recipe "::plex"

bazarr = node["home_media_server"]["bazarr"]["enabled"]
include_recipe "::bazarr" if bazarr

jackett = node["home_media_server"]["jackett"]["enabled"]
include_recipe "::jackett" if jackett

lidarr = node["home_media_server"]["lidarr"]["enabled"]
include_recipe "::lidarr" if lidarr

radarr = node["home_media_server"]["radarr"]["enabled"]
include_recipe "::radarr" if radarr

seedbox = node["home_media_server"]["seedbox"]["enabled"]
include_recipe "::seedbox" if seedbox

sonarr = node["home_media_server"]["sonarr"]["enabled"]
include_recipe "::sonarr" if sonarr
