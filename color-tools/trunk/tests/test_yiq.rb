#!/usr/bin/env ruby
#--
# Colour management with Ruby.
#
# Copyright 2005 Austin Ziegler
#   http://rubyforge.org/ruby-pdf/
#
#   Licensed under a MIT-style licence.
#
# $Id: test_yiq.rb 153 2007-02-07 02:28:41Z austin $
#++

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib") if __FILE__ == $0
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'color'

module TestColor
  class TestYIQ < Test::Unit::TestCase
    def setup
      @yiq = Color::YIQ.from_fraction(0.1, 0.2, 0.3)
    end

    def test_brightness
      assert_in_delta(0.1, @yiq.brightness, 1e-4)
    end

    def test_i
      assert_in_delta(0.2, @yiq.i, 1e-4)
    end

    def test_i_equals
      assert_in_delta(0.2, @yiq.i, 1e-4)
      assert_nothing_raised { @yiq.i = 0.5 }
      assert_in_delta(0.5, @yiq.i, 1e-4)
      assert_nothing_raised { @yiq.i = 5 }
      assert_in_delta(1.0, @yiq.i, 1e-4)
      assert_nothing_raised { @yiq.i = -5 }
      assert_in_delta(0.0, @yiq.i, 1e-4)
    end

    def test_q
      assert_in_delta(0.3, @yiq.q, 1e-4)
    end

    def test_q_equals
      assert_in_delta(0.3, @yiq.q, 1e-4)
      assert_nothing_raised { @yiq.q = 0.5 }
      assert_in_delta(0.5, @yiq.q, 1e-4)
      assert_nothing_raised { @yiq.q = 5 }
      assert_in_delta(1.0, @yiq.q, 1e-4)
      assert_nothing_raised { @yiq.q = -5 }
      assert_in_delta(0.0, @yiq.q, 1e-4)
    end

    def test_to_grayscale
      assert_kind_of(Color::GrayScale, @yiq.to_grayscale)
    end

    def test_to_greyscale
      assert_kind_of(Color::GreyScale, @yiq.to_greyscale)
    end

    def test_to_yiq
      assert_equal(@yiq, @yiq.to_yiq)
    end

    def test_y
      assert_in_delta(0.1, @yiq.y, 1e-4)
    end

    def test_y_equals
      assert_in_delta(0.1, @yiq.y, 1e-4)
      assert_nothing_raised { @yiq.y = 0.5 }
      assert_in_delta(0.5, @yiq.y, 1e-4)
      assert_nothing_raised { @yiq.y = 5 }
      assert_in_delta(1.0, @yiq.y, 1e-4)
      assert_nothing_raised { @yiq.y = -5 }
      assert_in_delta(0.0, @yiq.y, 1e-4)
    end
  end
end
