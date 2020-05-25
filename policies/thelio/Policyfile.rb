# Sets up a media server

# A name that describes what the system you"re building with Chef does.
name "thelio"
default_source :supermarket

run_list "recipe[linux_base]", "recipe[docker_base]", "recipe[home_media_server]"

# Specify a custom source for a single cookbook:
# cookbook "example_cookbook", path: "../cookbooks/example_cookbook"
cookbook "linux_base", path: "../../cookbooks/linux_base"
cookbook "docker_base", path: "../../cookbooks/docker_base"
cookbook "home_media_server", path: "../../cookbooks/home_media_server"

default["home_media_server"] = {
    config_dir: "/config",
    download_dir: "/seedbox",
    media_dir: "/video",
    timezone: 'TZ="America/Los_Angeles"',
}

default["home_media_server"]["lidarr"]["enabled"] = true
default["home_media_server"]["radarr"]["enabled"] = true
default["home_media_server"]["sonarr"]["enabled"] = true

default["home_media_server"]["seedbox"] = {
  enabled: true,
  remote_host: "euclid.whatbox.ca",
  remote_path: "/home/sanjid/files",
  remote_username: "sanjid",
}
