#
# Cookbook:: pihole
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'docker_base'

docker_image "Pihole image" do
  repo 'pihole/pihole'
  action :pull
end

docker_container 'Pihole runtime' do
  container_name 'pihole'
  repo 'pihole/pihole'
  port ['53:53/tcp', '53:53/udp', '67:67/udp', '80:80', '443:443']
  volumes ['/opt/pihole:/etc/pihole/', '/opt/dnsmasq.d:/etc/dnsmasq.d']
  env ["ServerIP=#{node['ipaddress']}", "ServerIPv6=#{node['ip6address']}", 'TZ="America/Los_Angeles"']
  cap_add 'NET_ADMIN'
  dns ['127.0.0.1', '1.1.1.1']
  restart_polify 'unless-stopped'
  action :run
end
