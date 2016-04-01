# Bad response error implementation

module VK
  class BadResponse < VK::Error
    def_delegators :@env, :status

    def to_s
      "status=#{status}"
    end
  end
end
