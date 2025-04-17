# frozen_string_literal: true

require "color"
require "minitest_helper"

module TestColor
  class TestYIQ < Minitest::Test
    def setup
      @yiq = Color::YIQ.from_fraction(0.1, 0.2, 0.3)
    end

    def test_brightness
      assert_in_tolerance(0.1, @yiq.brightness)
    end

    def test_i
      assert_in_tolerance(0.2, @yiq.i)
      assert_in_tolerance(0.2, @yiq.i)
    end

    def test_q
      assert_in_tolerance(0.3, @yiq.q)
      assert_in_tolerance(0.3, @yiq.q)
    end

    def test_to_grayscale
      assert_equal(Color::Grayscale.from_fraction(0.1), @yiq.to_grayscale)
    end

    def test_to_yiq
      assert_equal(@yiq, @yiq.to_yiq)
    end

    def test_y
      assert_in_tolerance(0.1, @yiq.y)
      assert_in_tolerance(0.1, @yiq.y)
    end

    def test_inspect
      assert_equal("YIQ [10.00% 20.00% 30.00%]", @yiq.inspect)
    end
  end
end
