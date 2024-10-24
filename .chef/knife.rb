# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "lkjaero"
client_key               "#{current_dir}/lkjaero.pem"
chef_server_url          "https://api.chef.io/organizations/lucas-kjaero-home"
cookbook_path            ["#{current_dir}/../cookbooks"]
editor                   "/usr/bin/nano"
