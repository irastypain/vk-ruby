# CLI params wrapper

module VK
  class IRB
    Params = Struct.new(:docopt) do
      DEFAULT_CONFIG_FILE = "#{ENV['HOME']}/.vk.yml".freeze

      def list?
        docopt['list']
      end

      def add?
        docopt['add']
      end

      def remove?
        docopt['remove']
      end

      def update?
        docopt['update']
      end

      def eval?
        docopt['--eval'] || docopt['-e']
      end

      alias_method :evaluated_code, :eval?

      def execute?
        docopt['--execute'] || docopt['-ex']
      end

      alias_method :executed_file, :execute?

      def user_name
        docopt['<name>']
      end

      def token
        docopt['<token>']
      end

      def config_file
        @config_file ||= [
          docopt['--config'],
          "#{ENV['PWD']}/.vk.yml"
        ].compact.detect { |f| File.exist?(f) } || DEFAULT_CONFIG_FILE
      end
    end
  end
end
