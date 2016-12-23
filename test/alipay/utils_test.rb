require 'test_helper'

class Alipay::UtilsTest < Minitest::Test
  def test_stringify_keys
    hash = { 'a' => 1, :b => 2, :c => { :d => 3  } }
    assert_equal({ 'a' => 1, 'b' => 2, 'c' => { 'd' => 3 } }.sort, Alipay::Utils.stringify_keys(hash).sort)
  end

  def test_generate_batch_no
    assert_equal(24, Alipay::Utils.generate_batch_no.size)
  end
end
