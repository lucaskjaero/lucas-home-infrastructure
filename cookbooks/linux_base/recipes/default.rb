#
# Cookbook:: linux_base
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Set up ssh server
include_recipe 'sshd'

# Set up mosh, a more resilient ssh
package 'mosh'

user 'lucas' do
  comment 'A random user'
  uid '1234'
  home '/home/lucas'
  shell '/bin/bash'
  password 'password'
end

# Authorize my laptop key to log in to all boxes
ssh_authorize_key 'lucas@Gazelle' do
  key 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDWVT2invWwbSheAu9mpVwSPSVSicdDe6Xytkqbc1becWa+Dad5DwM03+zNWXSy9UB1B/hR/O1V/zqF0AYVs38rgrhJyiG15oTUXXZx70eazNCmTKZp7N4UVz9GfZxAusGG5ltJwisr9p1qOlqNaGS05JMZY0+U6DxDBLQm3wkTJ9AoWZKEx8Ae/1DqH01MQeiGgb5Ij4tr4gLFY9A/k368rsNiRC2O4I9BnCoKyCKFRuqqT3lGeJ2sXxEi2+7DtIblNBmjNNdspgBJEKJar0yTlquv+oWCxy1ydMx4hWgd0haUofb03sx+Yh5KEhs7N0RHhZc5xMzRQozGc9aNPSB9'
  user 'lucas'
end

# System monitoring
package 'netdata'
