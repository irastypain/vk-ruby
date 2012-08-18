require File.expand_path('../helpers', __FILE__)

class ExceptionsTest < MiniTest::Unit::TestCase

  def setup
    @app = VK::Standalone.new app_id: 2657696
    create_stubs!
  end

  def test_bad_requests
    assert_raises(::VK::BadResponseException) do
      @app.getProfiles http_error: :error
    end
  end

  def test_api_errors
    assert_raises(::VK::ApiException) do
      @app.getProfiles error: :error
    end
  end

end