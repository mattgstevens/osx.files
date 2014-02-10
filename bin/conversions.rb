def usage
  puts %Q{
    convert(convert_type, data)
      convert_type: one of [encode_base2, decode_base64]
      data: input to perform conversion on}
end

require 'base64'
class Conversions
  class << self

    def encode_base2(integer)
      base = 2
      integer = integer.to_i
      [].tap do |ret_val|
        return 0 if integer == 0
        while integer > 0
          ret_val.unshift integer % base
          integer /= base
        end
      end.join.to_i
    end

    def decode_base64(data)
      puts Base64.decode64(data).unpack
    end

    def method_missing(sym, *args, &block)
      usage
    end

  end
end

# main

if ARGV.length > 2
  usage; return
end
puts Conversions.send(ARGV[0], ARGV[1])
