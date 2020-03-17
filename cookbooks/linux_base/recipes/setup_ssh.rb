#
# Cookbook:: linux_base
# Recipe:: setup_ssh
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Set up ssh server
include_recipe "sshd"

# Set up mosh, a more resilient ssh
package "mosh"

# Hack to keep test kitchen from crashing on key authorization
user "lucas" do
  comment "A random user"
  uid "1337"
  home "/home/lucas"
  shell "/bin/bash"
  password "$1$bZBO16pg$AO8Ycsf3Jq4q5rBYsqRJE0"
  not_if "id -u lucas"
end

# Authorize my linux laptop key to log in to all boxes
ssh_authorize_key "lucas@Gazelle" do
  key "AAAAB3NzaC1yc2EAAAADAQABAAABAQDWVT2invWwbSheAu9mpVwSPSVSicdDe6Xytkqbc1becWa+Dad5DwM03+zNWXSy9UB1B/hR/O1V/zqF0AYVs38rgrhJyiG15oTUXXZx70eazNCmTKZp7N4UVz9GfZxAusGG5ltJwisr9p1qOlqNaGS05JMZY0+U6DxDBLQm3wkTJ9AoWZKEx8Ae/1DqH01MQeiGgb5Ij4tr4gLFY9A/k368rsNiRC2O4I9BnCoKyCKFRuqqT3lGeJ2sXxEi2+7DtIblNBmjNNdspgBJEKJar0yTlquv+oWCxy1ydMx4hWgd0haUofb03sx+Yh5KEhs7N0RHhZc5xMzRQozGc9aNPSB9"
  user "lucas"
end

# Authorize my laptop key to log in to all boxes
ssh_authorize_key "lkjaero@macattack" do
  key "AAAAB3NzaC1yc2EAAAADAQABAAABAQDZOYxYOS3j/+3Lg8F99sNS3uKJRkN+gxnWfEzZYpEgvtkIKI5/NASH9lfILQLqwbOfmLiLKhjQkxjWn9IIVzBkONI2KueabBvPSzIdyY6wdfdA7vqezfHTPybDZhAbXZkEe+H1q/Zi2dgew4WdWTcO5kJHj1d6D7Lx+d2CEx7B4S5ktcFwjRyvqZahNvhm4sUV4L4dfTaQQ0dDhHhLrh72jlWaadJQaT3eZhvS8JWXiz+T2LvpGipVRVIp8l/uTIPidHTeayZfrs1iX1W8F9S5XHwhZ2S4b5zI1u+ldgAeSqZdj3nQiE6dQmgoGm28bsWsShhIJI9nR6KeX05k0B7f"
  user "lucas"
end
