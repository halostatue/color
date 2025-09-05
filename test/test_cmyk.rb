# frozen_string_literal: true

require "color"
require "minitest_helper"

module TestColor
  class TestCMYK < Minitest::Test
    def setup
      @cmyk = Color::CMYK.from_percentage(10, 20, 30, 40)
    end

    def test_cyan
      assert_in_tolerance(0.1, @cmyk.c)
      assert_in_tolerance(10, @cmyk.cyan)
      assert_in_tolerance(0.0, Color::CMYK[-1.0, 20, 30, 40].cyan)
    end

    def test_magenta
      assert_in_tolerance(0.2, @cmyk.m)
      assert_in_tolerance(20, @cmyk.magenta)
    end

    def test_yellow
      assert_in_tolerance(0.3, @cmyk.y)
      assert_in_tolerance(30, @cmyk.yellow)
    end

    def test_black
      assert_in_tolerance(0.4, @cmyk.k)
      assert_in_tolerance(40, @cmyk.black)
    end

    def test_inspect
      assert_equal("CMYK [10.00% 20.00% 30.00% 40.00%]", @cmyk.inspect)
    end

    def test_css
      assert_equal("device-cmyk(10.00% 20.00% 30.00% 40.00%, rgb(54.00% 48.00% 42.00%))", @cmyk.css)
      assert_equal("device-cmyk(10.00% 20.00% 30.00% 40.00% / 0.50, rgb(54.00% 48.00% 42.00% / 0.50))", @cmyk.css(alpha: 0.5))
      assert_equal("device-cmyk(10.00% 20.00% 30.00% 40.00%)", @cmyk.css(fallback: false))
      assert_equal("device-cmyk(10.00% 20.00% 30.00% 40.00% / 0.50)", @cmyk.css(alpha: 0.5, fallback: false))
      assert_equal("device-cmyk(10.00% 20.00% 30.00% 40.00%, rgb(0 0 100.00%))", @cmyk.css(fallback: Color::RGB::Blue))
      assert_equal("device-cmyk(10.00% 20.00% 30.00% 40.00% / 0.50, rgb(0 0 100.00% / 0.50))", @cmyk.css(alpha: 0.5, fallback: Color::RGB::Blue))
      assert_equal("device-cmyk(10.00% 20.00% 30.00% 40.00% / 0.50, rgb(0 0 100.00%))", @cmyk.css(alpha: 0.5, fallback: {color: Color::RGB::Blue}))
      assert_equal("device-cmyk(10.00% 20.00% 30.00% 40.00% / 0.50, rgb(0 0 100.00% / 0.30))", @cmyk.css(alpha: 0.5, fallback: {color: Color::RGB::Blue, alpha: 0.3}))
      assert_equal("device-cmyk(10.00% 20.00% 30.00% 40.00% / 0.50, rgb(54.00% 48.00% 42.00% / 0.30))", @cmyk.css(alpha: 0.5, fallback: {alpha: 0.3}))
    end
  end

  class TestCMYKConversions < Minitest::Test
    def setup
      @cmyk = Color::CMYK.from_percentage(10, 20, 30, 40)
    end

    def test_to_cmyk
      assert_equal(@cmyk, @cmyk.to_cmyk)
      assert_kind_of(Color::CMYK, @cmyk.to_cmyk)
    end

    def test_to_grayscale
      gs = @cmyk.to_grayscale
      assert_kind_of(Color::Grayscale, gs)
      assert_in_tolerance(0.4185, gs.g)
    end

    def test_to_hsl
      hsl = @cmyk.to_hsl
      assert_kind_of(Color::HSL, hsl)
      assert_in_tolerance(0.48, hsl.l)
      assert_in_tolerance(0.125, hsl.s)
      assert_in_tolerance(0.08333, hsl.h)
    end

    def test_to_lab
      lab = @cmyk.to_lab
      assert_kind_of(Color::CIELAB, lab)
      assert_in_tolerance(52.35269, lab.l)
      assert_in_tolerance(3.268274, lab.a)
      assert_in_tolerance(10.52531, lab.b)
      assert_equal(Color::CIELAB.from_values(0, 0, 0), Color::CMYK.from_percentage(0, 0, 0, 100).to_lab)
    end

    def test_to_rgb
      rgb_adobe = @cmyk.to_rgb(rgb_method: :adobe)
      assert_kind_of(Color::RGB, rgb_adobe)
      assert_in_tolerance(0.5, rgb_adobe.r)
      assert_in_tolerance(0.4, rgb_adobe.g)
      assert_in_tolerance(0.3, rgb_adobe.b)

      rgb = @cmyk.to_rgb
      assert_kind_of(Color::RGB, rgb)
      assert_in_tolerance(0.54, rgb.r)
      assert_in_tolerance(0.48, rgb.g)
      assert_in_tolerance(0.42, rgb.b)
    end

    def test_to_xyz
      xyz = @cmyk.to_xyz
      assert_kind_of(Color::XYZ, xyz)
      assert_in_tolerance(0.200995, xyz.x)
      assert_in_tolerance(0.204594, xyz.y)
      assert_in_tolerance(0.168249, xyz.z)
      assert_equal(Color::XYZ.from_values(0, 0, 0), Color::CMYK.from_percentage(0, 0, 0, 100).to_xyz)
    end

    def test_to_yiq
      yiq = @cmyk.to_yiq
      assert_kind_of(Color::YIQ, yiq)
      assert_in_tolerance(0.4911, yiq.y)
      assert_in_tolerance(0.05502, yiq.i)
      assert_in_tolerance(0.0, yiq.q)
      assert_equal(Color::YIQ.from_values(0, 0, 0), Color::CMYK.from_percentage(0, 0, 0, 100).to_yiq)
    end

    def test_to_internal
      assert_equal([0.0, 0.0, 0.0, 1.0], Color::CMYK.from_percentage(0, 0, 0, 100).to_internal)
    end
  end
end
