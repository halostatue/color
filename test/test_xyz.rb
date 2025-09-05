# frozen_string_literal: true

require "color"
require "minitest_helper"

module TestColor
  class TestXYZConversions < Minitest::Test
    def setup
      @xyz = Color::XYZ.from_values(0.1, 0.2, 0.3)
    end

    def test_to_cmyk
      cmyk = @xyz.to_cmyk
      assert_kind_of(Color::CMYK, cmyk)
      assert_in_tolerance(0.062775, cmyk.c)
      assert_in_tolerance(0.025215, cmyk.m)
      assert_in_tolerance(0.026358, cmyk.y)
      assert_in_tolerance(0.937225, cmyk.k)
      assert_equal(Color::CMYK.from_percentage(0, 0, 0, 100), Color::XYZ.from_values(0, 0, 0).to_cmyk)
    end

    def test_to_grayscale
      grayscale = @xyz.to_grayscale
      assert_kind_of(Color::Grayscale, grayscale)
      assert_in_tolerance(0.002, grayscale.g)
      assert_equal(Color::Grayscale.from_fraction(0), Color::XYZ.from_values(0, 0, 0).to_grayscale)
    end

    def test_to_hsl
      hsl = @xyz.to_hsl
      assert_kind_of(Color::HSL, hsl)
      assert_in_tolerance(0.4949275, hsl.h)
      assert_in_tolerance(1.0, hsl.s)
      assert_in_tolerance(0.01878, hsl.l)
      assert_equal(Color::HSL.from_values(0, 0, 0), Color::XYZ.from_values(0, 0, 0).to_hsl)
    end

    def test_to_lab
      lab = @xyz.to_lab
      assert_kind_of(Color::CIELAB, lab)
      assert_in_tolerance(1.806593, lab.l)
      assert_in_tolerance(-3.69045, lab.a)
      assert_in_tolerance(-1.17633, lab.b)
      assert_equal(Color::CIELAB.from_values(0, 0, 0), Color::XYZ.from_values(0, 0, 0).to_lab)
    end

    def test_to_rgb
      rgb = @xyz.to_rgb
      assert_kind_of(Color::RGB, rgb)
      assert_in_tolerance(0.0, rgb.r)
      assert_in_tolerance(0.03756, rgb.g)
      assert_in_tolerance(0.036417, rgb.b)
      assert_equal(Color::RGB.from_values(0, 0, 0), Color::XYZ.from_values(0, 0, 0).to_rgb)
    end

    def test_to_xyz
      assert_equal(@xyz, @xyz.to_xyz)
      assert_kind_of(Color::XYZ, @xyz.to_xyz)
    end

    def test_to_yiq
      yiq = @xyz.to_yiq
      assert_kind_of(Color::YIQ, yiq)
      assert_in_tolerance(0.026199, yiq.y)
      assert_in_tolerance(0.0, yiq.i)
      assert_in_tolerance(0.0, yiq.q)
      assert_equal(Color::YIQ.from_values(0, 0, 0), Color::XYZ.from_values(0, 0, 0).to_yiq)
    end

    def test_to_internal
      assert_equal([0.0, 0.0, 0.0], Color::XYZ.from_values(0, 0, 0).to_internal)
    end
  end
end
