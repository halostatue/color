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

    def test_to_yiq
      yiq = @lab.to_yiq
      assert_kind_of(Color::YIQ, yiq)
      assert_in_tolerance(0.096308, yiq.y)
      assert_in_tolerance(0.116326, yiq.i)
      assert_in_tolerance(0.019120, yiq.q)
      assert_equal(Color::YIQ.from_values(0, 0, 0), Color::CIELAB.from_values(0, 0, 0).to_yiq)
    end

    def test_to_internal
      assert_equal([0.0, 0.0, 0.0], Color::CIELAB.from_values(0, 0, 0).to_internal)
    end
  end
end
