# API request params wrapper

module VK
  Params = Struct.new(:config, :options) do
    def host
      (options[:host] || config.host).dup.tap { |value| value.gsub!('https', 'http') unless ssl }
    end

    def verb
      options[:verb] || config.verb
    end

    def timeout
      options[:timeout] || config.timeout
    end

    def open_timeout
      options[:open_timeout] || config.open_timeout
    end

    def ssl
      options[:ssl] != false ? config.ssl.merge(options[:ssl] || {}) : false
    end

    def proxy
      if options[:proxy]
        proxy_options = Faraday::ProxyOptions.from(options[:proxy])
        config.proxy ? config.proxy.merge(proxy_options) : proxy_options
      else
        config.proxy
      end
    end

    def middlewares
      options[:middlewares] || config.middlewares
    end

    alias_method :stack, :middlewares

    def query
      %w(host verb timeout open_timeout ssl proxy middlewares stack).map(&:to_sym).each_with_object(options.dup) do |name, result|
        result.delete(name)
      end
    end
  end
end
