#
# Cookbook:: lacabana
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

home_assistant_config_dir = "#{node["home_media_server"]["config_dir"]}/home_assistant"

directory home_assistant_config_dir do
  owner "lucas"
  group "media_server"
  mode "0775"
  action :create
  not_if { Dir.exist? home_assistant_config_dir }
end

directory node["home_media_server"]["config_dir"] do
  owner "root"
  mode "0777"
  action :create
  not_if { Dir.exist? node["home_media_server"]["config_dir"] }
end

docker_image "homeassistant image" do
  repo "homeassistant/home-assistant:stable"
  action :pull
end

docker_container "homeassistant container" do
  container_name "home-assistant"
  repo "homeassistant/home-assistant"
  tag "stable"
  volumes ["#{home_assistant_config_dir}:/config"]
  env ["TZ=America/Los_Angeles"]
  network_mode "host"
  restart_policy "unless-stopped"
  action :run
end
