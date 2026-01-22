# frozen_string_literal: true

require "color"
require "minitest_helper"

module TestColor
  class TestCielabConversions < Minitest::Test
    def setup
      @lab = Color::CIELAB.from_values(10, 20, 30)
    end

    def test_to_cmyk
      cmyk = @lab.to_cmyk
      assert_kind_of(Color::CMYK, cmyk)
      assert_in_tolerance(0.075185, cmyk.c)
      assert_in_tolerance(0.242168, cmyk.m)
      assert_in_tolerance(0.294516, cmyk.y)
      assert_in_tolerance(0.705484, cmyk.k)
      assert_equal(Color::CMYK.from_percentage(0, 0, 0, 100), Color::CIELAB.from_values(0, 0, 0).to_cmyk)
    end

    def test_to_grayscale
      grayscale = @lab.to_grayscale
      assert_kind_of(Color::Grayscale, grayscale)
      assert_in_tolerance(0.109665, grayscale.g)
      assert_equal(Color::Grayscale.from_fraction(0), Color::CIELAB.from_values(0, 0, 0).to_grayscale)
    end

    def test_to_hsl
      hsl = @lab.to_hsl
      assert_kind_of(Color::HSL, hsl)
      assert_in_tolerance(0.039778, hsl.h)
      assert_in_tolerance(1.0, hsl.s)
      assert_in_tolerance(0.109665, hsl.l)
      assert_equal(Color::HSL.from_values(0, 0, 0), Color::CIELAB.from_values(0, 0, 0).to_hsl)
    end

    def test_to_lab
      assert_equal(@lab, @lab.to_lab)
      assert_kind_of(Color::CIELAB, @lab.to_lab)
    end

    def test_to_rgb
      rgb = @lab.to_rgb
      assert_kind_of(Color::RGB, rgb)
      assert_in_tolerance(0.219331, rgb.r)
      assert_in_tolerance(0.052348, rgb.g)
      assert_in_tolerance(0.0, rgb.b)
      assert_equal(Color::RGB.from_values(0, 0, 0), Color::CIELAB.from_values(0, 0, 0).to_rgb)
    end

    def test_to_xyz
      xyz = @lab.to_xyz
      assert_kind_of(Color::XYZ, xyz)
      assert_in_tolerance(0.017515, xyz.x)
      assert_in_tolerance(0.011260, xyz.y)
      assert_in_tolerance(0.0, xyz.z)
      assert_equal(Color::XYZ.from_values(0, 0, 0), Color::CIELAB.from_values(0, 0, 0).to_xyz)
    end

    # Regression test for https://github.com/halostatue/color/issues/95
    #
    # `Color::CIELAB#to_xyz` branches on whether the lightness L* is greater
    # than `Color::XYZ::EK` (which is 8).
    #
    # A bug calculated an incorrect value if L* was less than `EK`, causing
    # Y to be approximately 900 times larger than expected.
    #
    # This test ensures values like this are handled correctly and return
    # the correct XYZ colour.
    def test_to_xyz_handles_low_lightness
      # This CIELAB colour is almost black. With the bug present, it's
      # converted to an XYZ colour which is bright green.
      lab = Color::CIELAB.from_values(7, 0, 0)

      xyz = lab.to_xyz
      assert_in_tolerance(0.007365, xyz.x)
      assert_in_tolerance(0.007749, xyz.y)
      assert_in_tolerance(0.008437, xyz.z)

      hsl = lab.to_hsl
      assert_equal(hsl.saturation, 0)
    end

    def test_to_yiq
      yiq = @lab.to_yiq
      assert_kind_of(Color::YIQ, yiq)
      assert_in_tolerance(0.096308, yiq.y)
      assert_in_tolerance(0.116326, yiq.i)
      assert_in_tolerance(0.019120, yiq.q)
      assert_equal(Color::YIQ.from_values(0, 0, 0), Color::CIELAB.from_values(0, 0, 0).to_yiq)
    end

    def test_inspect
      assert_equal "CIELAB [10.0000 20.0000 30.0000]", @lab.inspect
    end

    def test_pretty_print
      assert_pretty_inspect "CIELAB\n[10.0000\n  20.0000\n  30.0000]\n", @lab
    end

    def test_to_internal
      assert_equal([0.0, 0.0, 0.0], Color::CIELAB.from_values(0, 0, 0).to_internal)
    end

    def test_from_percentage
      assert_equal(
        Color::CIELAB.from_percentage(100, -30, 30),
        Color::CIELAB.from_values(100, -38.75, 37.75)
      )
      assert_equal(
        Color::CIELAB.from_percentage(l: 100, a: -30, b: 30),
        Color::CIELAB.from_values(100, -38.75, 37.75)
      )
    end

    def test_css
      assert_equal(@lab.css, "lab(10.00% 20.00 30.00)")
      assert_equal(@lab.css(alpha: 40), "lab(10.00% 20.00 30.00 / 40.00)")
    end
  end
end
