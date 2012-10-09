require 'lxc/version'
require 'lxc/errors'
require 'lxc/shell'
require 'lxc/configuration_options'
require 'lxc/configuration'
require 'lxc/container'

module LXC
  class << self
    include LXC::Shell

    # Check if binary file is installed
    # @param [String] name binary filename
    # @return [Boolean] true if installed
    def binary_installed?(name)
      path = File.join(LXC::Shell::BIN_PREFIX, name)
      File.exists?(path)
    end

    # Check if all binaries are present in the system
    # @return [Boolean] true if binary files are found
    def installed?
      !BIN_FILES.map { |f| binary_installed?(f) }.uniq.include?(false)
    end

    # Get LXC configuration info
    # @return [Hash] hash containing config groups
    def config
      str = LXC.run('checkconfig') { 'sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"' }
      data = str.scan(/^([\w\s]+): (enabled|disabled)$/).map { |r|
        [r.first.downcase.gsub(' ', '_'), r.last == 'enabled']
      }
      Hash[data]
    end

    # Get container information record
    # @param [name] name container name
    # @return [LXC::Container] container instance
    def container(name)
      LXC::Container.new(name)
    end

    # Get a list of all available containers
    # @param [String] filter select containers that match string
    # @return [Array] array of LXC::Containers
    def containers(filter=nil)
      names = LXC.run('ls').split("\n").uniq
      names.delete_if { |v| !v.include?(filter) } if filter.kind_of?(String)
      names.map { |name| Container.new(name) }
    end

    # Get a list of all available containers
    # @return [Array]
    def lscontainers
      names = LXC.run('ls').split("\n").uniq
    end

    # Get current LXC version
    # @return [String] current LXC version
    def version
      LXC.run('version').strip.split(' ').last
    end
  end
end
