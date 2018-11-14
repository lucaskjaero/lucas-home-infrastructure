#
# Cookbook:: default
# Recipe:: plex_docker
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

docker_installation_package 'default'

docker_service_manager 'default' do
  action :start
end

directory '/config' do
  owner 'root'
  mode '0777'
  action :create
  not_if { Dir.exist? '/config' }
end
directory '/video' do
  owner 'root'
  group 'root'
  mode '0777'
  action :create
  not_if { Dir.exist? '/video' }
end

include_recipe '::mount_atlantis'
include_recipe '::plex_docker'
include_recipe '::sonarr'
