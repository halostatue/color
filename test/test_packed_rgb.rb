# -*- ruby encoding: utf-8 -*-

require 'color'
require 'minitest_helper'

module TestColor
  class TestPackedRGB < Minitest::Test
    def test_to_rgb
      assert_equal("#9fc3ff", Color::PackedRGB.new(-6306817).to_rgb.html)
    end
  end
end
