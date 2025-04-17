# frozen_string_literal: true

require "color"
require "json"
require "minitest_helper"

module TestColor
  class TestRGB < Minitest::Test
    def test_adjust_brightness
      assert_equal("#1a1aff", Color::RGB::Blue.adjust_brightness(10).html)
      assert_equal("#0000e6", Color::RGB::Blue.adjust_brightness(-10).html)
    end

    def test_adjust_hue
      assert_equal("#6600ff", Color::RGB::Blue.adjust_hue(10).html)
      assert_equal("#0066ff", Color::RGB::Blue.adjust_hue(-10).html)
    end

    def test_adjust_saturation
      assert_equal("#ef9374", Color::RGB::DarkSalmon.adjust_saturation(10).html)
      assert_equal("#e39980", Color::RGB::DarkSalmon.adjust_saturation(-10).html)
    end

    def test_red
      red = Color::RGB::Red
      assert_in_tolerance(1.0, red.r)
      assert_in_tolerance(100, red.red_p)
      assert_in_tolerance(255, red.red)
      assert_in_tolerance(1.0, red.r)
    end

    def test_green
      lime = Color::RGB::Lime
      assert_in_tolerance(1.0, lime.g)
      assert_in_tolerance(100, lime.green_p)
      assert_in_tolerance(255, lime.green)
    end

    def test_blue
      blue = Color::RGB::Blue
      assert_in_tolerance(1.0, blue.b)
      assert_in_tolerance(255, blue.blue)
      assert_in_tolerance(100, blue.blue_p)
    end

    def test_brightness
      assert_in_tolerance(0.0, Color::RGB::Black.brightness)
      assert_in_tolerance(0.5, Color::RGB::Grey50.brightness)
      assert_in_tolerance(1.0, Color::RGB::White.brightness)
    end

    def test_darken_by
      assert_in_tolerance(0.5, Color::RGB::Blue.darken_by(50).b)
    end

    def test_html
      assert_equal("#000000", Color::RGB::Black.html)
      assert_equal(Color::RGB::Black, Color::RGB.from_html("#000000"))
      assert_equal("#0000ff", Color::RGB::Blue.html)
      assert_equal("#00ff00", Color::RGB::Lime.html)
      assert_equal("#ff0000", Color::RGB::Red.html)
      assert_equal("#ffffff", Color::RGB::White.html)
    end

    def test_css
      assert_equal("rgb(0 0 0)", Color::RGB::Black.css)
      assert_equal("rgb(0 0 100.00%)", Color::RGB::Blue.css)
      assert_equal("rgb(0 100.00% 0)", Color::RGB::Lime.css)
      assert_equal("rgb(100.00% 0 0)", Color::RGB::Red.css)
      assert_equal("rgb(100.00% 100.00% 100.00%)", Color::RGB::White.css)
      assert_equal("rgb(0 0 0 / 1.00)", Color::RGB::Black.css(alpha: 1))
      assert_equal("rgb(0 0 100.00% / 1.00)", Color::RGB::Blue.css(alpha: 1))
      assert_equal("rgb(0 100.00% 0 / 1.00)", Color::RGB::Lime.css(alpha: 1))
      assert_equal("rgb(100.00% 0 0 / 1.00)", Color::RGB::Red.css(alpha: 1))
      assert_equal("rgb(100.00% 100.00% 100.00% / 1.00)", Color::RGB::White.css(alpha: 1))
      assert_equal("rgb(100.00% 0 0 / 0.50)", Color::RGB::Red.css(alpha: 0.5))
    end

    def test_lighten_by
      assert_in_tolerance(1.0, Color::RGB::Blue.lighten_by(50).b)
      assert_in_tolerance(0.5, Color::RGB::Blue.lighten_by(50).r)
      assert_in_tolerance(0.5, Color::RGB::Blue.lighten_by(50).g)
    end

    def test_mix_with
      assert_in_tolerance(0.5, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).r)
      assert_in_tolerance(0.0, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).g)
      assert_in_tolerance(0.5, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).b)
      assert_in_tolerance(0.5, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).r)
      assert_in_tolerance(0.0, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).g)
      assert_in_tolerance(0.5, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).b)
    end

    def test_to_cmyk
      assert_kind_of(Color::CMYK, Color::RGB::Black.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(0, 0, 0, 100), Color::RGB::Black.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(0, 0, 100, 0), Color::RGB::Yellow.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(100, 0, 0, 0), Color::RGB::Cyan.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(0, 100, 0, 0), Color::RGB::Magenta.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(0, 100, 100, 0), Color::RGB::Red.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(100, 0, 100, 0), Color::RGB::Lime.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(100, 100, 0, 0), Color::RGB::Blue.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(10.32, 60.52, 10.32, 39.47), Color::RGB::Purple.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(10.90, 59.13, 59.13, 24.39), Color::RGB::Brown.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(0, 63.14, 18.43, 0), Color::RGB::Carnation.to_cmyk)
      assert_equal(Color::CMYK.from_percentage(7.39, 62.69, 62.69, 37.32), Color::RGB::Cayenne.to_cmyk)
    end

    def test_to_grayscale
      assert_kind_of(Color::Grayscale, Color::RGB::Black.to_grayscale)
      assert_equal(Color::Grayscale.from_fraction(0), Color::RGB::Black.to_grayscale)
      assert_equal(Color::Grayscale.from_fraction(0.5), Color::RGB::Yellow.to_grayscale)
      assert_equal(Color::Grayscale.from_fraction(0.5), Color::RGB::Cyan.to_grayscale)
      assert_equal(Color::Grayscale.from_fraction(0.5), Color::RGB::Magenta.to_grayscale)
      assert_equal(Color::Grayscale.from_fraction(0.5), Color::RGB::Red.to_grayscale)
      assert_equal(Color::Grayscale.from_fraction(0.5), Color::RGB::Lime.to_grayscale)
      assert_equal(Color::Grayscale.from_fraction(0.5), Color::RGB::Blue.to_grayscale)
      assert_equal(Color::Grayscale.from_fraction(0.2510), Color::RGB::Purple.to_grayscale)
      assert_equal(Color::Grayscale.from_percentage(40.58), Color::RGB::Brown.to_grayscale)
      assert_equal(Color::Grayscale.from_percentage(68.43), Color::RGB::Carnation.to_grayscale)
      assert_equal(Color::Grayscale.from_percentage(27.65), Color::RGB::Cayenne.to_grayscale)
    end

    def test_to_hsl
      assert_kind_of(Color::HSL, Color::RGB::Black.to_hsl)
      assert_equal(Color::HSL.from_values(0, 0, 0), Color::RGB::Black.to_hsl)
      assert_equal(Color::HSL.from_values(60, 100, 50), Color::RGB::Yellow.to_hsl)
      assert_equal(Color::HSL.from_values(180, 100, 50), Color::RGB::Cyan.to_hsl)
      assert_equal(Color::HSL.from_values(300, 100, 50), Color::RGB::Magenta.to_hsl)
      assert_equal(Color::HSL.from_values(0, 100, 50), Color::RGB::Red.to_hsl)
      assert_equal(Color::HSL.from_values(120, 100, 50), Color::RGB::Lime.to_hsl)
      assert_equal(Color::HSL.from_values(240, 100, 50), Color::RGB::Blue.to_hsl)
      assert_equal(Color::HSL.from_values(300, 100, 25.10), Color::RGB::Purple.to_hsl)
      assert_equal(Color::HSL.from_values(0, 59.42, 40.59), Color::RGB::Brown.to_hsl)
      assert_equal(Color::HSL.from_values(317.5, 100, 68.43), Color::RGB::Carnation.to_hsl)
      assert_equal(Color::HSL.from_values(0, 100, 27.64), Color::RGB::Cayenne.to_hsl)

      # The following tests a bug reported by Jean Krohn on 10 June 2006 where HSL
      # conversion was not quite correct, resulting in a bad round-trip.
      assert_equal("RGB [#008800]", Color::RGB.from_html("#008800").to_hsl.to_rgb.inspect)
      refute_equal("RGB [#002288]", Color::RGB.from_html("#008800").to_hsl.to_rgb.inspect)

      # The following tests a bug reported by Adam Johnson on 29 October
      # 2010.
      hsl = Color::HSL.from_values(262, 67, 42)
      c = Color::RGB.from_fraction(0.34496, 0.1386, 0.701399).to_hsl
      assert_in_tolerance hsl.h, c.h, "Hue"
      assert_in_tolerance hsl.s, c.s, "Saturation"
      assert_in_tolerance hsl.l, c.l, "Luminance"
    end

    def test_to_rgb
      assert_same(Color::RGB::Black, Color::RGB::Black.to_rgb)
    end

    def test_to_yiq
      assert_kind_of(Color::YIQ, Color::RGB::Black.to_yiq)
      assert_equal(Color::YIQ.from_values(0, 0, 0), Color::RGB::Black.to_yiq)
      assert_equal(Color::YIQ.from_values(88.6, 32.1, 0), Color::RGB::Yellow.to_yiq)
      assert_equal(Color::YIQ.from_values(70.1, 0, 0), Color::RGB::Cyan.to_yiq)
      assert_equal(Color::YIQ.from_values(41.3, 27.5, 52.3), Color::RGB::Magenta.to_yiq)
      assert_equal(Color::YIQ.from_values(29.9, 59.6, 21.2), Color::RGB::Red.to_yiq)
      assert_equal(Color::YIQ.from_values(58.7, 0, 0), Color::RGB::Lime.to_yiq)
      assert_equal(Color::YIQ.from_values(11.4, 0, 31.1), Color::RGB::Blue.to_yiq)
      assert_equal(Color::YIQ.from_values(20.73, 13.80, 26.25), Color::RGB::Purple.to_yiq)
      assert_equal(Color::YIQ.from_values(30.89, 28.75, 10.23), Color::RGB::Brown.to_yiq)
      assert_equal(Color::YIQ.from_values(60.84, 23.28, 27.29), Color::RGB::Carnation.to_yiq)
      assert_equal(Color::YIQ.from_values(16.53, 32.96, 11.72), Color::RGB::Cayenne.to_yiq)
    end

    def test_to_lab
      # Luminosity can be an absolute.
      assert_in_tolerance(0.0, Color::RGB::Black.to_lab.l)
      assert_in_tolerance(100.0, Color::RGB::White.to_lab.l)

      # It's not really possible to have absolute
      # numbers here because of how L*a*b* works, but
      # negative/positive comparisons work
      assert(Color::RGB::Green.to_lab.a < 0)
      assert(Color::RGB::Magenta.to_lab.a > 0)
      assert(Color::RGB::Blue.to_lab.b < 0)
      assert(Color::RGB::Yellow.to_lab.b > 0)
    end

    def test_closest_match
      # It should match Blue to Indigo (very simple match)
      match_from = [Color::RGB::Red, Color::RGB::Green, Color::RGB::Blue]
      assert_equal(Color::RGB::Blue, Color::RGB::Indigo.closest_match(match_from))
      # But fails if using the :just_noticeable difference.
      assert_nil(Color::RGB::Indigo.closest_match(match_from, threshold_distance: :just_noticeable))

      # Crimson & Firebrick are visually closer than DarkRed and Firebrick
      # (more precise match)
      match_from += [Color::RGB::DarkRed, Color::RGB::Crimson]
      assert_equal(Color::RGB::Crimson,
        Color::RGB::Firebrick.closest_match(match_from))
      # Specifying a threshold low enough will cause even that match to fail, though.
      assert_nil(Color::RGB::Firebrick.closest_match(match_from, threshold_distance: 8.0))
      # If the match_from list is an empty array, it also returns nil
      assert_nil(Color::RGB::Red.closest_match([]))

      # RGB::Green is 0,128,0, so we'll pick something VERY close to it, visually
      jnd_green = Color::RGB.from_values(3, 132, 3)
      assert_equal(Color::RGB::Green, jnd_green.closest_match(match_from, threshold_distance: :jnd))
      # And then something that's just barely out of the tolerance range
      diff_green = Color::RGB.from_values(9, 142, 9)
      assert_nil(diff_green.closest_match(match_from, threshold_distance: :jnd))
    end

    def test_mean_grayscale
      c1 = Color::RGB.from_values(0x85, 0x80, 0x00)
      c1.max_rgb_as_grayscale
      c1_max = c1.max_rgb_as_grayscale
      c1_result = Color::Grayscale.from_fraction(0x85 / 255.0)

      assert_equal(c1_result, c1_max)
    end

    def test_from_html
      assert_equal("RGB [#333333]", Color::RGB.from_html("#333").inspect)
      assert_equal("RGB [#333333]", Color::RGB.from_html("333").inspect)
      assert_equal("RGB [#555555]", Color::RGB.from_html("#555555").inspect)
      assert_equal("RGB [#555555]", Color::RGB.from_html("555555").inspect)
      assert_raises(ArgumentError) { Color::RGB.from_html("#5555555") }
      assert_raises(ArgumentError) { Color::RGB.from_html("5555555") }
      assert_raises(ArgumentError) { Color::RGB.from_html("#55555") }
      assert_raises(ArgumentError) { Color::RGB.from_html("55555") }
    end

    def test_by_hex
      assert_same(Color::RGB::Cyan, Color::RGB.by_hex("#0ff"))
      assert_same(Color::RGB::Cyan, Color::RGB.by_hex("#00ffff"))
      assert_equal("RGB [#333333]", Color::RGB.by_hex("#333").inspect)
      assert_equal("RGB [#333333]", Color::RGB.by_hex("333").inspect)
      assert_raises(ArgumentError) { Color::RGB.by_hex("5555555") }
      assert_raises(ArgumentError) { Color::RGB.by_hex("#55555") }
    end

    def test_by_name
      assert_same(Color::RGB::Cyan, Color::RGB.by_name("cyan"))

      fetch_error = if RUBY_VERSION < "1.9"
        IndexError
      else
        KeyError
      end

      assert_raises(fetch_error) { Color::RGB.by_name("cyanide") }
      assert_equal(:boom, Color::RGB.by_name("cyanide") { :boom })
    end

    def test_by_css
      assert_same(Color::RGB::Cyan, Color::RGB.by_css("#0ff"))
      assert_same(Color::RGB::Cyan, Color::RGB.by_css("cyan"))
      assert_raises(ArgumentError) { Color::RGB.by_css("cyanide") }
    end

    def test_extract_colors
      assert_equal([Color::RGB::BlanchedAlmond, Color::RGB::Cyan],
        Color::RGB.extract_colors("BlanchedAlmond is a nice shade, but #00ffff is not."))
    end

    def test_inspect
      assert_equal("RGB [#000000]", Color::RGB::Black.inspect)
      assert_equal("RGB [#0000ff]", Color::RGB::Blue.inspect)
      assert_equal("RGB [#00ff00]", Color::RGB::Lime.inspect)
      assert_equal("RGB [#ff0000]", Color::RGB::Red.inspect)
      assert_equal("RGB [#ffffff]", Color::RGB::White.inspect)
    end

    def test_delta_e2000
      # test data:
      # http://www.ece.rochester.edu/~gsharma/ciede2000/
      # http://www.ece.rochester.edu/~gsharma/ciede2000/dataNprograms/CIEDE2000.xls

      # this will also test to_degrees and to_radians by association

      test_data = JSON.parse(File.read("test/fixtures/cielab.json")).map.with_index { |e, i|
        {
          i: i,
          c1: Color::CIELAB.from_values(e["c1"]["L"].to_f, e["c1"]["a"].to_f, e["c1"]["b"].to_f),
          c2: Color::CIELAB.from_values(e["c2"]["L"].to_f, e["c2"]["a"].to_f, e["c2"]["b"].to_f),
          correct_delta: e["∂E2000"].to_f
        }
      }

      test_data.each do |e|
        e => c1:, c2:, correct_delta:

        e2000_c1_c2 = c1.delta_e2000(c2)
        e2000_c2_c1 = c2.delta_e2000(c1)

        assert_in_tolerance e2000_c1_c2, e2000_c2_c1
        assert_in_tolerance e2000_c1_c2, correct_delta
      end
    end

    def test_contrast
      data = [
        [[171, 215, 103], [195, 108, 197], 0.18117],
        [[223, 133, 234], [64, 160, 101], 0.229530],
        [[7, 30, 49], [37, 225, 31], 0.377786],
        [[65, 119, 130], [70, 63, 212], 0.10323],
        [[211, 77, 232], [5, 113, 139], 0.233503],
        [[166, 185, 41], [87, 193, 137], 0.07275],
        [[1, 120, 37], [195, 70, 33], 0.1474640],
        [[99, 206, 21], [228, 204, 155], 0.22611],
        [[15, 18, 41], [90, 202, 208], 0.552434]
      ]

      data.each do |(c1, c2, value)|
        c1 = Color::RGB.from_values(c1[0], c1[1], c1[2])
        c2 = Color::RGB.from_values(c2[0], c2[1], c2[2])

        assert_in_delta(0.0001, c1.contrast(c2), value)
        assert_equal(c1.contrast(c2), c2.contrast(c1))
      end
    end

    # # An RGB color round-tripped through CIELAB should still have more or less the same
    # # RGB values, but this doesn't really work because the color math here is slightly
    # # wrong.
    # def test_to_lab_automated
    #   10.times do |t|
    #     c1 = Color::RGB.from_values(rand(256), rand(256), rand(256))
    #     l1 = c1.to_lab
    #     c2 = l1.to_rgb
    #
    #     assert_in_tolerance(c1.r, c2.r)
    #     assert_in_tolerance(c1.g, c2.g)
    #     assert_in_tolerance(c1.b, c2.b)
    #   end
    # end
  end
end
