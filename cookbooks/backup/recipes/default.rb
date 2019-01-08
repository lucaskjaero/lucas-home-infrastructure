#
# Cookbook:: backup
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe "docker_base"

user "duplicati" do
  shell "/sbin/nologin"
  uid 8200
  comment "Service user for duplicati"
  system true
  manage_home false
end

directory "/config" do
  owner "root"
  mode "0777"
  action :create
  not_if { Dir.exist? "/config" }
end
directory "/config/duplicati" do
  owner "duplicati"
  mode "0777"
  action :create
  not_if { Dir.exist? "/config/duplicati" }
end

docker_image "duplicati image" do
  repo "linuxserver/duplicati"
  action :pull
end

docker_container "Duplicati runtime" do
  container_name "duplicati"
  repo "linuxserver/duplicati"
  port "8200:8200"
  env ['TZ="America/Los_Angeles"', "PUID=8200"]
  volumes ["/config/duplicati:/config", "/files:/source"]
  action :run
end
