#
# Cookbook:: home_media_server
# Recipe:: sonarr
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

docker_installation_package 'default'

docker_service_manager 'default' do
  action :start
end

user 'plex' do
  shell '/sbin/nologin'
  comment 'Service user for plex'
  system true
  manage_home false
end

directory '/config' do
  owner 'root'
  group 'root'
  mode '0777'
  action :create
  not_if { Dir.exist? '/config' }
end
directory '/config/plex' do
  owner 'plex'
  group 'plex'
  mode '0777'
  action :create
  not_if { Dir.exist? '/config/plex' }
end
directory '/transcode' do
  owner 'plex'
  group 'plex'
  mode '0777'
  action :create
  not_if { Dir.exist? '/transcode' }
end
directory '/media' do
  owner 'plex'
  group 'plex'
  mode '0777'
  action :create
  not_if { Dir.exist? '/media' }
end

docker_image "Plex image" do
  repo 'plexinc/pms-docker'
  tag 'plexpass'
  action :pull
end

docker_container 'Plex container' do
  container_name 'plex'
  repo 'plexinc/pms-docker'
  tag 'plexpass'
  network_mode 'host'
  volumes ['/config/plex:/config', '/transcode:/transcode', '/media:/data']
  env ['TZ="America/Los_Angeles"']
  action :run
end
