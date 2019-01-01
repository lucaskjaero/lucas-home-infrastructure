#
# Cookbook:: file_sync
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

files = node["file_share"]["share_directories"]

files.each do |file|
  samba_share file do
    guest_ok "no"
    write_list ["lucas"]
    read_only "yes"
    create_directory false
    valid_users "lucas syncthing"
    path file
  end
end
