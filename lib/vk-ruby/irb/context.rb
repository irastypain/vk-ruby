# CLI context

module VK
  class IRB
    class Context < VK::Application
      attr_reader :config

      def initialize(config)
        @config = config
      end
    end
  end
end
