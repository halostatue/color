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

    def test_y
      assert_in_tolerance(0.1, @yiq.y)
      assert_in_tolerance(0.1, @yiq.y)
    end

    def test_inspect
      assert_equal("YIQ [10.00% 20.00% 30.00%]", @yiq.inspect)
    end

    def test_pretty_print
      assert_pretty_inspect "YIQ\n[10.00%\n  20.00%\n  30.00%]\n", @yiq
    end
  end

  class TestYIQConversions < Minitest::Test
    def setup
      @yiq = Color::YIQ.from_fraction(0.1, 0.2, 0.3)
    end

    def test_to_cmyk
      skip("to_cmyk conversion not yet implemented")
      cmyk = @yiq.to_cmyk
      assert_kind_of(Color::CMYK, cmyk)
    end

    def test_to_grayscale
      gs = @yiq.to_grayscale
      assert_kind_of(Color::Grayscale, gs)
      assert_in_tolerance(0.1, gs.g)
      assert_equal(Color::Grayscale.from_fraction(0), Color::YIQ.from_values(0, 0, 0).to_grayscale)
    end

    def test_to_hsl
      skip("to_hsl conversion not yet implemented")
      hsl = @yiq.to_hsl
      assert_kind_of(Color::HSL, hsl)
    end

    def test_to_lab
      skip("to_lab conversion not yet implemented")
      lab = @yiq.to_lab
      assert_kind_of(Color::CIELAB, lab)
    end

    def test_to_rgb
      skip("to_rgb conversion not yet implemented")
      rgb = @yiq.to_rgb
      assert_kind_of(Color::RGB, rgb)
    end

    def test_to_xyz
      skip("to_xyz conversion not yet implemented")
      xyz = @yiq.to_xyz
      assert_kind_of(Color::XYZ, xyz)
    end

    def test_to_yiq
      assert_equal(@yiq, @yiq.to_yiq)
      assert_kind_of(Color::YIQ, @yiq.to_yiq)
    end

    def test_to_internal
      assert_equal([0.0, 0.0, 0.0], Color::YIQ.from_values(0, 0, 0).to_internal)
    end
  end
end
