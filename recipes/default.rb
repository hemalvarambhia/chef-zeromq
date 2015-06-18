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

remote_file "zeromq-2.2.0.tar.gz" do
  source "http://download.zeromq.org/zeromq-2.2.0.tar.gz"
  action :create
  not_if { already_unpacked? }
end

execute "unpack-zeromq" do
  command "tar -xzf zeromq-2.2.0.tar.gz -C /usr/local/src"
  not_if { already_unpacked? }
  action :run
end

file "/usr/local/src/zeromq-2.2.0.tar.gz" do
  action :delete
end

execute "build-zeromq" do
  command "./configure --without-libsodium && make && make install"
  cwd "/usr/local/src/zeromq-2.2.0"
  action :run
end

package "libzmq-dev" do
  action :install
end

execute "ldconfig" do
  cwd "/usr/local/src/zeromq-2.2.0"
  user "root"
  action :run
end

include_recipe "firewall::default"

firewall_rule "zmq-firewall-rule" do
  protocol :tcp
  port 9000
  action :allow
end

firewall_rule "ssh" do
  protocol :tcp
  port 22
  action :allow
end