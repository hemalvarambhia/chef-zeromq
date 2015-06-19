#
# Cookbook Name:: chef-zeromq
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
Chef::Resource::Execute.send(:include, ChefZeroMQ::Helper)
Chef::Resource::RemoteFile.send(:include, ChefZeroMQ::Helper)

include_recipe "apt::default"
include_recipe "build-essential::default"

package "libtool" do
  action :install
end

package "pkg-config" do
  action :install
end

package "automake" do
  action :install
end

package "uuid-dev" do
  action :install
end

remote_file "zeromq-#{node[:zeromq][:version]}.tar.gz" do
  source "http://download.zeromq.org/zeromq-#{node[:zeromq][:version]}.tar.gz"
  action :create
  not_if { already_unpacked? }
end

execute "unpack-zeromq" do
  command "tar -xzf zeromq-#{node[:zeromq][:version]}.tar.gz -C #{node[:zeromq][:install_dir]}"
  not_if { already_unpacked? }
  action :run
end

file "#{node[:zeromq][:install_dir]}/zeromq-#{node[:zeromq][:version]}.tar.gz" do
  action :delete
end

execute "build-zeromq" do
  command "./configure --without-libsodium && make && make install"
  cwd "#{node[:zeromq][:install_dir]}/zeromq-#{node[:zeromq][:version]}"
  action :run
end

package "libzmq-dev" do
  action :install
end

execute "ldconfig" do
  cwd "/usr/local/src/zeromq-#{node[:zeromq][:version]}"
  user "root"
  action :run
end
