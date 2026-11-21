require 'spec_helper'

RSpec.describe Rex::Text do
  describe '.encode_base64' do
    it 'encodes binary input' do
      expect(described_class.encode_base64("\x00\xff".b)).to eq('AP8=')
    end

    it 'converts non-string input with to_s' do
      expect(described_class.encode_base64(123)).to eq('MTIz')
    end

    it 'encodes nil as an empty string' do
      expect(described_class.encode_base64(nil)).to eq('')
    end

    it 'uses the supplied line delimiter' do
      expect(described_class.encode_base64('a', '|')).to eq('YQ==|')
    end
  end

  describe '.decode_base64' do
    it 'decodes binary output' do
      expect(described_class.decode_base64('AP8=')).to eq("\x00\xff".b)
    end

    it 'decodes nil as an empty string' do
      expect(described_class.decode_base64(nil)).to eq('')
    end
  end

  describe '.encode_base64url' do
    it 'uses URL-safe characters and omits padding' do
      expect(described_class.encode_base64url("\xfb\xff".b)).to eq('-_8')
    end

    it 'encodes nil as an empty string' do
      expect(described_class.encode_base64url(nil)).to eq('')
    end
  end

  describe '.decode_base64url' do
    it 'ignores characters outside the URL-safe alphabet' do
      expect(described_class.decode_base64url('! -_8?')).to eq("\xfb\xff".b)
    end

    it 'decodes an empty string' do
      expect(described_class.decode_base64url('')).to eq('')
    end
  end
end
