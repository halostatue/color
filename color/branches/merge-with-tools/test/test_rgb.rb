#!/usr/bin/env ruby
#--
# Color
# Colour management with Ruby
# http://rubyforge.org/projects/color
#   Version 1.4.0
#
# Licensed under a MIT-style licence. See Licence.txt in the main
# distribution for full licensing information.
#
# Copyright (c) 2005 - 2007 Austin Ziegler and Matt Lyon
#
# $Id: test_all.rb 55 2007-02-03 23:29:34Z austin $
#++

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib") if __FILE__ == $0
require 'test/unit'
require 'color'

module TestColor
  class TestRGB < Test::Unit::TestCase
    def test_adjust_brightness
      assert_equal("#1a1aff", Color::RGB::Blue.adjust_brightness(10).html)
      assert_equal("#0000e6", Color::RGB::Blue.adjust_brightness(-10).html)
    end

    def test_adjust_hue
      assert_equal("#6600ff", Color::RGB::Blue.adjust_hue(10).html)
      assert_equal("#0066ff", Color::RGB::Blue.adjust_hue(-10).html)
    end

    def test_adjust_saturation
      assert_equal("#ef9374",
                   Color::RGB::DarkSalmon.adjust_saturation(10).html)
      assert_equal("#e39980",
                   Color::RGB::DarkSalmon.adjust_saturation(-10).html)
    end

    def test_red
      red = Color::RGB::Red.dup
      assert_in_delta(1.0, red.r, Color::COLOR_TOLERANCE)
      assert_in_delta(100, red.red_p, Color::COLOR_TOLERANCE)
      assert_in_delta(255, red.red, Color::COLOR_TOLERANCE)
      assert_in_delta(1.0, red.r, Color::COLOR_TOLERANCE)
      assert_nothing_raised { red.red_p = 33 }
      assert_in_delta(0.33, red.r, Color::COLOR_TOLERANCE)
      assert_nothing_raised { red.red = 330 }
      assert_in_delta(1.0, red.r, Color::COLOR_TOLERANCE)
      assert_nothing_raised { red.r = -3.3 }
      assert_in_delta(0.0, red.r, Color::COLOR_TOLERANCE)
    end

    def test_green
      lime = Color::RGB::Lime.dup
      assert_in_delta(1.0, lime.g, Color::COLOR_TOLERANCE)
      assert_in_delta(100, lime.green_p, Color::COLOR_TOLERANCE)
      assert_in_delta(255, lime.green, Color::COLOR_TOLERANCE)
      assert_nothing_raised { lime.green_p = 33 }
      assert_in_delta(0.33, lime.g, Color::COLOR_TOLERANCE)
      assert_nothing_raised { lime.green = 330 }
      assert_in_delta(1.0, lime.g, Color::COLOR_TOLERANCE)
      assert_nothing_raised { lime.g = -3.3 }
      assert_in_delta(0.0, lime.g, Color::COLOR_TOLERANCE)
    end

    def test_blue
      blue = Color::RGB::Blue.dup
      assert_in_delta(1.0, blue.b, Color::COLOR_TOLERANCE)
      assert_in_delta(255, blue.blue, Color::COLOR_TOLERANCE)
      assert_in_delta(100, blue.blue_p, Color::COLOR_TOLERANCE)
      assert_nothing_raised { blue.blue_p = 33 }
      assert_in_delta(0.33, blue.b, Color::COLOR_TOLERANCE)
      assert_nothing_raised { blue.blue = 330 }
      assert_in_delta(1.0, blue.b, Color::COLOR_TOLERANCE)
      assert_nothing_raised { blue.b = -3.3 }
      assert_in_delta(0.0, blue.b, Color::COLOR_TOLERANCE)
    end

    def test_brightness
      assert_in_delta(0.0, Color::RGB::Black.brightness, Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Grey50.brightness, Color::COLOR_TOLERANCE)
      assert_in_delta(1.0, Color::RGB::White.brightness, Color::COLOR_TOLERANCE)
    end

    def test_darken_by
      assert_in_delta(0.5, Color::RGB::Blue.darken_by(50).b,
                      Color::COLOR_TOLERANCE)
    end

    def test_html
      assert_equal("#000000", Color::RGB::Black.html)
      assert_equal("#0000ff", Color::RGB::Blue.html)
      assert_equal("#00ff00", Color::RGB::Lime.html)
      assert_equal("#ff0000", Color::RGB::Red.html)
      assert_equal("#ffffff", Color::RGB::White.html)

      assert_equal("rgb(0.00%, 0.00%, 0.00%)", Color::RGB::Black.css_rgb)
      assert_equal("rgb(0.00%, 0.00%, 100.00%)", Color::RGB::Blue.css_rgb)
      assert_equal("rgb(0.00%, 100.00%, 0.00%)", Color::RGB::Lime.css_rgb)
      assert_equal("rgb(100.00%, 0.00%, 0.00%)", Color::RGB::Red.css_rgb)
      assert_equal("rgb(100.00%, 100.00%, 100.00%)", Color::RGB::White.css_rgb)

      assert_equal("rgba(0.00%, 0.00%, 0.00%, 1.00)", Color::RGB::Black.css_rgba)
      assert_equal("rgba(0.00%, 0.00%, 100.00%, 1.00)", Color::RGB::Blue.css_rgba)
      assert_equal("rgba(0.00%, 100.00%, 0.00%, 1.00)", Color::RGB::Lime.css_rgba)
      assert_equal("rgba(100.00%, 0.00%, 0.00%, 1.00)", Color::RGB::Red.css_rgba)
      assert_equal("rgba(100.00%, 100.00%, 100.00%, 1.00)",
                   Color::RGB::White.css_rgba)
    end

    def test_lighten_by
      assert_in_delta(1.0, Color::RGB::Blue.lighten_by(50).b,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Blue.lighten_by(50).r,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Blue.lighten_by(50).g,
                      Color::COLOR_TOLERANCE)
    end

    def test_mix_with
      assert_in_delta(0.5, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).r,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.0, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).g,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).b,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).r,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.0, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).g,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).b,
                      Color::COLOR_TOLERANCE)
    end

    def test_pdf_fill
      assert_equal("0.000 0.000 0.000 rg", Color::RGB::Black.pdf_fill)
      assert_equal("0.000 0.000 1.000 rg", Color::RGB::Blue.pdf_fill)
      assert_equal("0.000 1.000 0.000 rg", Color::RGB::Lime.pdf_fill)
      assert_equal("1.000 0.000 0.000 rg", Color::RGB::Red.pdf_fill)
      assert_equal("1.000 1.000 1.000 rg", Color::RGB::White.pdf_fill)
      assert_equal("0.000 0.000 0.000 RG", Color::RGB::Black.pdf_stroke)
      assert_equal("0.000 0.000 1.000 RG", Color::RGB::Blue.pdf_stroke)
      assert_equal("0.000 1.000 0.000 RG", Color::RGB::Lime.pdf_stroke)
      assert_equal("1.000 0.000 0.000 RG", Color::RGB::Red.pdf_stroke)
      assert_equal("1.000 1.000 1.000 RG", Color::RGB::White.pdf_stroke)
    end

    def test_to_cmyk
      assert_kind_of(Color::CMYK, Color::RGB::Black.to_cmyk)
      assert_equal(Color::CMYK.new(0, 0, 0, 100), Color::RGB::Black.to_cmyk)
      assert_equal(Color::CMYK.new(0, 0, 100, 0),
                   Color::RGB::Yellow.to_cmyk)
      assert_equal(Color::CMYK.new(100, 0, 0, 0), Color::RGB::Cyan.to_cmyk)
      assert_equal(Color::CMYK.new(0, 100, 0, 0),
                   Color::RGB::Magenta.to_cmyk)
      assert_equal(Color::CMYK.new(0, 100, 100, 0), Color::RGB::Red.to_cmyk)
      assert_equal(Color::CMYK.new(100, 0, 100, 0),
                   Color::RGB::Lime.to_cmyk)
      assert_equal(Color::CMYK.new(100, 100, 0, 0),
                   Color::RGB::Blue.to_cmyk)
      assert_equal(Color::CMYK.new(10.32, 60.52, 10.32, 39.47),
                   Color::RGB::Purple.to_cmyk)
      assert_equal(Color::CMYK.new(10.90, 59.13, 59.13, 24.39),
                   Color::RGB::Brown.to_cmyk)
      assert_equal(Color::CMYK.new(0, 63.14, 18.43, 0),
                   Color::RGB::Carnation.to_cmyk)
      assert_equal(Color::CMYK.new(7.39, 62.69, 62.69, 37.32),
                   Color::RGB::Cayenne.to_cmyk)
    end

    def test_to_grayscale
      assert_kind_of(Color::GrayScale, Color::RGB::Black.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0),
                   Color::RGB::Black.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Yellow.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Cyan.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Magenta.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Red.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Lime.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Blue.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.2510),
                   Color::RGB::Purple.to_grayscale)
      assert_equal(Color::GrayScale.new(40.58),
                   Color::RGB::Brown.to_grayscale)
      assert_equal(Color::GrayScale.new(68.43),
                   Color::RGB::Carnation.to_grayscale)
      assert_equal(Color::GrayScale.new(27.65),
                   Color::RGB::Cayenne.to_grayscale)
    end

    def test_to_hsl
      assert_kind_of(Color::HSL, Color::RGB::Black.to_hsl)
      assert_equal(Color::HSL.new, Color::RGB::Black.to_hsl)
      assert_equal(Color::HSL.new(60, 100, 50), Color::RGB::Yellow.to_hsl)
      assert_equal(Color::HSL.new(180, 100, 50), Color::RGB::Cyan.to_hsl)
      assert_equal(Color::HSL.new(300, 100, 50), Color::RGB::Magenta.to_hsl)
      assert_equal(Color::HSL.new(0, 100, 50), Color::RGB::Red.to_hsl)
      assert_equal(Color::HSL.new(120, 100, 50), Color::RGB::Lime.to_hsl)
      assert_equal(Color::HSL.new(240, 100, 50), Color::RGB::Blue.to_hsl)
      assert_equal(Color::HSL.new(300, 100, 25.10),
                   Color::RGB::Purple.to_hsl)
      assert_equal(Color::HSL.new(0, 59.42, 40.59),
                   Color::RGB::Brown.to_hsl)
      assert_equal(Color::HSL.new(317.5, 100, 68.43),
                   Color::RGB::Carnation.to_hsl)
      assert_equal(Color::HSL.new(0, 100, 27.64),
                   Color::RGB::Cayenne.to_hsl)

      assert_equal("hsl(0.00, 0.00%, 0.00%)", Color::RGB::Black.css_hsl)
      assert_equal("hsl(60.00, 100.00%, 50.00%)",
                   Color::RGB::Yellow.css_hsl)
      assert_equal("hsl(180.00, 100.00%, 50.00%)", Color::RGB::Cyan.css_hsl)
      assert_equal("hsl(300.00, 100.00%, 50.00%)",
                   Color::RGB::Magenta.css_hsl)
      assert_equal("hsl(0.00, 100.00%, 50.00%)", Color::RGB::Red.css_hsl)
      assert_equal("hsl(120.00, 100.00%, 50.00%)", Color::RGB::Lime.css_hsl)
      assert_equal("hsl(240.00, 100.00%, 50.00%)", Color::RGB::Blue.css_hsl)
      assert_equal("hsl(300.00, 100.00%, 25.10%)",
                   Color::RGB::Purple.css_hsl)
      assert_equal("hsl(0.00, 59.42%, 40.59%)", Color::RGB::Brown.css_hsl)
      assert_equal("hsl(317.52, 100.00%, 68.43%)",
                   Color::RGB::Carnation.css_hsl)
      assert_equal("hsl(0.00, 100.00%, 27.65%)", Color::RGB::Cayenne.css_hsl)

      assert_equal("hsla(0.00, 0.00%, 0.00%, 1.00)",
                   Color::RGB::Black.css_hsla)
      assert_equal("hsla(60.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Yellow.css_hsla)
      assert_equal("hsla(180.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Cyan.css_hsla)
      assert_equal("hsla(300.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Magenta.css_hsla)
      assert_equal("hsla(0.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Red.css_hsla)
      assert_equal("hsla(120.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Lime.css_hsla)
      assert_equal("hsla(240.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Blue.css_hsla)
      assert_equal("hsla(300.00, 100.00%, 25.10%, 1.00)",
                   Color::RGB::Purple.css_hsla)
      assert_equal("hsla(0.00, 59.42%, 40.59%, 1.00)",
                   Color::RGB::Brown.css_hsla)
      assert_equal("hsla(317.52, 100.00%, 68.43%, 1.00)",
                   Color::RGB::Carnation.css_hsla)
      assert_equal("hsla(0.00, 100.00%, 27.65%, 1.00)",
                   Color::RGB::Cayenne.css_hsla)
    end

    def test_to_rgb
      assert_equal(Color::RGB::Black, Color::RGB::Black.to_rgb)
    end

    def test_to_yiq
      assert_kind_of(Color::YIQ, Color::RGB::Black.to_yiq)
      assert_equal(Color::YIQ.new, Color::RGB::Black.to_yiq)
      assert_equal(Color::YIQ.new(88.6, 32.1, 0), Color::RGB::Yellow.to_yiq)
      assert_equal(Color::YIQ.new(70.1, 0, 0), Color::RGB::Cyan.to_yiq)
      assert_equal(Color::YIQ.new(41.3, 27.5, 52.3),
                   Color::RGB::Magenta.to_yiq)
      assert_equal(Color::YIQ.new(29.9, 59.6, 21.2), Color::RGB::Red.to_yiq)
      assert_equal(Color::YIQ.new(58.7, 0, 0), Color::RGB::Lime.to_yiq)
      assert_equal(Color::YIQ.new(11.4, 0, 31.1), Color::RGB::Blue.to_yiq)
      assert_equal(Color::YIQ.new(20.73, 13.80, 26.25),
                   Color::RGB::Purple.to_yiq)
      assert_equal(Color::YIQ.new(30.89, 28.75, 10.23),
                   Color::RGB::Brown.to_yiq)
      assert_equal(Color::YIQ.new(60.84, 23.28, 27.29),
                   Color::RGB::Carnation.to_yiq)
      assert_equal(Color::YIQ.new(16.53, 32.96, 11.72),
                   Color::RGB::Cayenne.to_yiq)
    end
  end
end
