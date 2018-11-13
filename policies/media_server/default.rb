# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'media_server'
default_source :supermarket

default['plex']['channel'] = 'plexpass'
default['plex']['token'] = 'KqHuz9kXEgYAuvyQpNrf'

run_list 'recipe[plex]', 'recipe[fuse]', 'recipe[fuse::sshfs]', 'recipe[home_media_server::mount_atlantis]'

# Specify a custom source for a single cookbook:
# cookbook 'example_cookbook', path: '../cookbooks/example_cookbook'
cookbook 'plex', '~> 0.2.3', :supermarket
cookbook 'fuse', '~> 0.1.2', :supermarket

cookbook 'home_media_server', path: '../../cookbooks/home_media_server'
