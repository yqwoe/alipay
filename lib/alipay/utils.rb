module Alipay
  module Utils
    require 'JSON'
    def self.stringify_keys(object)
      JSON.parse JSON[object]
    end

    # 退款批次号，支付宝通过此批次号来防止重复退款操作，所以此号生成后最好直接保存至数据库，不要在显示页面的时候生成
    # 共 24 位(8 位当前日期 + 9 位纳秒 + 1 位随机数)
    def self.generate_batch_no
      t = Time.now
      batch_no = t.strftime('%Y%m%d%H%M%S') + t.nsec.to_s
      batch_no.ljust(24, rand(10).to_s)
    end
  end
end
