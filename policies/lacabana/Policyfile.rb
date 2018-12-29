# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

name "lacabana"
default_source :supermarket

run_list "recipe[linux_base]", "recipe[ubuntu_desktop_base]", "recipe[file_sync]", "recipe[file_sync::file_sharing]"

cookbook "linux_base", path: "../../cookbooks/linux_base"
cookbook "docker_base", path: "../../cookbooks/docker_base"
cookbook "file_sync", path: "../../cookbooks/file_sync"
cookbook "ubuntu_desktop_base", path: "../../cookbooks/ubuntu_desktop_base"
