# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ExtractionTokenUtil do
  let(:uuid) { '00000000-0000-0000-0000-000000000001' }
  let(:wildcard) { '?variablename' }

  describe '#uuid?' do
    it 'recognises an uuid' do
      expect(described_class.uuid?(uuid)).to eq(true)
    end

    it 'does not recognise a quoted uuid' do
      val = described_class.uuid?(described_class.quote(uuid))
      expect(val).to eq(false)
    end

    it 'does not recognise a string that contains a uuid' do
      expect(described_class.uuid?("uuid: #{uuid} ")).to eq(false)
    end
  end

  describe '#wildcard?' do
    it 'recognises a string that represents a wildcard' do
      expect(described_class.wildcard?(wildcard)).to eq(true)
    end
  end

  describe '#valid_fluidx_barcode?' do
    it 'detects a valid fluidx barcode' do
      expect(
        described_class.valid_fluidx_barcode?('FR123456')
      ).to eq(true)
    end

    it 'rejects invalid fluidx barcode' do
      expect(
        described_class.valid_fluidx_barcode?('12345678')
      ).to eq(false)
    end
  end

  describe '#pad' do
    it 'pads a string with a character using a length' do
      expect(described_class.pad('1234', '0', 8)).to eq('00001234')
    end

    it 'does not pad a string when the length is bigger than the padded goal' do
      expect(described_class.pad('1234', '0', 2)).to eq('1234')
    end
  end

  describe '#pad_location' do
    it 'does not change already padded locations' do
      expect(described_class.pad_location('A01')).to eq('A01')
    end

    it 'pads location not padded' do
      expect(described_class.pad_location('A1')).to eq('A01')
    end
  end

  describe '#unpad_location' do
    it 'does not unpad already unpadded locations' do
      expect(described_class.unpad_location('A1')).to eq('A1')
    end

    it 'unpads location not unpadded' do
      expect(described_class.unpad_location('A01')).to eq('A1')
    end
  end

  describe '#generate_positions' do
    it 'generates a padded list of well positions' do
      letters = ('A'..'C').to_a
      numbers = ('1'..'3').to_a
      expect(
        described_class.generate_positions(letters, numbers)
      ).to eq(%w[A01 B01 C01 A02 B02 C02 A03 B03 C03])
    end
  end

  describe '#quote' do
    it 'quotes an string' do
      expect(described_class.quote('abc')).to eq('"abc"')
    end
  end

  describe '#unquote' do
    it 'unquotes a string' do
      expect(described_class.unquote('"abc"')).to eq('abc')
    end
  end

  describe '#quote_if_uuid' do
    it 'quotes the string if is an uuid' do
      expect(described_class.quote_if_uuid(uuid)).to eq("\"#{uuid}\"")
    end

    it 'does not quote the string if is not an uuid' do
      expect(described_class.quote_if_uuid('text')).to eq('text')
    end

    it 'returns nil if the string is nil' do
      expect(described_class.quote_if_uuid(nil)).to eq(nil)
    end
  end

  describe '#kind_of_asset_id?' do
    it 'detects when an argument is a uuid' do
      expect(described_class.kind_of_asset_id?(uuid)).to eq(true)
    end

    it 'detects when the argument is a wildcard' do
      expect(described_class.kind_of_asset_id?(wildcard)).to eq(true)
    end

    it 'does not fail when the argument is any other value' do
      [{}, nil, Object.new, '', 'abc'].each do |val|
        expect(described_class.kind_of_asset_id?(val)).to eq(false)
      end
    end
  end
end
