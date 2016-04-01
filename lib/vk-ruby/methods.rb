# API namespace methods implementation

module VK
  class Methods
    # includes "VK::Namespaces"
    #
    # @!parse include VK::Namespaces

    include VK::Namespaces

    # Creates a new VK::Application instance
    #
    # @param [String] namespace namespace name
    # @param [Proc] handler API calling method handler

    def initialize(namespace, handler)
      @namespace = namespace
      @handler = handler
    end
  end
end
