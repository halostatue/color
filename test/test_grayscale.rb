# frozen_string_literal: true

require "color"
require "minitest_helper"

module TestColor
  class TestGrayscale < Minitest::Test
    def setup
      @gs = Color::Grayscale.from_percentage(33)
    end

    def test_brightness
      assert_in_tolerance(0.33, @gs.brightness)
    end

    def test_darken_by
      assert_in_tolerance(29.7, @gs.darken_by(10).gray)
    end

    def test_g
      assert_in_tolerance(0.33, @gs.g)
      assert_in_tolerance(33, @gs.gray)
      # @gs.gray = 40
      # assert_in_tolerance(0.4, @gs.g)
      # @gs.g = 2.0
      # assert_in_tolerance(100, @gs.gray)
      # @gs.gray = -2.0
      # assert_in_tolerance(0.0, @gs.g)
    end

    def test_css
      assert_equal("#545454", @gs.html)
      assert_equal("rgb(33.00% 33.00% 33.00%)", @gs.css)
      assert_equal("rgb(33.00% 33.00% 33.00% / 1.00)", @gs.css(alpha: 1))
      assert_equal("rgb(33.00% 33.00% 33.00% / 0.20)", @gs.css(alpha: 0.2))
    end

    def test_lighten_by
      assert_in_tolerance(0.363, @gs.lighten_by(10).g)
    end

    def test_inspect
      assert_equal("Grayscale [33.00%]", @gs.inspect)
    end

    def test_pretty_print
      assert_pretty_inspect "Grayscale\n[33.00%]\n", @gs
    end
  end

  class TestGrayscaleConversions < Minitest::Test
    def setup
      @gs = Color::Grayscale.from_percentage(33)
    end

    def test_to_cmyk
      cmyk = @gs.to_cmyk
      assert_kind_of(Color::CMYK, cmyk)
      assert_in_tolerance(0.0, cmyk.c)
      assert_in_tolerance(0.0, cmyk.m)
      assert_in_tolerance(0.0, cmyk.y)
      assert_in_tolerance(0.67, cmyk.k)
      assert_equal(Color::CMYK.from_percentage(0, 0, 0, 100), Color::Grayscale.from_percentage(0).to_cmyk)
    end

    def test_to_grayscale
      assert_equal(@gs, @gs.to_grayscale)
      assert_kind_of(Color::Grayscale, @gs.to_grayscale)
    end

    def test_to_hsl
      hsl = @gs.to_hsl
      assert_kind_of(Color::HSL, hsl)
      assert_in_tolerance(0.0, hsl.h)
      assert_in_tolerance(0.0, hsl.s)
      assert_in_tolerance(0.33, hsl.l)
      assert_equal(Color::HSL.from_values(0, 0, 0), Color::Grayscale.from_percentage(0).to_hsl)
    end

    def test_to_lab
      lab = @gs.to_lab
      assert_kind_of(Color::CIELAB, lab)
      assert_in_tolerance(35.78746, lab.l)
      assert_in_tolerance(0.0031199, lab.a)
      assert_in_tolerance(-0.000639, lab.b)
      assert_equal(Color::CIELAB.from_values(0, 0, 0), Color::Grayscale.from_percentage(0).to_lab)
    end

    def test_to_rgb
      rgb = @gs.to_rgb
      assert_kind_of(Color::RGB, rgb)
      assert_in_tolerance(0.33, rgb.r)
      assert_in_tolerance(0.33, rgb.g)
      assert_in_tolerance(0.33, rgb.b)
      assert_equal(Color::RGB.from_values(0, 0, 0), Color::Grayscale.from_percentage(0).to_rgb)
    end

    def test_to_xyz
      xyz = @gs.to_xyz
      assert_kind_of(Color::XYZ, xyz)
      assert_in_tolerance(0.08457, xyz.x)
      assert_in_tolerance(0.08898, xyz.y)
      assert_in_tolerance(0.09688, xyz.z)
      assert_equal(Color::XYZ.from_values(0, 0, 0), Color::Grayscale.from_percentage(0).to_xyz)
    end

    def test_to_yiq
      yiq = @gs.to_yiq
      assert_kind_of(Color::YIQ, yiq)
      assert_in_tolerance(0.33, yiq.y)
      assert_in_tolerance(0.0, yiq.i)
      assert_in_tolerance(0.0, yiq.q)
      assert_equal(Color::YIQ.from_values(0, 0, 0), Color::Grayscale.from_percentage(0).to_yiq)
    end

    def test_to_internal
      assert_equal([0.0], Color::Grayscale.from_percentage(0).to_internal)
    end
  end
end
