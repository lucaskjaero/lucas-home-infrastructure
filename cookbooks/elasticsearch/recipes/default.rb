config_dir = "#{node["home_media_server"]["config_dir"]}/elasticsearch"
data_dir = "#{node["home_media_server"]["media_dir"]}/media2/elasticsearch/"

user "elasticsearch" do
  shell "/sbin/nologin"
  comment "Service user for elasticsearch"
  system true
  manage_home false
end

directory config_dir do
  owner "elasticsearch"
  group "elasticsearch"
  mode "0755"
  action :create
  not_if { Dir.exist? config_dir }
end

docker_image "Elasticsearch image" do
  repo "docker.elastic.co/elasticsearch/elasticsearch"
  action :pull
end

docker_container "Elasticsearch container" do
  container_name "elasticsearch"
  repo "docker.elastic.co/elasticsearch/elasticsearch"
  volumes ["#{config_dir}:/usr/share/elasticsearch/config", "#{data_dir}:/usr/share/elasticsearch/data"]
  port "9200:9200"
  restart_policy "unless-stopped"
  action :run
end
