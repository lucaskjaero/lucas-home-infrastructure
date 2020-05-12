#
# Cookbook:: openvpn_server
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

user "openvpn" do
  shell "/sbin/nologin"
  uid 9443
  comment "Service user for openvpn"
  system true
  manage_home false
end
group "openvpn" do
  append true
  gid 94433
end

directory "/config" do
  owner "root"
  group "root"
  mode "0777"
  action :create
end
directory "/config/openvpn" do
  owner "openvpn"
  group "openvpn"
  mode "0770"
  action :create
end

docker_image "OpenVPN image" do
  repo "linuxserver/openvpn-as"
  action :pull
end

docker_container 'OpenVPN container' do
  container_name 'openvpn'
  repo 'linuxserver/openvpn-as'
  port ['943:943', '9443:9443', '1194:1194/udp']
  volumes ['/config/openvpn:/config']
  env ['TZ="America/Los_Angeles"', "PUID=9443", "PGID=94433"]
  cap_add 'NET_ADMIN'
  restart_policy 'unless-stopped'
  action :run
end
