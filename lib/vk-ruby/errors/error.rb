# Error implementation

module VK
  class Error < StandardError
    extend Forwardable

    def initialize(env)
      @env = env
    end
  end
end
