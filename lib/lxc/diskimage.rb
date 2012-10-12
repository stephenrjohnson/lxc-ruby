require 'fileutils'
module LXC
  class DiskImage
    attr_reader   :config

  	# Initialize a new LXC::DiskImage instance
    # @param [String] name container name
    # @return [LXC::DiskImage] container instance
    def initialize(path)

      if path == ""
        raise DiskImageError, "DiskImage path empty #{path}"
      end

      if File.exists?(File.join(path,"config"))
    		@config = LXC::Configuration.load_file(File.join(path,"config"))
    	end
      	@path = path
    end

    def create(name,password,username,ip,arch = "amd64")
    	script = File.join(File.expand_path(File.dirname(__FILE__)),'../','../','bin','lxc-ubuntu-extra')
      if File.exists?(@path)
        raise DiskImageError, "DiskImage already exits #{@path}"
      else
        output = `#{script} --path #{@path} --name #{name} --password #{password} --username #{username} --ip #{ip} --arch #{arch}`
        if $?.to_i == 0
          @config = LXC::Configuration.load_file(File.join(@path,"config"))
        else
          raise DiskImageError, "DiskImage error #{output}"
        end
      end
    end
  end
end
