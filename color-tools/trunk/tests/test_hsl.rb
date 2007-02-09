#!/usr/bin/env ruby
#--
# Colour management with Ruby.
#
# Copyright 2005 Austin Ziegler
#   http://rubyforge.org/ruby-pdf/
#
#   Licensed under a MIT-style licence.
#
# $Id: test_hsl.rb 153 2007-02-07 02:28:41Z austin $
#++

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib") if __FILE__ == $0
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'color'

module TestColor
  class TestHSL < Test::Unit::TestCase
    def setup
      @hsl = Color::HSL.new(145, 20, 30)
    end

    def brightness
      assert_in_delta(0.3, @hsl.brightness, 1e-4)
    end

    def test_h
      assert_in_delta(0.4027, @hsl.h, 1e-4)
    end

    def test_h_equals
      assert_in_delta(0.4027, @hsl.h, 1e-4)
      assert_nothing_raised { @hsl.h = 0.33 }
      assert_in_delta(0.33, @hsl.h, 1e-4)
      assert_nothing_raised { @hsl.h = 3.3 }
      assert_in_delta(1.0, @hsl.h, 1e-4)
      assert_nothing_raised { @hsl.h = -3.3 }
      assert_in_delta(0.0, @hsl.h, 1e-4)
    end

    def test_html
      assert_equal("#3d5c4a", @hsl.html)
    end

    def test_l
      assert_in_delta(0.3, @hsl.l, 1e-4)
    end

    def test_l_equals
      assert_in_delta(0.3, @hsl.l, 1e-4)
      assert_nothing_raised { @hsl.l = 0.33 }
      assert_in_delta(0.33, @hsl.l, 1e-4)
      assert_nothing_raised { @hsl.l = 3.3 }
      assert_in_delta(1.0, @hsl.l, 1e-4)
      assert_nothing_raised { @hsl.l = -3.3 }
      assert_in_delta(0.0, @hsl.l, 1e-4)
    end

    def test_s
      assert_in_delta(0.2, @hsl.s, 1e-4)
    end

    def test_s_equals
      assert_in_delta(0.2, @hsl.s, 1e-4)
      assert_nothing_raised { @hsl.s = 0.33 }
      assert_in_delta(0.33, @hsl.s, 1e-4)
      assert_nothing_raised { @hsl.s = 3.3 }
      assert_in_delta(1.0, @hsl.s, 1e-4)
      assert_nothing_raised { @hsl.s = -3.3 }
      assert_in_delta(0.0, @hsl.s, 1e-4)
    end

    def test_to_cmyk
      assert_kind_of(Color::CMYK, @hsl.to_cmyk)
    end

    def test_to_grayscale
      assert_kind_of(Color::GrayScale, @hsl.to_grayscale)
    end

    def test_to_greyscale
      assert_kind_of(Color::GreyScale, @hsl.to_greyscale)
    end

    def test_to_rgb
      assert_kind_of(Color::RGB, @hsl.to_rgb)
    end

    def test_to_yiq
      assert_kind_of(Color::YIQ, @hsl.to_yiq)
    end
  end
end
