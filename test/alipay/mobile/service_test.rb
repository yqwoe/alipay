require 'test_helper'
require 'uri'

class Alipay::Mobile::ServiceTest < Minitest::Test
  def test_trade_app_pay_string
    params = %q(app_id=1000000000000000&biz_content={"timeout_express":"30m","seller_id":"","product_code":"QUICK_MSECURITY_PAY","total_amount":"0.01","subject":"1","body":"test","out_trade_no":"1"}&charset=utf-8&method=alipay.trade.app.pay&sign_type=RSA&timestamp=2016-12-22 20:33:02&version=1.0)

    assert_equal params, Alipay::Mobile::Service.trade_app_pay_string({
      app_id: '1000000000000000',
      key: TEST_RSA_PRIVATE_KEY,
      biz_content: {
        total_amount: '0.01',
        subject: '1',
        body: 'test',
        out_trade_no: '1',
      },
      timestamp: '2016-12-22#20:33:02'
    })
  end
end
