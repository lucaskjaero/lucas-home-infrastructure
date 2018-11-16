# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'media_server'
default_source :supermarket

run_list 'recipe[linux_base]', 'recipe[linux_base::docker]', 'recipe[home_media_server]'

# Specify a custom source for a single cookbook:
# cookbook 'example_cookbook', path: '../cookbooks/example_cookbook'
cookbook 'linux_base', path: '../../cookbooks/linux_base'
cookbook 'home_media_server', path: '../../cookbooks/home_media_server'
