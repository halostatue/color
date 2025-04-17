# frozen_string_literal: true

require "color"
require "minitest_helper"

module TestColor
  class TestHSL < Minitest::Test
    def setup
      @hsl = Color::HSL.from_values(145, 20, 30)
    end

    def test_rgb_roundtrip_conversion
      hsl = Color::HSL.from_values(262, 67, 42)
      c = hsl.to_rgb.to_hsl
      assert_in_tolerance hsl.h, c.h, "Hue"
      assert_in_tolerance hsl.s, c.s, "Saturation"
      assert_in_tolerance hsl.l, c.l, "Luminance"
    end

    def test_brightness
      assert_in_tolerance 0.3, @hsl.brightness
    end

    def test_hue
      assert_in_tolerance 0.4027, @hsl.h
      assert_in_tolerance 145, @hsl.hue
      # @hsl.hue = 33
      # assert_in_tolerance 0.09167, @hsl.h
      # @hsl.hue = -33
      # assert_in_tolerance 0.90833, @hsl.h
      # @hsl.h = 3.3
      # assert_in_tolerance 360, @hsl.hue
      # @hsl.h = -3.3
      # assert_in_tolerance 0.0, @hsl.h
      # @hsl.hue = 0
      # @hsl.hue -= 20
      # assert_in_tolerance 340, @hsl.hue
      # @hsl.hue += 45
      # assert_in_tolerance 25, @hsl.hue
    end

    def test_saturation
      assert_in_tolerance 0.2, @hsl.s
      assert_in_tolerance 20, @hsl.saturation
      # @hsl.saturation = 33
      # assert_in_tolerance 0.33, @hsl.s
      # @hsl.s = 3.3
      # assert_in_tolerance 100, @hsl.saturation
      # @hsl.s = -3.3
      # assert_in_tolerance 0.0, @hsl.s
    end

    def test_luminance
      assert_in_tolerance 0.3, @hsl.l
      assert_in_tolerance 30, @hsl.luminosity
      # @hsl.luminosity = 33
      # assert_in_tolerance 0.33, @hsl.l
      # @hsl.l = 3.3
      # assert_in_tolerance 100, @hsl.lightness
      # @hsl.l = -3.3
      # assert_in_tolerance 0.0, @hsl.l
    end

    def test_css
      assert_equal "hsl(145.00deg 20.00% 30.00%)", @hsl.css
      assert_equal "hsl(145.00deg 20.00% 30.00% / 1.00)", @hsl.css(alpha: 1)
    end

    def test_to_cmyk
      cmyk = @hsl.to_cmyk
      assert_kind_of Color::CMYK, cmyk
      assert_in_tolerance 0.3223, cmyk.c
      assert_in_tolerance 0.2023, cmyk.m
      assert_in_tolerance 0.2723, cmyk.y
      assert_in_tolerance 0.4377, cmyk.k
    end

    def test_to_grayscale
      gs = @hsl.to_grayscale
      assert_kind_of Color::Grayscale, gs
      assert_in_tolerance 30, gs.gray
    end

    def test_to_rgb
      rgb = @hsl.to_rgb
      assert_kind_of Color::RGB, rgb
      assert_in_tolerance 0.24, rgb.r
      assert_in_tolerance 0.36, rgb.g
      assert_in_tolerance 0.29, rgb.b

      # The following tests address a bug reported by Jean Krohn on June 6,
      # 2006 and exercise some previously unexercised code in to_rgb.
      assert_equal Color::RGB::Black, Color::HSL.from_values(75, 75, 0)
      assert_equal Color::RGB::White, Color::HSL.from_values(75, 75, 100)
      assert_equal Color::RGB::Gray80, Color::HSL.from_values(75, 0, 80)

      # The following tests a bug reported by Adam Johnson on 29 October
      # 2010.
      rgb = Color::RGB.from_fraction(0.34496, 0.1386, 0.701399)
      c = Color::HSL.from_values(262, 67, 42).to_rgb
      assert_in_tolerance rgb.r, c.r, "Red"
      assert_in_tolerance rgb.g, c.g, "Green"
      assert_in_tolerance rgb.b, c.b, "Blue"
    end

    def test_to_yiq
      yiq = @hsl.to_yiq
      assert_kind_of Color::YIQ, yiq
      assert_in_tolerance 0.3161, yiq.y
      assert_in_tolerance 0.0, yiq.i
      assert_in_tolerance 0.0, yiq.q
    end

    def test_mix_with
      red = Color::RGB::Red.to_hsl
      yellow = Color::RGB::Yellow.to_hsl
      assert_in_tolerance 0, red.hue
      assert_in_tolerance 60, yellow.hue
      ry25 = red.mix_with yellow, 0.25
      assert_in_tolerance 15, ry25.hue
      ry50 = red.mix_with yellow, 0.50
      assert_in_tolerance 30, ry50.hue
      ry75 = red.mix_with yellow, 0.75
      assert_in_tolerance 45, ry75.hue
    end

    def test_inspect
      assert_equal "HSL [145.00deg 20.00% 30.00%]", @hsl.inspect
    end
  end
end
