#!/usr/bin/env ruby
#--
# Colour management with Ruby.
#
# Copyright 2005 Austin Ziegler
#   http://rubyforge.org/ruby-pdf/
#
#   Licensed under a MIT-style licence.
#
# $Id: test_cmyk.rb 153 2007-02-07 02:28:41Z austin $
#++

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib") if __FILE__ == $0
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'color'

module TestColor
  class TestCMYK < Test::Unit::TestCase
    def setup
      @cmyk = Color::CMYK.new(10, 20, 30, 40)
    end

    def test_c
      assert_in_delta(0.1, @cmyk.c, 1e-4)
    end

    def test_c_equals
      assert_in_delta(0.1, @cmyk.c, 1e-4)
      assert_nothing_raised { @cmyk.c = 0.2 }
      assert_in_delta(0.2, @cmyk.c, 1e-4)
      assert_nothing_raised { @cmyk.c = 2.0 }
      assert_in_delta(1.0, @cmyk.c, 1e-4)
      assert_nothing_raised { @cmyk.c = -1.0 }
      assert_in_delta(0.0, @cmyk.c, 1e-4)
    end

    def test_html
      assert(@cmyk.html =~ /^#[0-9a-fA-F]{6}/)
    end

    def test_k
      assert_in_delta(0.4, @cmyk.k, 1e-4)
    end

    def test_k_equals
      assert_in_delta(0.4, @cmyk.k, 1e-4)
      assert_nothing_raised { @cmyk.k = 0.2 }
      assert_in_delta(0.2, @cmyk.k, 1e-4)
      assert_nothing_raised { @cmyk.k = 2.0 }
      assert_in_delta(1.0, @cmyk.k, 1e-4)
      assert_nothing_raised { @cmyk.k = -1.0 }
      assert_in_delta(0.0, @cmyk.k, 1e-4)
    end

    def test_m
      assert_in_delta(0.2, @cmyk.m, 1e-4)
    end

    def test_m_equals
      assert_in_delta(0.2, @cmyk.m, 1e-4)
      assert_nothing_raised { @cmyk.m = 0.3 }
      assert_in_delta(0.3, @cmyk.m, 1e-4)
      assert_nothing_raised { @cmyk.m = 2.0 }
      assert_in_delta(1.0, @cmyk.m, 1e-4)
      assert_nothing_raised { @cmyk.m = -1.0 }
      assert_in_delta(0.0, @cmyk.m, 1e-4)
    end

    def test_pdf_fill
      assert_equal("0.100 0.200 0.300 0.400 k", @cmyk.pdf_fill)
    end

    def test_pdf_stroke
      assert_equal("0.100 0.200 0.300 0.400 K", @cmyk.pdf_stroke)
    end

    def test_to_cmyk
      assert(@cmyk.to_cmyk == @cmyk)
    end

    def test_to_grayscale
      assert_kind_of(Color::GrayScale, @cmyk.to_grayscale)
    end

    def test_to_greyscale
      assert_kind_of(Color::GreyScale, @cmyk.to_grayscale)
    end

    def test_to_hsl
      assert_kind_of(Color::HSL, @cmyk.to_hsl)
    end

    def test_to_rgb
      assert_kind_of(Color::RGB, @cmyk.to_rgb(true))
      assert_kind_of(Color::RGB, @cmyk.to_rgb)
    end

    def test_to_yiq
      assert_kind_of(Color::YIQ, @cmyk.to_yiq)
    end

    def test_y
      assert_in_delta(0.3, @cmyk.y, 1e-4)
    end

    def test_y_equals
      assert_in_delta(0.3, @cmyk.y, 1e-4)
      assert_nothing_raised { @cmyk.y = 0.2 }
      assert_in_delta(0.2, @cmyk.y, 1e-4)
      assert_nothing_raised { @cmyk.y = 2.0 }
      assert_in_delta(1.0, @cmyk.y, 1e-4)
      assert_nothing_raised { @cmyk.y = -1.0 }
      assert_in_delta(0.0, @cmyk.y, 1e-4)
    end
  end
end
