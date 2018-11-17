#
# Cookbook:: docker
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Needed to connect to docker repository since it is TLS
package 'apt-transport-https' do
  action :install
  ignore_failure true
end

docker_installation_package 'default'

docker_service_manager 'default' do
  action :start
end

include_recipe '::docker_portainer'
include_recipe '::docker_watchtower'
