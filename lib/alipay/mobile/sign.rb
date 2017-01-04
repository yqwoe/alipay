module Alipay
  module Mobile
    module Sign
      def self.params_to_string(params)
        result = params.sort.map do |key, value|
          %Q(#{key}=#{value.to_s})
        end
        result.join('&')
      end
    end
  end
end
