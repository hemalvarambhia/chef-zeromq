module ChefZeroMQ
  module Helper
    include Chef::Mixin::ShellOut
    def already_unpacked?
      install_path = "#{node[:zeromq][:install_dir]}/zeromq-#{node[:zeromq][:version]}"
      dir_extracted = shell_out("[ -d #{install_path} ] && echo exists", returns: [0, 2])
      
      dir_extracted.stderr.empty? && dir_extracted.stdout.strip == "exists"      
    end
  end
end