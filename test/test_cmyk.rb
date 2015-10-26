# -*- ruby encoding: utf-8 -*-

require 'color'
require 'minitest_helper'

module TestColor
  class TestCMYK < Minitest::Test
    def setup
      @cmyk = Color::CMYK.new(10, 20, 30, 40)
    end

    def test_cyan
      assert_in_delta(0.1, @cmyk.c, Color::COLOR_TOLERANCE)
      assert_in_delta(10, @cmyk.cyan, Color::COLOR_TOLERANCE)
      @cmyk.cyan = 20
      assert_in_delta(0.2, @cmyk.c, Color::COLOR_TOLERANCE)
      @cmyk.c = 2.0
      assert_in_delta(100, @cmyk.cyan, Color::COLOR_TOLERANCE)
      @cmyk.c = -1.0
      assert_in_delta(0.0, @cmyk.c, Color::COLOR_TOLERANCE)
    end

    def test_magenta
      assert_in_delta(0.2, @cmyk.m, Color::COLOR_TOLERANCE)
      assert_in_delta(20, @cmyk.magenta, Color::COLOR_TOLERANCE)
      @cmyk.magenta = 30
      assert_in_delta(0.3, @cmyk.m, Color::COLOR_TOLERANCE)
      @cmyk.m = 2.0
      assert_in_delta(100, @cmyk.magenta, Color::COLOR_TOLERANCE)
      @cmyk.m = -1.0
      assert_in_delta(0.0, @cmyk.m, Color::COLOR_TOLERANCE)
    end

    def test_yellow
      assert_in_delta(0.3, @cmyk.y, Color::COLOR_TOLERANCE)
      assert_in_delta(30, @cmyk.yellow, Color::COLOR_TOLERANCE)
      @cmyk.yellow = 20
      assert_in_delta(0.2, @cmyk.y, Color::COLOR_TOLERANCE)
      @cmyk.y = 2.0
      assert_in_delta(100, @cmyk.yellow, Color::COLOR_TOLERANCE)
      @cmyk.y = -1.0
      assert_in_delta(0.0, @cmyk.y, Color::COLOR_TOLERANCE)
    end

    def test_black
      assert_in_delta(0.4, @cmyk.k, Color::COLOR_TOLERANCE)
      assert_in_delta(40, @cmyk.black, Color::COLOR_TOLERANCE)
      @cmyk.black = 20
      assert_in_delta(0.2, @cmyk.k, Color::COLOR_TOLERANCE)
      @cmyk.k = 2.0
      assert_in_delta(100, @cmyk.black, Color::COLOR_TOLERANCE)
      @cmyk.k = -1.0
      assert_in_delta(0.0, @cmyk.k, Color::COLOR_TOLERANCE)
    end

    def test_pdf
      assert_equal("0.100 0.200 0.300 0.400 k", @cmyk.pdf_fill)
      assert_equal("0.100 0.200 0.300 0.400 K", @cmyk.pdf_stroke)
    end

    def test_to_cmyk
      assert(@cmyk.to_cmyk == @cmyk)
    end

    def test_to_grayscale
      gs = @cmyk.to_grayscale
      assert_kind_of(Color::GrayScale, gs)
      assert_in_delta(0.4185, gs.g, Color::COLOR_TOLERANCE)
      assert_kind_of(Color::GreyScale, @cmyk.to_greyscale)
    end

    def test_to_hsl
      hsl = @cmyk.to_hsl
      assert_kind_of(Color::HSL, hsl)
      assert_in_delta(0.48, hsl.l, Color::COLOR_TOLERANCE)
      assert_in_delta(0.125, hsl.s, Color::COLOR_TOLERANCE)
      assert_in_delta(0.08333, hsl.h, Color::COLOR_TOLERANCE)
      assert_equal("hsl(30.00, 12.50%, 48.00%)", @cmyk.css_hsl)
      assert_equal("hsla(30.00, 12.50%, 48.00%, 1.00)", @cmyk.css_hsla)
    end

    def test_to_rgb
      rgb = @cmyk.to_rgb(true)
      assert_kind_of(Color::RGB, rgb)
      assert_in_delta(0.5, rgb.r, Color::COLOR_TOLERANCE)
      assert_in_delta(0.4, rgb.g, Color::COLOR_TOLERANCE)
      assert_in_delta(0.3, rgb.b, Color::COLOR_TOLERANCE)

      rgb = @cmyk.to_rgb
      assert_kind_of(Color::RGB, rgb)
      assert_in_delta(0.54, rgb.r, Color::COLOR_TOLERANCE)
      assert_in_delta(0.48, rgb.g, Color::COLOR_TOLERANCE)
      assert_in_delta(0.42, rgb.b, Color::COLOR_TOLERANCE)

      assert_equal("#8a7a6b", @cmyk.html)
      assert_equal("rgb(54.00%, 48.00%, 42.00%)", @cmyk.css_rgb)
      assert_equal("rgba(54.00%, 48.00%, 42.00%, 1.00)", @cmyk.css_rgba)
      assert_equal("rgba(54.00%, 48.00%, 42.00%, 0.20)", @cmyk.css_rgba(0.2))
    end

    def test_inspect
      assert_equal("CMYK [10.00%, 20.00%, 30.00%, 40.00%]", @cmyk.inspect)
    end

    def test_to_yiq
      yiq = @cmyk.to_yiq
      assert_kind_of(Color::YIQ, yiq)
      assert_in_delta(0.4911, yiq.y, Color::COLOR_TOLERANCE)
      assert_in_delta(0.05502, yiq.i, Color::COLOR_TOLERANCE)
      assert_in_delta(0.0, yiq.q, Color::COLOR_TOLERANCE)
    end
  end
end
