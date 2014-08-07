# encoding: utf-8
require 'minitest/autorun'
require_relative '../lib/regexp_m17n'

class RegexpTest < MiniTest::Unit::TestCase
  def test_non_empty_string
    Encoding.list.each do |enc|

      if enc.dummy?

        # Special handling for utf7, snce jruby is
        # regarding it as non ascii compatibile 
        if enc.name == "UTF-7"
          return assert(RegexpM17N.non_empty?('.'.force_encoding("UTF-8")))
        end

        enc_ascii = Encoding::Converter.asciicompat_encoding(enc.name)

        unless enc_ascii.nil?
          # if there is compatibile ascii encoding,
          # use that encoding instead of dummy
          assert(RegexpM17N.non_empty?('.'.encode(enc_ascii)))
        else
          # This is where ISO-2022-JP-2 land. UTF-7 also, but
          # it is already handled for jruby.
          # Utf-8 is forced in (changed) non_empy? method,
          # so forcung utf-8 skpis extra conversion
          # since strings in both encodings are valid utf-8
          assert(RegexpM17N.non_empty?('.'.force_encoding("UTF-8")))
        end

      else
        assert(RegexpM17N.non_empty?('.'.encode(enc)))
      end
    end
  end
end
