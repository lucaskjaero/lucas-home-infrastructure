#
# Cookbook:: lacabana
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

directory "/files" do
  owner "root"
  mode "0777"
  action :create
  not_if { Dir.exist? "/files" }
end

