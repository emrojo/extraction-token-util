# frozen_string_literal: true

#
# This Gem provides support for common string operations with tokens in
# Extraction lims like:
# - quoting / unquoting strings
# - padding / unpadding a string of digits until reaching a fixed size by
# using zeroes support to perform recognizion of the following tokens:
# - generate the address positions of the wells of a rack (A01, B01... F12)
#
# Also provides pattern recognision for UUID, Wildcard variables (Eg: ?a,
# ?rack, etc.), Fluidx barcodes: (Eg: FR1234678), Well Location: (Eg: A02, F11)
#
module ExtractionTokenUtil
  UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/.freeze
  WILDCARD = /\?\w*/.freeze
  LOCATION = /^([A-H])(\d{1,2})$/.freeze

  def self.fluidx_barcode_prefix
    'F'
  end

  def self.uuid?(str)
    str.is_a?(String) && !str.match(ExtractionTokenUtil::UUID).nil?
  end

  def self.quote_if_uuid(str)
    return quote(str) if uuid?(str)

    str
  end

  def self.valid_fluidx_barcode?(barcode)
    barcode.to_s.start_with?(fluidx_barcode_prefix)
  end

  def self.uuid(str)
    str.match(ExtractionTokenUtil::UUID)[0]
  end

  def self.wildcard?(str)
    str.is_a?(String) && !str.match(ExtractionTokenUtil::WILDCARD).nil?
  end

  def self.kind_of_asset_id?(str)
    (str.is_a?(String) && (wildcard?(str) || uuid?(str)))
  end

  def self.to_asset_group_name(wildcard)
    return wildcard if wildcard.nil?

    wildcard.gsub('?', '')
  end

  def self.generate_positions(letters, columns)
    size = letters.size * columns.size
    size.times.map do |idx|
      letter = position_letter_for_index(idx, letters)
      number = position_number_for_index(idx, letters, columns)
      "#{letter}#{number}"
    end
  end

  def self.position_letter_for_index(idx, letters)
    letters[(idx % letters.length).floor]
  end

  def self.position_number_for_index(idx, letters, columns)
    pad((columns[(idx / letters.length).floor]).to_s, '0', 2)
  end

  def self.pad(str, chr, size)
    "#{(size - str.size).times.map { chr }.join('')}#{str}"
  end

  def self.unpad_location(location)
    return location unless location

    loc = location.match(/(\w)(0*)(\d*)/)
    loc[1] + loc[3]
  end

  def self.pad_location(location)
    return location unless location

    parts = location.match(ExtractionTokenUtil::LOCATION)
    return nil if parts.to_a.empty?

    letter = parts[1]
    number = parts[2]
    number = ExtractionTokenUtil.pad(number, '0', 2) unless number.length == 2
    "#{letter}#{number}"
  end

  def self.quote(str)
    return str unless str

    "\"#{str}\""
  end

  def self.unquote(str)
    return str unless str

    str.gsub(/\"/, '')
  end
end
