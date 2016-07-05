# API error implementation

module VK
  class APIError < VK::Error
    # @!attribute [r] method
    #   @return [String] API method
    def method
      @method ||= @env.url.path.split('/').last
    end

    # @!attribute [r] code
    #   @return [String] API error code
    def code
      @code ||= @env.body['error']['error_code'].to_i
    end

    # @!attribute [r] description
    #   @return [String] API error description
    def description
      @description ||= @env.body['error']['error_msg']
    end

    # @!attribute [r] request_params
    #   @return [String] request params
    def request_params
      @request_params ||= @env.body['error']['request_params'].each_with_object({}) { |a, e| a[e['key']] = e['value'] }
    end

    def redirect_uri
      @redirect_uri ||= @env.body['error']['redirect_uri']
    end

    alias_method :params, :request_params

    def to_s
      "code=#{code} method='#{method}' description='#{description}'"
    end
  end
end
