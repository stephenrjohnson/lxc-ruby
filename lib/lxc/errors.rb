module LXC
  class Error              < StandardError ; end
  class ContainerError     < Error ; end
  class ConfigurationError < Error ; end
  class DiskImageError     < Error ; end
end
