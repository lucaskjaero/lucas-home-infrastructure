# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'media_server'
default_source :supermarket

run_list 'recipe[home_media_server::mount_atlantis]', 'recipe[home_media_server::plex_docker]', 'recipe[home_media_server::sonarr]'

# Specify a custom source for a single cookbook:
# cookbook 'example_cookbook', path: '../cookbooks/example_cookbook'
cookbook 'home_media_server', path: '../../cookbooks/home_media_server'
