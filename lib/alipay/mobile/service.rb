require 'byebug'
require 'active_support/core_ext/hash'

module Alipay
  module Mobile
    module Service
      MOBILE_SECURITY_PAY_REQUIRED_PARAMS = %w( app_id notify_url biz_content )
      def self.trade_app_pay_string(options)
        # Alipay::Service.check_required_params(options, MOBILE_SECURITY_PAY_REQUIRED_PARAMS)
        key = options[:key] || Alipay.key

        biz_content = options[:biz_content]
        new_biz_content = {
          timeout_express: biz_content[:timeout_express] || '30m',
          seller_id: '',
          product_code:    biz_content[:product_code] || 'QUICK_MSECURITY_PAY',
        }

        new_biz_content.merge!(biz_content) if biz_content.is_a? Hash

        biz_string = new_biz_content.stringify_keys!

        options = {
          'alipay_sdk' => "alipay_sdk_ruby-#{Time.now.strftime('%Y%m%d')}",
          'app_id'        => options[:app_id] || Alipay.app_id,
          'biz_content'   => biz_string,
          'charset'       => 'utf-8',
          'method'        => 'alipay.trade.app.pay',
          'notify_url'    => options[:notify_url],
          'sign_type'     => 'RSA2',
          'timestamp'     => options[:timestamp] || Time.now.strftime('%Y-%m-%d#%H:%M:%S'),
          'version'       => '1.0',
          'format' => 'json'
        }

        options = Utils.stringify_keys(options)
        string = Alipay::Mobile::Sign.params_to_string(options)
                                     .gsub('=>', ':')
                                     .gsub(/\s/, '')
                                     .gsub('#', ' ')
        sign = CGI.escape(Alipay::Sign::RSA.sign(key, string))
        string = URI.escape(string)
        string.gsub!(':', '%3A').gsub!(',', '%2C').gsub!(/\s/, '%20')

        "#{string}&sign=#{sign}"
      end
    end
  end
end
