#
# Cookbook:: default
# Recipe:: plex_docker
#
# Copyright:: 2018, Lucas Kjaero, All Rights Reserved.

pihole_config_dir = "#{node["home_media_server"]["config_dir"]}/pihole"

directory node["config_dir"] do
  owner "root"
  mode "0777"
  action :create
  not_if { Dir.exist? node["config_dir"] }
end

user "pihole" do
  shell "/sbin/nologin"
  comment "Service user for pihole"
  system true
  manage_home false
end
directory pihole_config_dir do
  owner "pihole"
  group "pihole"
  mode "0777"
  action :create
  not_if { Dir.exist? pihole_config_dir }
end
directory "#{pihole_config_dir}/etc-pihole" do
  owner "pihole"
  group "pihole"
  mode "0777"
  action :create
  not_if { Dir.exist? "#{pihole_config_dir}/etc-pihole" }
end
directory "#{pihole_config_dir}/etc-dnsmasq.d" do
  owner "pihole"
  group "pihole"
  mode "0777"
  action :create
  not_if { Dir.exist? "#{pihole_config_dir}/etc-dnsmasq.d" }
end

docker_image "pihole image" do
  repo "pihole/pihole"
  tag "latest"
  action :pull
end

docker_container "Pihole container" do
  container_name "pihole"
  repo "pihole/pihole"
  tag "latest"
  volumes ["#{pihole_config_dir}/etc-pihole:/etc/pihole/", "#{pihole_config_dir}/etc-dnsmasq.d:/etc/dnsmasq.d/"]
  env ['TZ="America/Los_Angeles"', 'WEBPASSWORD="PIHOLE#1"']
  network_mode "host"
  dns ['127.0.0.1', '1.1.1.1']
  cap_add 'NET_ADMIN'
  restart_policy "unless-stopped"
  action :run
end
