# frozen_string_literal: true

require "color"
require "color/rgb/colors"

require "pp"

gem "minitest"
require "minitest/autorun"
require "minitest/focus"

if ENV["STRICT"]
  $VERBOSE = true
  Warning[:deprecated] = true
  require "minitest/error_on_warning"
end

module Minitest::ColorExtensions
  def assert_in_tolerance(expected, actual, msg = nil)
    assert_in_delta expected, actual, Color::TOLERANCE, msg
  end

  def assert_pretty_inspect(expected, object, msg = nil)
    actual = PP.pp(object, +"", 8)

    assert_equal expected, actual, message(msg, nil) { diff expected, actual }
  end

  Minitest::Test.send(:include, self)
end
