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
    expect(chef_run).to create_remote_file("zeromq-2.2.0.tar.gz").with(
      source: "http://download.zeromq.org/zeromq-2.2.0.tar.gz")
  end

  it "unpacks the source" do
    expect(chef_run).to run_execute("unpack-zeromq").with(command: "tar -xzf zeromq-2.2.0.tar.gz -C /usr/local/src")
  end

  it "builds ZeroMQ from source" do
    expect(chef_run).to run_execute("build-zeromq").with(command: "./configure --without-libsodium && make && make install", cwd: "/usr/local/src/zeromq-2.2.0")
  end

  it "install libzmpq-dev" do
    expect(chef_run).to install_package "libzmq-dev"
  end

  it "runs ldconfig" do
    expect(chef_run).to run_execute("ldconfig").with(user: "root", cwd: "/usr/local/src/zeromq-2.2.0")
  end

  context "firewall" do
    it "allows incoming requests to port 9000" do
      expect(chef_run).to allow_firewall_rule("zmq-firewall-rule").with(protocol: :tcp, port: 9000)
    end
  end
end