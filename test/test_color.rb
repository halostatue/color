# -*- ruby encoding: utf-8 -*-

require "color"
require "minitest_helper"

module TestColor
  class TestColor < Minitest::Test
    def test_const
      assert_raises(NameError) { Color::AliceBlue }
      assert_raises(NameError) { Color::VERSION }
      assert_raises(NameError) { Color::COLOR_TOOLS_VERSION }
    end

    def test_equivalent
      assert Color.equivalent?(Color::RGB::Red, Color::HSL.new(0, 100, 50))
      refute Color.equivalent?(Color::RGB::Red, nil)
      refute Color.equivalent?(nil, Color::RGB::Red)
    end

    def test_normalize
      (1..10).each do |i|
        assert_equal(0.0, Color.normalize(-7 * i))
        assert_equal(0.0, Color.normalize(-7 / i))
        assert_equal(0.0, Color.normalize(0 - i))
        assert_equal(1.0, Color.normalize(255 + i))
        assert_equal(1.0, Color.normalize(256 * i))
        assert_equal(1.0, Color.normalize(65536 / i))
      end
      (0..255).each do |i|
        assert_in_delta(i / 255.0, Color.normalize(i / 255.0),
          1e-2)
      end
    end

    def test_normalize_range
      assert_equal(0, Color.normalize_8bit(-1))
      assert_equal(0, Color.normalize_8bit(0))
      assert_equal(127, Color.normalize_8bit(127))
      assert_equal(172, Color.normalize_8bit(172))
      assert_equal(255, Color.normalize_8bit(255))
      assert_equal(255, Color.normalize_8bit(256))

      assert_equal(0, Color.normalize_16bit(-1))
      assert_equal(0, Color.normalize_16bit(0))
      assert_equal(127, Color.normalize_16bit(127))
      assert_equal(172, Color.normalize_16bit(172))
      assert_equal(255, Color.normalize_16bit(255))
      assert_equal(256, Color.normalize_16bit(256))
      assert_equal(65535, Color.normalize_16bit(65535))
      assert_equal(65535, Color.normalize_16bit(66536))

      assert_equal(-100, Color.normalize_to_range(-101, -100..100))
      assert_equal(-100, Color.normalize_to_range(-100.5, -100..100))
      assert_equal(-100, Color.normalize_to_range(-100, -100..100))
      assert_equal(-100, Color.normalize_to_range(-100.0, -100..100))
      assert_equal(-99.5, Color.normalize_to_range(-99.5, -100..100))
      assert_equal(-50, Color.normalize_to_range(-50, -100..100))
      assert_equal(-50.5, Color.normalize_to_range(-50.5, -100..100))
      assert_equal(0, Color.normalize_to_range(0, -100..100))
      assert_equal(50, Color.normalize_to_range(50, -100..100))
      assert_equal(50.5, Color.normalize_to_range(50.5, -100..100))
      assert_equal(99, Color.normalize_to_range(99, -100..100))
      assert_equal(99.5, Color.normalize_to_range(99.5, -100..100))
      assert_equal(100, Color.normalize_to_range(100, -100..100))
      assert_equal(100, Color.normalize_to_range(100.0, -100..100))
      assert_equal(100, Color.normalize_to_range(100.5, -100..100))
      assert_equal(100, Color.normalize_to_range(101, -100..100))
    end

    def test_new
      assert_raises(NoMethodError) { Color.new("#fff") }
      assert_raises(NoMethodError) { Color.new([0, 0, 0]) }
      assert_raises(NoMethodError) { Color.new([10, 20, 30], :hsl) }
      assert_raises(NoMethodError) { Color.new([10, 20, 30, 40], :cmyk) }
    end
  end
end
