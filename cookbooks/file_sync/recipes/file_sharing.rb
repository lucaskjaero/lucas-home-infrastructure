#
# Cookbook:: file_sync
# Recipe:: file_sharing
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe "samba::server"

samba_share "files" do
  guest_ok "no"
  write_list ["lucas"]
  read_only "yes"
  create_directory false
  valid_users "lucas syncthing"
  path "/files"
end
