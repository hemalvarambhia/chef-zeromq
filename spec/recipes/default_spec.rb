require_relative '../spec_helper'

describe "chef-zeromq::default" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
  
  it "updates the apt repo" do
    expect(chef_run).to include_recipe "apt::default"
  end

  it "installs dependencies" do
    expect(chef_run).to install_package "libtool"
    expect(chef_run).to install_package "pkg-config"
    expect(chef_run).to include_recipe "build-essential"
    expect(chef_run).to install_package "autoconf"
    expect(chef_run).to install_package "automake"
  end

  it "downloads the source code" do
    expect(chef_run).to create_remote_file("zeromq-4.1.1.tar.gz").with(
      source: "http://download.zeromq.org/zeromq-4.1.1.tar.gz")
  end

end