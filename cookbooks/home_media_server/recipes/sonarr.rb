#
# Cookbook:: home_media_server
# Recipe:: sonarr
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

docker_installation_package 'default'

docker_service_manager 'default' do
  action :start
end

user 'sonarr' do
  shell '/sbin/nologin'
  comment 'Service user for sonarr'
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
directory '/config/sonarr' do
  owner 'sonarr'
  group 'sonarr'
  mode '0777'
  action :create
  not_if { Dir.exist? '/config/sonarr' }
end
directory '/transcode' do
  owner 'sonarr'
  group 'sonarr'
  mode '0777'
  action :create
  not_if { Dir.exist? '/transcode' }
end
directory '/video' do
  owner 'sonarr'
  group 'sonarr'
  mode '0777'
  action :create
  not_if { Dir.exist? '/video' }
end

docker_image "Sonarr image" do
  repo 'linuxserver/sonarr'
  action :pull
end

docker_container 'Sonarr container' do
  container_name 'sonarr'
  repo 'linuxserver/sonarr'
  port '8989:8989'
  volumes ['/config/sonarr:/config', '/video:/tv', '/atlantis:/downloads:ro']
  env ['TZ="America/Los_Angeles"']
  action :run
end
