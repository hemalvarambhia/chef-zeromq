require 'spec_helper'

describe "Installing ZeroMQ" do
 lib_path = if os[:release].to_f == 14.04
 	      "/usr/local/lib"
	    else
	      "/usr/lib"
 	    end

 describe file "#{lib_path}/libzmq.so" do
   it { should be_file }
 end

 describe command "ldconfig -p | grep #{lib_path}/libzmq.so" do
   its(:stdout) { should match /libzmq.so/ } 
 end
end