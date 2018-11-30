# Sets up a media server

# A name that describes what the system you"re building with Chef does.
name "thelio"
default_source :supermarket

run_list "recipe[linux_base]", "recipe[docker_base]", "recipe[home_media_server]", "recipe[home_media_server::sonarr]"

# Specify a custom source for a single cookbook:
# cookbook "example_cookbook", path: "../cookbooks/example_cookbook"
cookbook "linux_base", path: "../cookbooks/linux_base"
cookbook "docker_base", path: "../cookbooks/docker_base"
cookbook "home_media_server", path: "../cookbooks/home_media_server"
