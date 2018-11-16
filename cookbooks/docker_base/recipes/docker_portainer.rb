#
# Cookbook:: docker
# Recipe:: docker_portainer
#
# Copyright:: 2018, The Authors, All Rights Reserved.

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
