module Alipay
  module Mobile
    module Service
      MOBILE_SECURITY_PAY_REQUIRED_PARAMS = %w( app_id notify_url biz_content )
      def self.trade_app_pay_string(options)
        params = Utils.stringify_keys(options)
        # Alipay::Service.check_required_params(options, MOBILE_SECURITY_PAY_REQUIRED_PARAMS)
        key = options[:key] || Alipay.key

        biz_content = options[:biz_content]
        new_biz_content = {
          timeout_express: biz_content[:timeout_express] || '30m',
          product_code:    biz_content[:product_code] || 'QUICK_MSECURITY_PAY'
        }

        new_biz_content.merge!(biz_content) if biz_content.is_a? Hash
        biz_string = Alipay::Mobile::Sign.params_to_string(new_biz_content)

        params = {
          'app_id'        => options[:app_id] || Alipay.app_id,
          'biz_content'   => biz_string,
          'charset'       => 'utf-8',
          'method'        => 'alipay.trade.app.pay',
          'sign_type'     => 'RSA',
          'timestamp'     => options[:timestamp] || Time.zone.now,
          'version'       => '1.0',
        }

        string = Alipay::Mobile::Sign.params_to_string(params)
        sign = URI.escape(Alipay::Sign::RSA.sign(key, string))

        URI.escape("#{string}&sign=#{sign}")
      end
    end
  end
end
