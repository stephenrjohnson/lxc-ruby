require 'fileutils'
module LXC
  class DiskImage

  	# Initialize a new LXC::DiskImage instance
    # @param [String] name container name
    # @return [LXC::DiskImage] container instance
    def initialize(path)
      if @path == ""
        raise DiskImageError "DiskImage path empty #{@path}"
      end
    	if File.exits(File.join(@path,"config"))
    		@config = LXC.configuration.load_file(File.join(@path,"config"))
    	end
      	@path = path
    end

    def create(name,password,username,ip,arch = "amd64")
    	script = File.join((File.expand_path(File.dirname(__FILE__),'../','bin','lxc-ubuntu-extra')))
      if File.exists(@path)
        raise DiskImageError "DiskImage already exits #{@path}"
      else
        system "#{script} --path #{path} --name #{name} --password #{password} --username #{username} --ip #{ip} --arch #{amd64}"
        config = LXC::configuration.load_file(File.join(@path,"config"))
      end
    end

    end
end
