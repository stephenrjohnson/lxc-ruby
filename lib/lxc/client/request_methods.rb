module LXC
  module RequestMethods
    def get_version
      request(:get, "/version")
    end

    def get_lxc_version
      request(:get, "/lxc_version")
    end

    def get_containers
      requst(:get, "/containers")
    end

    def get_container(name)
      request(:get, "/containers/#{name}")
    end

    def get_container_processes(name)
      request(:get, "/containers/#{name}/processes")
    end

    def container_action(name, action)
      request(:post, "/containers/#{name}/action")
    end
  end
end