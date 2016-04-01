require 'helpers'

describe VK::APIError, type: :exception do
  let(:api_method)  { 'users.get' }
  let(:url)         { URI.parse("https://api.vk.com/#{api_method}") }
  let(:code)        { 1 }
  let(:description) { 'error description' }

  let(:body) do
    {
      'error' => {
        'error_code' => code,
        'error_msg' =>  description,
        'request_params' => request_params
      }
    }
  end

  let(:request_params) do
    [
      { 'key' => 'key1', 'value' => 'value1' },
      { 'key' => 'key2', 'value' => 'value2' }
    ]
  end

  it { exception.method.should eq(api_method) }
  it { exception.code.should eq(code) }
  it { exception.description.should eq(description) }
  it { exception.request_params.should eq(request_params.each_with_object({}) { |a, e| a[e['key']] = e['value'] }) }

  it { exception.to_s.should include(code.to_s) }
  it { exception.to_s.should include(api_method.to_s) }
  it { exception.to_s.should include(description.to_s) }
end
