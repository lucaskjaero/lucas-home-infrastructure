#
# Cookbook:: grocy
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
grocy_config_dir = "#{node["home_media_server"]["config_dir"]}/grocy"

user "grocy" do
  shell "/sbin/nologin"
  comment "Service user for grocy"
  system true
  manage_home false
end

directory grocy_config_dir do
  owner "grocy"
  group "grocy"
  mode "0777"
  action :create
  not_if { Dir.exist? grocy_config_dir }
end

docker_image "Grocy image" do
  repo "linuxserver/grocy"
  action :pull
end

docker_container "Grocy container" do
  container_name "grocy"
  repo "linuxserver/grocy"
  port "9283:9283"
  volumes ["#{grocy_config_dir}:/config"]
  env ['TZ="America/Los_Angeles"']
  restart_policy "unless-stopped"
  action :run
end
