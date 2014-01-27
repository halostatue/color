require 'color'
require 'color/css'
require 'minitest_helper'

module TestColor
  class TestCSS < Minitest::Test
    def test_index_with_known_name
      assert_same(Color::RGB::AliceBlue, Color::CSS[:aliceblue])
      assert_same(Color::RGB::AliceBlue, Color::CSS["AliceBlue"])
      assert_same(Color::RGB::AliceBlue, Color::CSS["aliceBlue"])
      assert_same(Color::RGB::AliceBlue, Color::CSS["aliceblue"])
      assert_same(Color::RGB::AliceBlue, Color::CSS[:AliceBlue])
    end

    def test_index_with_unknown_name
      assert_equal(nil, Color::CSS['redx'])
    end
  end
end
