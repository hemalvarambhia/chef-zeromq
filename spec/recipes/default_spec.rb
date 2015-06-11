require_relative '../spec_helper'

describe "chef-zeromq::default" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
  
  it "installs dependencies" do
    expect(chef_run).to install_package("libtool")
  end
end