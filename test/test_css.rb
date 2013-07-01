gem 'minitest'
require 'minitest/autorun'

require 'color'
require 'color/css'

module TestColor
  class TestCSS < Minitest::Test
    def test_index
      assert_equal(Color::RGB::AliceBlue, Color::CSS[:aliceblue])
      assert_equal(Color::RGB::AliceBlue, Color::CSS["AliceBlue"])
      assert_equal(Color::RGB::AliceBlue, Color::CSS["aliceBlue"])
      assert_equal(Color::RGB::AliceBlue, Color::CSS["aliceblue"])
      assert_equal(Color::RGB::AliceBlue, Color::CSS[:AliceBlue])
    end
  end
end
