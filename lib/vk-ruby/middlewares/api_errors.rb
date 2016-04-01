# API error handler middleware
#
# @see http://rubydoc.info/gems/faraday

module VK
  module MW
    class APIErrors < Faraday::Response::Middleware
      def call(environment)
        @app.call(environment).on_complete do |env|
          if env.body.key?('error')
            if env.url.host == 'oauth.vk.com'
              fail VK::AuthorizationError.new(env)
            else
              fail VK::APIError.new(env)
            end
          end
        end
      end
    end
  end
end
