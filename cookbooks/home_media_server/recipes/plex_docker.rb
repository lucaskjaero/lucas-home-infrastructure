#
# Cookbook:: home_media_server
# Recipe:: sonarr
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

docker_installation_package 'default'

docker_service_manager 'default' do
  action :start
end

docker_image "Plex image" do
  repo 'plexinc/pms-docker'
  action :pull
end
