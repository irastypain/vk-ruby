require 'helpers'

describe VK::Utils do
  describe '.camelize' do
    it { expect(VK::Utils.camelize('get_profiles')).to eq('getProfiles') }
    it { expect(VK::Utils.camelize('is_app_user')).to eq('isAppUser') }
    it { expect(VK::Utils.camelize('getProfiles')).to eq('getProfiles') }
    it { expect(VK::Utils.camelize('isAppUser')).to eq('isAppUser') }
  end

  describe '.deep_merge' do
    let(:a) do
      {
        a: 1,
        b: 2,
        c: {
          d: 3,
          e: 4,
          f: {
            g: 5
          }
        }
      }
    end

    let(:b) do
      {
        a: -1,
        c: {
          d: -3,
          f: {
            g: -5
          }
        }
      }
    end

    let(:c) { VK::Utils.deep_merge(b.dup, a.dup) }

    it { expect(a[:a]).to eq(a[:a]) }
    it { expect(a[:b]).to eq(a[:b]) }
    it { expect(a[:c][:d]).to eq(a[:c][:d]) }
    it { expect(a[:c][:e]).to eq(a[:c][:e]) }
    it { expect(a[:c][:f][:g]).to eq(a[:c][:f][:g]) }
  end

  describe '.symbolize' do
    let(:object) do
      {
        'a' => 1,
        '1' => '2',
        'c' => '3',
        :d => [1, '2', '3'],
        'e' => {
          'f' => 1,
          'g' => '2',
          'h' => '3',
          'i' => [1, '2', '3']
        }
      }
    end

    let(:result) { VK::Utils.symbolize(object) }

    it do
      expect(result).to eq(:a => 1,
                           :"1" => '2',
                           :c => "3",
                           :d => [1, :"2", :"3"],
                           :e => {
                             :f => 1,
                             :g => '2',
                             :h => "3",
                             :i => [1, :"2", :"3"]
                           })
    end
  end

  describe '.stringify' do
    let(:object) do
      {
        :a => 1,
        "1" => '2',
        :c => "3",
        :d => [1, "2", "3"],
        :e => {
          :f => 1,
          :g => '2',
          :h => "3",
          :i => [1, "2", "3"]
        }
      }
    end

    let(:result) { VK::Utils.stringify(object) }

    it do
      expect(result).to eq('a' => 1,
                           '1' => '2',
                           'c' => '3',
                           'd' => [1, '2', '3'],
                           'e' => {
                             'f' => 1,
                             'g' => '2',
                             'h' => '3',
                             'i' => [1, '2', '3']
                           })
    end
  end

  describe '.compact' do
    let(:object) do
      {
        a: 1,
        b: nil,
        c: {
          d: 2,
          e: nil,
          f: [3, :g, nil]
        }
      }
    end

    let(:result) { VK::Utils.compact(object) }

    it do
      expect(result).to eq(a: 1,
                           c: {
                             d: 2,
                             f: [3, :g]
                           })
    end
  end

  describe '.stringify_arrays' do
    let(:params) do
      {
        a: 1,
        b: %w(2 3 4),
        c: nil,
        d: ['1', '2', nil]
      }
    end

    let(:result) { VK::Utils.stringify_arrays(params) }

    it do
      expect(result).to eq(a: 1,
                           b: '2,3,4',
                           c: nil,
                           d: '1,2')
    end
  end
end
