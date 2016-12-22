module Alipay
  module Mobile
    module Service
      MOBILE_SECURITY_PAY_REQUIRED_PARAMS = %w( notify_url out_trade_no subject total_fee body )
      def self.trade_app_pay_string(params, options = {})
        params = Utils.stringify_keys(params)
        Alipay::Service.check_required_params(params, MOBILE_SECURITY_PAY_REQUIRED_PARAMS)
        sign_type = options[:sign_type] || Alipay.sign_type
        key = options[:key] || Alipay.key
        raise ArgumentError, "only support RSA sign_type" if sign_type != 'RSA'

        params = {
          'service'        => 'alipay.trade.app.pay',
          '_input_charset' => 'utf-8',
          'app_id'         => options[:app_id] || Alipay.app_id,
          'private_key'    => key,
          'payment_type'   => '1'
        }.merge(params)

        string = Alipay::Mobile::Sign.params_to_string(params)
        sign = CGI.escape(Alipay::Sign::RSA.sign(key, string))

        %Q(#{string}&sign="#{sign}"&sign_type="RSA")
      end
    end
  end
end
