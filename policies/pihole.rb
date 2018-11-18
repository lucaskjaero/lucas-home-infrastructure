# Pihole
#
# Sets up a raspberry pi with pihole

# A name that describes what the system you"re building with Chef does.
name "pihole"
default_source :supermarket
run_list "linux_base::default", "pihole"

cookbook "linux_base", path: "../cookbooks/linux_base"
cookbook "docker_base", path: "../cookbooks/docker_base"
cookbook "pihole", path: "../cookbooks/pihole"
