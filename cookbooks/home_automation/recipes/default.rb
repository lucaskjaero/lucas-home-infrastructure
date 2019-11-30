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

docker_image "homeassistant image" do
  repo "homeassistant/home-assistant"
  tag "stable"
  action :pull
end

docker_container "homeassistant" do
  container_name "home-assistant"
  repo "homeassistant/home-assistant"
  tag "stable"
  volumes ["#{home_assistant_config_dir}:/config"]
  env ["TZ=America/Los_Angeles"]
  network_mode "host"
  restart_policy "unless-stopped"
  action :run
end

git home_assistant_config_dir do
  repository 'git://github.com/lucaskjaero/lucas-home-automation.git'
  action :sync
  notifies :redeploy, 'docker_container[homeassistant]', :immediately
end
