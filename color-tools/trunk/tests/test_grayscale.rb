#!/usr/bin/env ruby
#--
# Colour management with Ruby.
#
# Copyright 2005 Austin Ziegler
#   http://rubyforge.org/ruby-pdf/
#
#   Licensed under a MIT-style licence.
#
# $Id: test_grayscale.rb 153 2007-02-07 02:28:41Z austin $
#++

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib") if __FILE__ == $0
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'color'

module TestColor
  class TestGrayScale < Test::Unit::TestCase
    def setup
      @gs = Color::GrayScale.new(33)
    end

    def test_brightness
      assert_in_delta(0.33, @gs.brightness, 1e-4)
    end

    def test_darken_by
      assert_in_delta(0.297, @gs.darken_by(10).g, 1e-4)
    end

    def test_g
      assert_in_delta(0.33, @gs.g, 1e-4)
    end

    def test_g_equals
      assert_in_delta(0.33, @gs.g, 1e-4)
      assert_nothing_raised { @gs.g = 0.4 }
      assert_in_delta(0.4, @gs.g, 1e-4)
      assert_nothing_raised { @gs.g = 2.0 }
      assert_in_delta(1.0, @gs.g, 1e-4)
      assert_nothing_raised { @gs.g = -2.0 }
      assert_in_delta(0.0, @gs.g, 1e-4)
    end

    def test_html
      assert_equal("#545454", @gs.html)
    end

    def test_lighten_by
      assert_in_delta(0.363, @gs.lighten_by(10).g, 1e-4)
    end

    def test_pdf_fill
      assert_equal("0.330 g", @gs.pdf_fill)
    end

    def test_pdf_stroke
      assert_equal("0.330 G", @gs.pdf_stroke)
    end

    def test_to_cmyk
      assert_kind_of(Color::CMYK, @gs.to_cmyk)
    end

    def test_to_grayscale
      assert_equal(@gs, @gs.to_grayscale)
    end

    def test_to_greyscale
      assert_equal(@gs, @gs.to_greyscale)
    end

    def test_to_hsl
      assert_kind_of(Color::HSL, @gs.to_hsl)
    end

    def test_to_rgb
      assert_kind_of(Color::RGB, @gs.to_rgb)
    end

    def test_to_yiq
      assert_kind_of(Color::YIQ, @gs.to_yiq)
    end
  end
end

# Number of errors detected: 2
