require_relative '../spec_helper'

describe "chef-zeromq::default" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
  
  before :each do
    allow_any_instance_of(Chef::Resource::Execute).to receive(:already_unpacked?).and_return(false) 
    allow_any_instance_of(Chef::Resource::RemoteFile).to receive(:already_unpacked?).and_return(false)
    @version = "4.1.1"
  end
  
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
    expect(chef_run).to create_remote_file("zeromq-#{@version}.tar.gz").with(
      source: "http://download.zeromq.org/zeromq-#{@version}.tar.gz")
  end

  it "unpacks the source" do
    expect(chef_run).to run_execute("unpack-zeromq").with(command: "tar -xzf zeromq-#{@version}.tar.gz -C /usr/local/src")
  end

  it "builds ZeroMQ from source" do
    expect(chef_run).to run_execute("build-zeromq").with(command: "./configure --without-libsodium && make && make install", cwd: "/usr/local/src/zeromq-#{@version}")
  end

  it "install libzmpq-dev" do
    expect(chef_run).to install_package "libzmq-dev"
  end

  it "runs ldconfig" do
    expect(chef_run).to run_execute("ldconfig").with(user: "root", cwd: "/usr/local/src/zeromq-#{@version}")
  end
end