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
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
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

    def test_b
      assert_in_delta(1.0, Color::RGB::Blue.b, 1e-4)
    end

    def test_b_equals
      b = Color::RGB::Blue.dup
      assert_in_delta(1.0, b.b, 1e-4)
      assert_nothing_raised { b.b = 0.33 }
      assert_in_delta(0.33, b.b, 1e-4)
      assert_nothing_raised { b.b = 3.3 }
      assert_in_delta(1.0, b.b, 1e-4)
      assert_nothing_raised { b.b = -3.3 }
      assert_in_delta(0.0, b.b, 1e-4)
    end

    def test_brightness
      assert_in_delta(0.0, Color::RGB::Black.brightness, 1e-4)
      assert_in_delta(0.5, Color::RGB::Grey50.brightness, 1e-4)
      assert_in_delta(1.0, Color::RGB::White.brightness, 1e-4)
    end

    def test_darken_by
      assert_in_delta(0.5, Color::RGB::Blue.darken_by(50).b, 1e-4)
    end

    def test_g
      assert_in_delta(1.0, Color::RGB::Lime.g, 1e-4)
    end

    def test_g_equals
      g = Color::RGB::Lime.dup
      assert_in_delta(1.0, g.g, 1e-4)
      assert_nothing_raised { g.g = 0.33 }
      assert_in_delta(0.33, g.g, 1e-4)
      assert_nothing_raised { g.g = 3.3 }
      assert_in_delta(1.0, g.g, 1e-4)
      assert_nothing_raised { g.g = -3.3 }
      assert_in_delta(0.0, g.g, 1e-4)
    end

    def test_html
      assert_equal("#000000", Color::RGB::Black.html)
      assert_equal("#0000ff", Color::RGB::Blue.html)
      assert_equal("#00ff00", Color::RGB::Lime.html)
      assert_equal("#ff0000", Color::RGB::Red.html)
      assert_equal("#ffffff", Color::RGB::White.html)
    end

    def test_lighten_by
      assert_in_delta(1.0, Color::RGB::Blue.lighten_by(50).b, 1e-4)
      assert_in_delta(0.5, Color::RGB::Blue.lighten_by(50).r, 1e-4)
      assert_in_delta(0.5, Color::RGB::Blue.lighten_by(50).g, 1e-4)
    end

    def test_mix_with
      assert_in_delta(0.5, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).r,
                      1e-4)
      assert_in_delta(0.0, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).g,
                      1e-4)
      assert_in_delta(0.5, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).b,
                      1e-4)
      assert_in_delta(0.5, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).r,
                      1e-4)
      assert_in_delta(0.0, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).g,
                      1e-4)
      assert_in_delta(0.5, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).b,
                      1e-4)
    end

    def test_pdf_fill
      assert_equal("0.000 0.000 0.000 rg", Color::RGB::Black.pdf_fill)
      assert_equal("0.000 0.000 1.000 rg", Color::RGB::Blue.pdf_fill)
      assert_equal("0.000 1.000 0.000 rg", Color::RGB::Lime.pdf_fill)
      assert_equal("1.000 0.000 0.000 rg", Color::RGB::Red.pdf_fill)
      assert_equal("1.000 1.000 1.000 rg", Color::RGB::White.pdf_fill)
    end

    def test_pdf_stroke
      assert_equal("0.000 0.000 0.000 RG", Color::RGB::Black.pdf_stroke)
      assert_equal("0.000 0.000 1.000 RG", Color::RGB::Blue.pdf_stroke)
      assert_equal("0.000 1.000 0.000 RG", Color::RGB::Lime.pdf_stroke)
      assert_equal("1.000 0.000 0.000 RG", Color::RGB::Red.pdf_stroke)
      assert_equal("1.000 1.000 1.000 RG", Color::RGB::White.pdf_stroke)
    end

    def test_r
      assert_in_delta(1.0, Color::RGB::Red.r, 1e-4)
    end

    def test_r_equals
      r = Color::RGB::Red.dup
      assert_in_delta(1.0, r.r, 1e-4)
      assert_nothing_raised { r.r = 0.33 }
      assert_in_delta(0.33, r.r, 1e-4)
      assert_nothing_raised { r.r = 3.3 }
      assert_in_delta(1.0, r.r, 1e-4)
      assert_nothing_raised { r.r = -3.3 }
      assert_in_delta(0.0, r.r, 1e-4)
    end

    def test_to_cmyk
      assert_kind_of(Color::CMYK, Color::RGB::Black.to_cmyk)
    end

    def test_to_grayscale
      assert_kind_of(Color::GrayScale, Color::RGB::Black.to_grayscale)
    end

    def test_to_greyscale
      assert_kind_of(Color::GreyScale, Color::RGB::Black.to_greyscale)
    end

    def test_to_hsl
      assert_kind_of(Color::HSL, Color::RGB::Black.to_hsl)
    end

    def test_to_rgb
      assert_equal(Color::RGB::Black, Color::RGB::Black.to_rgb)
    end

    def test_to_yiq
      assert_kind_of(Color::YIQ, Color::RGB::Black.to_yiq)
    end
  end
end
