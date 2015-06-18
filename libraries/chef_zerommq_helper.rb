module ChefZeroMQ
  module Helper
    include Chef::Mixin::ShellOut
    def already_unpacked?
      install_path = "/usr/local/src/zeromq-2.2.0"
      dir_extracted = shell_out("[ -d #{install_path} ] && echo exists", returns: [0, 2])
      
      dir_extracted.stderr.empty? && dir_extracted.stdout.strip == "exists"      
    end
  end
end