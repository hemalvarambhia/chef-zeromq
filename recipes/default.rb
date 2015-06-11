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