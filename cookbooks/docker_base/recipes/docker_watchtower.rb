#
# Cookbook:: docker
# Recipe:: docker_watchtower
#
# Copyright:: 2018, The Authors, All Rights Reserved.

docker_image "Watchtower image" do
  repo "v2tec/watchtower"
  action :pull
end

docker_container "Watchtower runtime" do
  container_name "watchtower"
  repo "v2tec/watchtower"
  volumes ["/var/run/docker.sock:/var/run/docker.sock"]
  action :run
end
