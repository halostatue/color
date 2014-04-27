# -*- ruby encoding: utf-8 -*-

require 'color'
require 'minitest_helper'

module TestColor
  class TestYIQ < Minitest::Test
    def setup
      @yiq = Color::YIQ.from_fraction(0.1, 0.2, 0.3)
    end

    def test_brightness
      assert_in_delta(0.1, @yiq.brightness, Color::COLOR_TOLERANCE)
    end

    def test_i
      assert_in_delta(0.2, @yiq.i, Color::COLOR_TOLERANCE)
      assert_in_delta(0.2, @yiq.i, Color::COLOR_TOLERANCE)
      @yiq.i = 0.5
      assert_in_delta(0.5, @yiq.i, Color::COLOR_TOLERANCE)
      @yiq.i = 5
      assert_in_delta(1.0, @yiq.i, Color::COLOR_TOLERANCE)
      @yiq.i = -5
      assert_in_delta(0.0, @yiq.i, Color::COLOR_TOLERANCE)
    end

    def test_q
      assert_in_delta(0.3, @yiq.q, Color::COLOR_TOLERANCE)
      assert_in_delta(0.3, @yiq.q, Color::COLOR_TOLERANCE)
      @yiq.q = 0.5
      assert_in_delta(0.5, @yiq.q, Color::COLOR_TOLERANCE)
      @yiq.q = 5
      assert_in_delta(1.0, @yiq.q, Color::COLOR_TOLERANCE)
      @yiq.q = -5
      assert_in_delta(0.0, @yiq.q, Color::COLOR_TOLERANCE)
    end

    def test_to_grayscale
      assert_equal(Color::GrayScale.new(0.1), @yiq.to_grayscale)
    end

    def test_to_yiq
      assert_equal(@yiq, @yiq.to_yiq)
    end

    def test_y
      assert_in_delta(0.1, @yiq.y, Color::COLOR_TOLERANCE)
      assert_in_delta(0.1, @yiq.y, Color::COLOR_TOLERANCE)
      @yiq.y = 0.5
      assert_in_delta(0.5, @yiq.y, Color::COLOR_TOLERANCE)
      @yiq.y = 5
      assert_in_delta(1.0, @yiq.y, Color::COLOR_TOLERANCE)
      @yiq.y = -5
      assert_in_delta(0.0, @yiq.y, Color::COLOR_TOLERANCE)
    end

    def test_inspect
      assert_equal("YIQ [10.00%, 20.00%, 30.00%]", @yiq.inspect)
    end
  end
end
