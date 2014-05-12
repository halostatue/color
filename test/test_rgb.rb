# -*- ruby encoding: utf-8 -*-

require 'color'
require 'minitest_helper'

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
      assert_equal("#ef9374",
                   Color::RGB::DarkSalmon.adjust_saturation(10).html)
      assert_equal("#e39980",
                   Color::RGB::DarkSalmon.adjust_saturation(-10).html)
    end

    def test_red
      red = Color::RGB::Red.dup
      assert_in_delta(1.0, red.r, Color::COLOR_TOLERANCE)
      assert_in_delta(100, red.red_p, Color::COLOR_TOLERANCE)
      assert_in_delta(255, red.red, Color::COLOR_TOLERANCE)
      assert_in_delta(1.0, red.r, Color::COLOR_TOLERANCE)
      red.red_p = 33
      assert_in_delta(0.33, red.r, Color::COLOR_TOLERANCE)
      red.red = 330
      assert_in_delta(1.0, red.r, Color::COLOR_TOLERANCE)
      red.r = -3.3
      assert_in_delta(0.0, red.r, Color::COLOR_TOLERANCE)
    end

    def test_green
      lime = Color::RGB::Lime.dup
      assert_in_delta(1.0, lime.g, Color::COLOR_TOLERANCE)
      assert_in_delta(100, lime.green_p, Color::COLOR_TOLERANCE)
      assert_in_delta(255, lime.green, Color::COLOR_TOLERANCE)
      lime.green_p = 33
      assert_in_delta(0.33, lime.g, Color::COLOR_TOLERANCE)
      lime.green = 330
      assert_in_delta(1.0, lime.g, Color::COLOR_TOLERANCE)
      lime.g = -3.3
      assert_in_delta(0.0, lime.g, Color::COLOR_TOLERANCE)
    end

    def test_blue
      blue = Color::RGB::Blue.dup
      assert_in_delta(1.0, blue.b, Color::COLOR_TOLERANCE)
      assert_in_delta(255, blue.blue, Color::COLOR_TOLERANCE)
      assert_in_delta(100, blue.blue_p, Color::COLOR_TOLERANCE)
      blue.blue_p = 33
      assert_in_delta(0.33, blue.b, Color::COLOR_TOLERANCE)
      blue.blue = 330
      assert_in_delta(1.0, blue.b, Color::COLOR_TOLERANCE)
      blue.b = -3.3
      assert_in_delta(0.0, blue.b, Color::COLOR_TOLERANCE)
    end

    def test_brightness
      assert_in_delta(0.0, Color::RGB::Black.brightness, Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Grey50.brightness, Color::COLOR_TOLERANCE)
      assert_in_delta(1.0, Color::RGB::White.brightness, Color::COLOR_TOLERANCE)
    end

    def test_darken_by
      assert_in_delta(0.5, Color::RGB::Blue.darken_by(50).b,
                      Color::COLOR_TOLERANCE)
    end

    def test_html
      assert_equal("#000000", Color::RGB::Black.html)
      assert_equal(Color::RGB::Black, Color::RGB.from_html("#000000"))
      assert_equal("#0000ff", Color::RGB::Blue.html)
      assert_equal("#00ff00", Color::RGB::Lime.html)
      assert_equal("#ff0000", Color::RGB::Red.html)
      assert_equal("#ffffff", Color::RGB::White.html)

      assert_equal("rgb(0.00%, 0.00%, 0.00%)", Color::RGB::Black.css_rgb)
      assert_equal("rgb(0.00%, 0.00%, 100.00%)", Color::RGB::Blue.css_rgb)
      assert_equal("rgb(0.00%, 100.00%, 0.00%)", Color::RGB::Lime.css_rgb)
      assert_equal("rgb(100.00%, 0.00%, 0.00%)", Color::RGB::Red.css_rgb)
      assert_equal("rgb(100.00%, 100.00%, 100.00%)", Color::RGB::White.css_rgb)

      assert_equal("rgba(0.00%, 0.00%, 0.00%, 1.00)", Color::RGB::Black.css_rgba)
      assert_equal("rgba(0.00%, 0.00%, 100.00%, 1.00)", Color::RGB::Blue.css_rgba)
      assert_equal("rgba(0.00%, 100.00%, 0.00%, 1.00)", Color::RGB::Lime.css_rgba)
      assert_equal("rgba(100.00%, 0.00%, 0.00%, 1.00)", Color::RGB::Red.css_rgba)
      assert_equal("rgba(100.00%, 100.00%, 100.00%, 1.00)",
                   Color::RGB::White.css_rgba)
    end

    def test_lighten_by
      assert_in_delta(1.0, Color::RGB::Blue.lighten_by(50).b,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Blue.lighten_by(50).r,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Blue.lighten_by(50).g,
                      Color::COLOR_TOLERANCE)
    end

    def test_mix_with
      assert_in_delta(0.5, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).r,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.0, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).g,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Red.mix_with(Color::RGB::Blue, 50).b,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).r,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.0, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).g,
                      Color::COLOR_TOLERANCE)
      assert_in_delta(0.5, Color::RGB::Blue.mix_with(Color::RGB::Red, 50).b,
                      Color::COLOR_TOLERANCE)
    end

    def test_pdf_fill
      assert_equal("0.000 0.000 0.000 rg", Color::RGB::Black.pdf_fill)
      assert_equal("0.000 0.000 1.000 rg", Color::RGB::Blue.pdf_fill)
      assert_equal("0.000 1.000 0.000 rg", Color::RGB::Lime.pdf_fill)
      assert_equal("1.000 0.000 0.000 rg", Color::RGB::Red.pdf_fill)
      assert_equal("1.000 1.000 1.000 rg", Color::RGB::White.pdf_fill)
      assert_equal("0.000 0.000 0.000 RG", Color::RGB::Black.pdf_stroke)
      assert_equal("0.000 0.000 1.000 RG", Color::RGB::Blue.pdf_stroke)
      assert_equal("0.000 1.000 0.000 RG", Color::RGB::Lime.pdf_stroke)
      assert_equal("1.000 0.000 0.000 RG", Color::RGB::Red.pdf_stroke)
      assert_equal("1.000 1.000 1.000 RG", Color::RGB::White.pdf_stroke)
    end

    def test_to_cmyk
      assert_kind_of(Color::CMYK, Color::RGB::Black.to_cmyk)
      assert_equal(Color::CMYK.new(0, 0, 0, 100), Color::RGB::Black.to_cmyk)
      assert_equal(Color::CMYK.new(0, 0, 100, 0),
                   Color::RGB::Yellow.to_cmyk)
      assert_equal(Color::CMYK.new(100, 0, 0, 0), Color::RGB::Cyan.to_cmyk)
      assert_equal(Color::CMYK.new(0, 100, 0, 0),
                   Color::RGB::Magenta.to_cmyk)
      assert_equal(Color::CMYK.new(0, 100, 100, 0), Color::RGB::Red.to_cmyk)
      assert_equal(Color::CMYK.new(100, 0, 100, 0),
                   Color::RGB::Lime.to_cmyk)
      assert_equal(Color::CMYK.new(100, 100, 0, 0),
                   Color::RGB::Blue.to_cmyk)
      assert_equal(Color::CMYK.new(10.32, 60.52, 10.32, 39.47),
                   Color::RGB::Purple.to_cmyk)
      assert_equal(Color::CMYK.new(10.90, 59.13, 59.13, 24.39),
                   Color::RGB::Brown.to_cmyk)
      assert_equal(Color::CMYK.new(0, 63.14, 18.43, 0),
                   Color::RGB::Carnation.to_cmyk)
      assert_equal(Color::CMYK.new(7.39, 62.69, 62.69, 37.32),
                   Color::RGB::Cayenne.to_cmyk)
    end

    def test_to_grayscale
      assert_kind_of(Color::GrayScale, Color::RGB::Black.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0),
                   Color::RGB::Black.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Yellow.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Cyan.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Magenta.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Red.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Lime.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.5),
                   Color::RGB::Blue.to_grayscale)
      assert_equal(Color::GrayScale.from_fraction(0.2510),
                   Color::RGB::Purple.to_grayscale)
      assert_equal(Color::GrayScale.new(40.58),
                   Color::RGB::Brown.to_grayscale)
      assert_equal(Color::GrayScale.new(68.43),
                   Color::RGB::Carnation.to_grayscale)
      assert_equal(Color::GrayScale.new(27.65),
                   Color::RGB::Cayenne.to_grayscale)
    end

    def test_to_hsl
      assert_kind_of(Color::HSL, Color::RGB::Black.to_hsl)
      assert_equal(Color::HSL.new, Color::RGB::Black.to_hsl)
      assert_equal(Color::HSL.new(60, 100, 50), Color::RGB::Yellow.to_hsl)
      assert_equal(Color::HSL.new(180, 100, 50), Color::RGB::Cyan.to_hsl)
      assert_equal(Color::HSL.new(300, 100, 50), Color::RGB::Magenta.to_hsl)
      assert_equal(Color::HSL.new(0, 100, 50), Color::RGB::Red.to_hsl)
      assert_equal(Color::HSL.new(120, 100, 50), Color::RGB::Lime.to_hsl)
      assert_equal(Color::HSL.new(240, 100, 50), Color::RGB::Blue.to_hsl)
      assert_equal(Color::HSL.new(300, 100, 25.10),
                   Color::RGB::Purple.to_hsl)
      assert_equal(Color::HSL.new(0, 59.42, 40.59),
                   Color::RGB::Brown.to_hsl)
      assert_equal(Color::HSL.new(317.5, 100, 68.43),
                   Color::RGB::Carnation.to_hsl)
      assert_equal(Color::HSL.new(0, 100, 27.64),
                   Color::RGB::Cayenne.to_hsl)

      assert_equal("hsl(0.00, 0.00%, 0.00%)", Color::RGB::Black.css_hsl)
      assert_equal("hsl(60.00, 100.00%, 50.00%)",
                   Color::RGB::Yellow.css_hsl)
      assert_equal("hsl(180.00, 100.00%, 50.00%)", Color::RGB::Cyan.css_hsl)
      assert_equal("hsl(300.00, 100.00%, 50.00%)",
                   Color::RGB::Magenta.css_hsl)
      assert_equal("hsl(0.00, 100.00%, 50.00%)", Color::RGB::Red.css_hsl)
      assert_equal("hsl(120.00, 100.00%, 50.00%)", Color::RGB::Lime.css_hsl)
      assert_equal("hsl(240.00, 100.00%, 50.00%)", Color::RGB::Blue.css_hsl)
      assert_equal("hsl(300.00, 100.00%, 25.10%)",
                   Color::RGB::Purple.css_hsl)
      assert_equal("hsl(0.00, 59.42%, 40.59%)", Color::RGB::Brown.css_hsl)
      assert_equal("hsl(317.52, 100.00%, 68.43%)",
                   Color::RGB::Carnation.css_hsl)
      assert_equal("hsl(0.00, 100.00%, 27.65%)", Color::RGB::Cayenne.css_hsl)

      assert_equal("hsla(0.00, 0.00%, 0.00%, 1.00)",
                   Color::RGB::Black.css_hsla)
      assert_equal("hsla(60.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Yellow.css_hsla)
      assert_equal("hsla(180.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Cyan.css_hsla)
      assert_equal("hsla(300.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Magenta.css_hsla)
      assert_equal("hsla(0.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Red.css_hsla)
      assert_equal("hsla(120.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Lime.css_hsla)
      assert_equal("hsla(240.00, 100.00%, 50.00%, 1.00)",
                   Color::RGB::Blue.css_hsla)
      assert_equal("hsla(300.00, 100.00%, 25.10%, 1.00)",
                   Color::RGB::Purple.css_hsla)
      assert_equal("hsla(0.00, 59.42%, 40.59%, 1.00)",
                   Color::RGB::Brown.css_hsla)
      assert_equal("hsla(317.52, 100.00%, 68.43%, 1.00)",
                   Color::RGB::Carnation.css_hsla)
      assert_equal("hsla(0.00, 100.00%, 27.65%, 1.00)",
                   Color::RGB::Cayenne.css_hsla)

      # The following tests a bug reported by Jean Krohn on 10 June 2006
      # where HSL conversion was not quite correct, resulting in a bad
      # round-trip.
      assert_equal("#008800", Color::RGB.from_html("#008800").to_hsl.html)
      refute_equal("#002288", Color::RGB.from_html("#008800").to_hsl.html)

      # The following tests a bug reported by Adam Johnson on 29 October
      # 2010.
      hsl = Color::HSL.new(262, 67, 42)
      c = Color::RGB.from_fraction(0.34496, 0.1386, 0.701399).to_hsl
      assert_in_delta hsl.h, c.h, Color::COLOR_TOLERANCE, "Hue"
      assert_in_delta hsl.s, c.s, Color::COLOR_TOLERANCE, "Saturation"
      assert_in_delta hsl.l, c.l, Color::COLOR_TOLERANCE, "Luminance"
    end

    def test_to_rgb
      assert_same(Color::RGB::Black, Color::RGB::Black.to_rgb)
    end

    def test_to_yiq
      assert_kind_of(Color::YIQ, Color::RGB::Black.to_yiq)
      assert_equal(Color::YIQ.new, Color::RGB::Black.to_yiq)
      assert_equal(Color::YIQ.new(88.6, 32.1, 0), Color::RGB::Yellow.to_yiq)
      assert_equal(Color::YIQ.new(70.1, 0, 0), Color::RGB::Cyan.to_yiq)
      assert_equal(Color::YIQ.new(41.3, 27.5, 52.3),
                   Color::RGB::Magenta.to_yiq)
      assert_equal(Color::YIQ.new(29.9, 59.6, 21.2), Color::RGB::Red.to_yiq)
      assert_equal(Color::YIQ.new(58.7, 0, 0), Color::RGB::Lime.to_yiq)
      assert_equal(Color::YIQ.new(11.4, 0, 31.1), Color::RGB::Blue.to_yiq)
      assert_equal(Color::YIQ.new(20.73, 13.80, 26.25),
                   Color::RGB::Purple.to_yiq)
      assert_equal(Color::YIQ.new(30.89, 28.75, 10.23),
                   Color::RGB::Brown.to_yiq)
      assert_equal(Color::YIQ.new(60.84, 23.28, 27.29),
                   Color::RGB::Carnation.to_yiq)
      assert_equal(Color::YIQ.new(16.53, 32.96, 11.72),
                   Color::RGB::Cayenne.to_yiq)
    end

    def test_to_lab
      # Luminosity can be an absolute.
      assert_in_delta(0.0, Color::RGB::Black.to_lab[:L], Color::COLOR_TOLERANCE)
      assert_in_delta(100.0, Color::RGB::White.to_lab[:L], Color::COLOR_TOLERANCE)

      # It's not really possible to have absolute
      # numbers here because of how L*a*b* works, but
      # negative/positive comparisons work
      assert(Color::RGB::Green.to_lab[:a] < 0)
      assert(Color::RGB::Magenta.to_lab[:a] > 0)
      assert(Color::RGB::Blue.to_lab[:b] < 0)
      assert(Color::RGB::Yellow.to_lab[:b] > 0)

      # an rgb color converted to lab and to rgb from lab will still have the same r,g,b values
      # not ready for this yet.
      # 10.times do |t|
      #   c1=Color::RGB.new(rand(256),rand(256),rand(256) )
      #   l1 = c1.to_lab
      #   c2 = l1.to_rgb
      #   assert_equal(c1.r,c2.r)
      #   assert_equal(c1.g,c2.g)
      #   assert_equal(c1.b,c2.b)
      # end
    end

    def test_closest_match
      # It should match Blue to Indigo (very simple match)
      match_from = [Color::RGB::Red, Color::RGB::Green, Color::RGB::Blue]
      assert_equal(Color::RGB::Blue, Color::RGB::Indigo.closest_match(match_from))
      # But fails if using the :just_noticeable difference.
      assert_nil(Color::RGB::Indigo.closest_match(match_from, :just_noticeable))

      # Crimson & Firebrick are visually closer than DarkRed and Firebrick
      # (more precise match)
      match_from += [Color::RGB::DarkRed, Color::RGB::Crimson]
      assert_equal(Color::RGB::Crimson,
                   Color::RGB::Firebrick.closest_match(match_from))
      # Specifying a threshold low enough will cause even that match to
      # fail, though.
      assert_nil(Color::RGB::Firebrick.closest_match(match_from, 8.0))
      # If the match_from list is an empty array, it also returns nil
      assert_nil(Color::RGB::Red.closest_match([]))

      # RGB::Green is 0,128,0, so we'll pick something VERY close to it, visually
      jnd_green = Color::RGB.new(3, 132, 3)
      assert_equal(Color::RGB::Green,
                   jnd_green.closest_match(match_from, :jnd))
      # And then something that's just barely out of the tolerance range
      diff_green = Color::RGB.new(9, 142, 9)
      assert_nil(diff_green.closest_match(match_from, :jnd))
    end

    def test_add
      white = Color::RGB::Cyan + Color::RGB::Yellow
      refute_nil(white)
      assert_equal(Color::RGB::White, white)

      c1 = Color::RGB.new(0x80, 0x80, 0x00)
      c2 = Color::RGB.new(0x45, 0x20, 0xf0)
      cr = Color::RGB.new(0xc5, 0xa0, 0xf0)

      assert_equal(cr, c1 + c2)
    end

    def test_subtract
      black = Color::RGB::LightCoral - Color::RGB::Honeydew
      assert_equal(Color::RGB::Black, black)

      c1 = Color::RGB.new(0x85, 0x80, 0x00)
      c2 = Color::RGB.new(0x40, 0x20, 0xf0)
      cr = Color::RGB.new(0x45, 0x60, 0x00)

      assert_equal(cr, c1 - c2)
    end

    def test_mean_grayscale
      c1        = Color::RGB.new(0x85, 0x80, 0x00)
      c1_max    = c1.max_rgb_as_greyscale
      c1_max    = c1.max_rgb_as_greyscale
      c1_result = Color::GrayScale.from_fraction(0x85 / 255.0)

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
      assert_same(Color::RGB::Cyan, Color::RGB.by_hex('#0ff'))
      assert_same(Color::RGB::Cyan, Color::RGB.by_hex('#00ffff'))
      assert_equal("RGB [#333333]", Color::RGB.by_hex("#333").inspect)
      assert_equal("RGB [#333333]", Color::RGB.by_hex("333").inspect)
      assert_raises(ArgumentError) { Color::RGB.by_hex("5555555") }
      assert_raises(ArgumentError) { Color::RGB.by_hex("#55555") }
      assert_equal(:boom, Color::RGB.by_hex('#55555') { :boom })
    end

    def test_by_name
      assert_same(Color::RGB::Cyan, Color::RGB.by_name('cyan'))

      fetch_error = if RUBY_VERSION < "1.9"
                      IndexError
                    else
                      KeyError
                    end

      assert_raises(fetch_error) { Color::RGB.by_name('cyanide') }
      assert_equal(:boom, Color::RGB.by_name('cyanide') { :boom })
    end

    def test_by_css
      assert_same(Color::RGB::Cyan, Color::RGB.by_css('#0ff'))
      assert_same(Color::RGB::Cyan, Color::RGB.by_css('cyan'))
      assert_raises(ArgumentError) { Color::RGB.by_css('cyanide') }
      assert_equal(:boom, Color::RGB.by_css('cyanide') { :boom })
    end

    def test_extract_colors
      assert_equal([ Color::RGB::BlanchedAlmond, Color::RGB::Cyan ],
                   Color::RGB.extract_colors('BlanchedAlmond is a nice shade, but #00ffff is not.'))
    end

    def test_inspect
      assert_equal("RGB [#000000]", Color::RGB::Black.inspect)
      assert_equal("RGB [#0000ff]", Color::RGB::Blue.inspect)
      assert_equal("RGB [#00ff00]", Color::RGB::Lime.inspect)
      assert_equal("RGB [#ff0000]", Color::RGB::Red.inspect)
      assert_equal("RGB [#ffffff]", Color::RGB::White.inspect)
    end

    def test_delta_e2000_lab
      # test data:
      # http://www.ece.rochester.edu/~gsharma/ciede2000/
      # http://www.ece.rochester.edu/~gsharma/ciede2000/dataNprograms/CIEDE2000.xls

      # this will also test rad_to_deg and deg_to_rad by association
      test_colors=[]
      File.read('test/test_colors').each_line do |line|
        test_colors << line.split(" ").map(&:to_f)
      end
      correct_answers=[]
      File.read("test/test_color_correct_results").each_line do |line|
        correct_answers << line.to_f
      end
      test_colors.each do |nums|
        @ind ||= -1 ; @ind += 1
        c1={:L=> nums[0], :a=>nums[1], :b=>nums[2] }
        c2={:L=> nums[3], :a=>nums[4], :b=>nums[5] }
        c=Color::RGB.new
        answer = correct_answers[@ind]
        # puts "e2000 c1=#{c1.inspect}, c2=#{c2.inspect}, answer=#{answer}"
        e2000=c.delta_e2000_lab(c1,c2)
        assert_equal(c.delta_e2000_lab(c1,c2),c.delta_e2000_lab(c2,c1))
        assert_in_delta 0.0001 , e2000 , answer
      end
    end

    def test_contrast
      data=[
        [[171,215,103], [195,108,197], 0.18117],
        [[223,133,234], [64,160,101], 0.229530],
        [[7,30,49], [37,225,31], 0.377786],
        [[65,119,130], [70,63,212], 0.10323],
        [[211,77,232], [5,113,139], 0.233503],
        [[166,185,41], [87,193,137], 0.07275],
        [[1,120,37], [195,70,33], 0.1474640],
        [[99,206,21], [228,204,155], 0.22611],
        [[15,18,41], [90,202,208], 0.552434]
      ]
      data.each do |row|
        c1=Color::RGB.new( row[0][0], row[0][1] , row[0][2] )
        c2=Color::RGB.new( row[1][0], row[1][1] , row[1][2] )
        assert_in_delta(0.0001, c1.contrast(c2), row[2] )
        assert_equal( c1.contrast(c2), c2.contrast(c1) )
      end
    end
  end
end
