#
# Cookbook:: logstash_host
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
docker_image "Elk image" do
  repo "sebp/elk"
  action :pull
end

docker_container "Elk container" do
  container_name "elk"
  repo "sebp/elk"
  port "5601:5601"
  port "9200:9200"
  port "5044:5044"
  restart_policy "unless-stopped"
  action :run
end
