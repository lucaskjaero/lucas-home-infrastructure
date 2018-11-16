#
# Cookbook:: linux_base
# Recipe:: docker
#
# Copyright:: 2018, The Authors, All Rights Reserved.

docker_installation_package 'default'

docker_service_manager 'default' do
  action :start
end

docker_image "Portainer image" do
  repo 'portainer/portainer'
  action :pull
end

docker_volume 'portainer_data' do
  action :create
end

docker_container 'Portainer runtime' do
  container_name 'portainer'
  repo 'portainer/portainer'
  port '9000:9000'
  volumes ['/var/run/docker.sock:/var/run/docker.sock', 'portainer_data:/data']
  action :run
end
