# frozen_string_literal: true

require "color"
require "minitest_helper"

module TestColor
  class TestColor < Minitest::Test
    def setup
      @subject = Object.new.extend(Color)
    end

    # def test_equivalent
    #   assert Color.equivalent?(Color::RGB::Red, Color::HSL.from_values(0, 100, 50))
    #   refute Color.equivalent?(Color::RGB::Red, nil)
    #   refute Color.equivalent?(nil, Color::RGB::Red)
    # end

    def test_normalize
      normalize = @subject.method(:normalize)

      (1..10).each do |i|
        assert_equal(0.0, normalize.call(-7 * i))
        assert_equal(0.0, normalize.call(-7 / i))
        assert_equal(0.0, normalize.call(0 - i))
        assert_equal(1.0, normalize.call(255 + i))
        assert_equal(1.0, normalize.call(256 * i))
        assert_equal(1.0, normalize.call(65536 / i))
      end

      (0..255).each do |i|
        assert_in_delta(i / 255.0, normalize.call(i / 255.0), 1e-2)
      end
    end

    def test_normalize_byte
      normalize_byte = @subject.method(:normalize_byte)

      assert_equal(0, normalize_byte.call(-1))
      assert_equal(0, normalize_byte.call(0))
      assert_equal(127, normalize_byte.call(127))
      assert_equal(172, normalize_byte.call(172))
      assert_equal(255, normalize_byte.call(255))
      assert_equal(255, normalize_byte.call(256))
    end

    def test_normalize_word
      normalize_word = @subject.method(:normalize_word)

      assert_equal(0, normalize_word.call(-1))
      assert_equal(0, normalize_word.call(0))
      assert_equal(127, normalize_word.call(127))
      assert_equal(172, normalize_word.call(172))
      assert_equal(255, normalize_word.call(255))
      assert_equal(256, normalize_word.call(256))
      assert_equal(65535, normalize_word.call(65535))
      assert_equal(65535, normalize_word.call(66536))
    end

    def test_normalize_range
      normalize_to_range = @subject.method(:normalize_to_range)

      assert_equal(-100, normalize_to_range.call(-101, -100..100))
      assert_equal(-100, normalize_to_range.call(-100.5, -100..100))
      assert_equal(-100, normalize_to_range.call(-100, -100..100))
      assert_equal(-100, normalize_to_range.call(-100.0, -100..100))
      assert_equal(-99.5, normalize_to_range.call(-99.5, -100..100))
      assert_equal(-50, normalize_to_range.call(-50, -100..100))
      assert_equal(-50.5, normalize_to_range.call(-50.5, -100..100))
      assert_equal(0, normalize_to_range.call(0, -100..100))
      assert_equal(50, normalize_to_range.call(50, -100..100))
      assert_equal(50.5, normalize_to_range.call(50.5, -100..100))
      assert_equal(99, normalize_to_range.call(99, -100..100))
      assert_equal(99.5, normalize_to_range.call(99.5, -100..100))
      assert_equal(100, normalize_to_range.call(100, -100..100))
      assert_equal(100, normalize_to_range.call(100.0, -100..100))
      assert_equal(100, normalize_to_range.call(100.5, -100..100))
      assert_equal(100, normalize_to_range.call(101, -100..100))
    end
  end
end
