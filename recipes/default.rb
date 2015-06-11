#
# Cookbook Name:: chef-zeromq
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
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

remote_file "zeromq-4.1.1.tar.gz" do
  source "http://download.zeromq.org/zeromq-4.1.1.tar.gz"
  action :create
end

execute "unpack-zeromq" do
  command "tar -xzf zeromq-4.1.1.tar.gz -C /usr/local/src"
  action :run
end

execute "build-zeromq" do
  command "./configure --without-libsodium && make"
  cwd "/usr/local/src/zeromq-4.1.1"
  action :run
end