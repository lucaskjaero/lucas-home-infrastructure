#
# Cookbook:: linux_base
# Recipe:: setup_vnc
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package "tightvncserver"

user "vnc" do
  shell "/sbin/nologin"
  comment "Service user for vnc server"
  system true
  home "/home/vnc"
  manage_home true
end

group "vnc" do
  members "vnc"
  append true
end

directory "/home/vnc/" do
  owner "vnc"
  group "vnc"
  mode "0755"
  action :create
  not_if { Dir.exist? "/home/vnc/" }
end
directory "/home/vnc/.vnc" do
  owner "vnc"
  group "vnc"
  mode "0755"
  action :create
  not_if { Dir.exist? "/home/vnc/.vnc" }
end

cookbook_file "/etc/systemd/system/vncserver@.service" do
  source "vncserver@.service"
  owner "root"
  group "root"
  mode "0755"
end

cookbook_file "/home/vnc/.vnc/xstartup" do
  source "xstartup"
  owner "vnc"
  group "vnc"
  mode "0755"
end
