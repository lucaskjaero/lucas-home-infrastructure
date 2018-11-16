#
# Cookbook:: docker
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

docker_installation_package 'default'

docker_service_manager 'default' do
  action :start
end

include_recipe '::docker_portainer'
include_recipe '::docker_watchtower'
