#
# Cookbook:: file_sync
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe "::syncthing"

group "file_sync" do
  append true
  gid 9999
end
