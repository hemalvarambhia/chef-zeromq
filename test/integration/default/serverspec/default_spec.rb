require 'spec_helper'

describe "Installing ZeroMQ" do
 describe file "/usr/lib/libzmq.so" do
   it { should be_file }
 end

 describe command "ldconfig -p | grep /usr/lib/libzmq.so" do
   its(:stdout) { should match /libzmq.so/ } 
 end
end