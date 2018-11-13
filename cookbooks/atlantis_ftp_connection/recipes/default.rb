#
# Cookbook:: atlantis_ftp_connection
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'sshfs'

directory '/Atlantis' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# mount 'atlantis' do
#   device 'fuse'
#   enabled true
#   fstype 'sshfs#sanjid@atlantis.whatbox.ca:/home/sanjid/files'
#   mount_point '/Atlantis'
# end
