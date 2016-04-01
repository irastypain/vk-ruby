require 'helpers'

describe VK::MW::APIErrors, type: :middleware do
  context VK::APIError do
    let(:data) do
      {
        'error' => {
          'error_code' => 'foo',
          'error_msg' =>  'bar'
        }
      }
    end

    it { expect { process(data) }.to raise_error(VK::APIError) }
  end

  context VK::AuthorizationError do
    let(:url) { URI.parse('http://oauth.vk.com/access_token') }

    let(:data) do
      {
        'error' => 'foo',
        'error_description' => 'bar'
      }
    end

    it { expect { process(data) }.to raise_error(VK::AuthorizationError) }
  end
end
