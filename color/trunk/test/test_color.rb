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
require 'color/css'

module TestColor
  class TestColor < Test::Unit::TestCase
    def setup
      Kernel.module_eval do
        alias old_warn warn

        def warn(message)
          $last_warn = message
        end
      end
    end

    def teardown
      Kernel.module_eval do
        undef warn
        alias warn old_warn
        undef old_warn
      end
    end

    def test_const
      $last_warn = nil
      assert_equal(Color::RGB::AliceBlue, Color::AliceBlue)
      assert_equal("Color::AliceBlue has been deprecated. Use Color::RGB::AliceBlue instead.", $last_warn)

      $last_warn = nil # Do this twice to make sure it always happens...
      assert(Color::AliceBlue)
      assert_equal("Color::AliceBlue has been deprecated. Use Color::RGB::AliceBlue instead.", $last_warn)

      $last_warn = nil
      assert_equal(Color::COLOR_VERSION, Color::VERSION)
      assert_equal("Color::VERSION has been deprecated. Use Color::COLOR_VERSION instead.", $last_warn)

      $last_warn = nil
      assert_equal(Color::COLOR_VERSION, Color::COLOR_TOOLS_VERSION)
      assert_equal("Color::COLOR_TOOLS_VERSION has been deprecated. Use Color::COLOR_VERSION instead.", $last_warn)

      $last_warn = nil
      assert(Color::COLOR_VERSION)
      assert_nil($last_warn)
      assert(Color::COLOR_EPSILON)
      assert_nil($last_warn)

      assert_raises(NameError) { assert(Color::MISSING_VALUE) }
    end

    def test_new
      $last_warn = nil
      c = Color.new("#fff")
      assert_kind_of(Color::HSL, c)
      assert_equal(Color::RGB::White.to_hsl, c)
      assert_equal("Color.new has been deprecated. Use Color::RGB.new instead.", $last_warn)

      $last_warn = nil
      c = Color.new([0, 0, 0])
      assert_kind_of(Color::HSL, c)
      assert_equal(Color::RGB::Black.to_hsl, c)
      assert_equal("Color.new has been deprecated. Use Color::RGB.new instead.", $last_warn)

      $last_warn = nil
      c = Color.new([10, 20, 30], :hsl)
      assert_kind_of(Color::HSL, c)
      assert_equal(Color::HSL.new(10, 20, 30), c)
      assert_equal("Color.new has been deprecated. Use Color::HSL.new instead.", $last_warn)

      $last_warn = nil
      c = Color.new([10, 20, 30, 40], :cmyk)
      assert_kind_of(Color::HSL, c)
      assert_equal(Color::CMYK.new(10, 20, 30, 40).to_hsl, c)
      assert_equal("Color.new has been deprecated. Use Color::CMYK.new instead.", $last_warn)
    end
  end
end
