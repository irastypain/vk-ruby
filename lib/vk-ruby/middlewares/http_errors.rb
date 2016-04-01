# HTTP error handler middleware
#
# @see http://rubydoc.info/gems/faraday

module VK
  module MW
    class HttpErrors < Faraday::Response::Middleware
      def call(environment)
        @app.call(environment).on_complete do |env|
          fail VK::BadResponse.new(env) unless env.success?
        end
      end
    end
  end
end
