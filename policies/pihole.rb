# Pihole
#
# Sets up a raspberry pi with pihole

# A name that describes what the system you're building with Chef does.
name 'pihole'
default_source :supermarket
run_list 'linux_base::default'
