#
# Cookbook:: db-server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

apt_update

execute 'change lang' do
  command 'locale-gen en_GB.UTF-8'
end


apt_repository 'mongodb-org' do
  uri 'http://repo.mongodb.org/apt/ubuntu'
  distribution 'xenial/mongodb-org/3.2'
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
  components ['multiverse']
end


package 'mongodb-org'


service 'mongod' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/systemd/system/mongodb.service' do
  source 'mongodb.service.erb'
  owner 'root'
  group 'root'
  mode '0750'
end

file '/etc/mongod.conf' do
  action :delete
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  owner 'root'
  group 'root'
  mode '0750'
end