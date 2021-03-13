#
# Cookbook:: lacabana
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

media1 = "/video/media1"
media2 = "/video/media2"
media3 = "/video/media3"

# Needed because the group might not have been created yet
media_server_group = 8888

# This drive is mostly meant for TV
directory media1 do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if { Dir.exist? media1 }
end

directory media2 do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if { Dir.exist? media2 }
end

directory media3 do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if { Dir.exist? media3 }
end

# TV directories section
directory "#{media1}/TV" do
  owner "root"
  group media_server_group
  mode "0775"
  action :create
  not_if { Dir.exist? "#{media1}/TV" }
end

directory "#{media1}/TV-Chinese" do
  owner "root"
  group media_server_group
  mode "0775"
  action :create
  not_if { Dir.exist? "#{media1}/TV-Chinese" }
end

directory "#{media1}/TV-Danish" do
  owner "root"
  group media_server_group
  mode "0775"
  action :create
  not_if { Dir.exist? "#{media1}/TV-Danish" }
end

directory "#{media1}/TV-Spanish" do
  owner "root"
  group media_server_group
  mode "0775"
  action :create
  not_if { Dir.exist? "#{media1}/TV-Spanish" }
end

# Media3 is for overflow

directory "#{media3}/TV" do
  owner "root"
  group media_server_group
  mode "0775"
  action :create
  not_if { Dir.exist? "#{media1}/TV" }
end