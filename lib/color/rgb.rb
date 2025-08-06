# frozen_string_literal: true

# The \RGB color model is an additive color model where the primary colors (red, green,
# and blue) of light are added to produce millions of colors. \RGB rendering is
# device-dependent and without color management, the same "red" color will render
# differently.
#
# This class does not implement color management and is not \RGB colorspace aware; that is,
# unless otherwise noted, it does not assume that the \RGB represented is sRGB or Adobe
# \RGB (opRGB).
#
# \RGB colors are immutable Data class instances. Array deconstruction is `[red, green,
# blue]` and hash deconstruction is `{r:, red:, g:, green:, b:, blue}`. See #r, #red, #g,
# #green, #b, #blue.
class Color::RGB
  include Color

  ##
  # :attr_reader: r
  # Returns the red component of the color in the range 0.0..1.0.

  ##
  # :attr_reader: red
  # Returns the red component of the color in the normal 0..255 range.

  ##
  # :attr_reader: red_p
  # Returns the red component of the color as a percentage (0.0 .. 100.0).
  #
  ##
  # :attr_reader: g
  # Returns the green component of the color in the range 0.0..1.0.

  ##
  # :attr_reader: green
  # Returns the green component of the color in the normal 0 .. 255 range.

  ##
  # :attr_reader: green_p
  # Returns the green component of the color as a percentage (0.0 .. 100.0).

  ##
  # :attr_reader: b
  # Returns the blue component of the color in the range 0.0..1.0.

  ##
  # :attr_reader: blue
  # Returns the blue component of the color in the normal 0 .. 255 range.

  ##
  # :attr_reader: blue_p
  # Returns the blue component of the color as a percentage (0.0 .. 100.0).

  ##
  # Creates a \RGB color object from fractional values (0.0 .. 1.0).
  #
  # ```ruby
  # Color::RGB.from_fraction(0.3, 0.2, 0.1) # => RGB [#4d331a]
  # Color::RGB.new(0.3, 0.2, 0.1)           # => RGB [#4d331a]
  # Color::RGB[r: 0.3, g: 0.2, b: 0.1]      # => RGB [#4d331a]
  # ```
  def initialize(r:, g:, b:, names: nil)
    super(r: normalize(r), g: normalize(g), b: normalize(b), names: names)
  end

  Black000 = new(r: 0x00, g: 0x00, b: 0x00) # :nodoc:
  WhiteFFF = new(r: 0xff, g: 0xff, b: 0xff) # :nodoc:

  ##
  # :attr_reader: name
  # The primary name for this \RGB color.

  ##
  # :attr_reader: names
  # The names for this \RGB color.

  ##
  def name = names&.first # :nodoc:

  ##
  # Coerces the other Color object into \RGB.
  def coerce(other) = other.to_rgb

  ##
  # Converts the \RGB color to Color::CMYK.
  #
  # Most color experts strongly suggest that this is not a good idea (some suggesting that
  # it's a very bad idea). CMYK represents additive percentages of inks on white paper,
  # whereas \RGB represents mixed color intensities on an unlit (black) screen.
  #
  # 1. Convert the R, G, and B components to C, M, and Y components.
  #
  #       c = 1.0 - r
  #       m = 1.0 - g
  #       y = 1.0 - b
  #
  # 2. Compute the minimum amount of black (K) required to smooth the color in inks.
  #
  #       k = min(c, m, y)
  #
  # 3. Perform undercolor removal on the C, M, and Y components of the colors because less
  #    of each color is needed for each bit of black. Also, regenerate the black (K) based
  #    on the undercolor removal so that the color is more accurately represented in ink.
  #
  #       c = min(1.0, max(0.0, c - UCR(k)))
  #       m = min(1.0, max(0.0, m - UCR(k)))
  #       y = min(1.0, max(0.0, y - UCR(k)))
  #       k = min(1.0, max(0.0, BG(k)))
  #
  # The undercolor removal function and the black generation functions return a value
  # based on the brightness of the \RGB color.
  def to_cmyk(...)
    c = 1.0 - r.to_f
    m = 1.0 - g.to_f
    y = 1.0 - b.to_f

    k = [c, m, y].min
    k -= (k * brightness)

    c = normalize(c - k)
    m = normalize(m - k)
    y = normalize(y - k)
    k = normalize(k)

    Color::CMYK.from_fraction(c, m, y, k)
  end

  ##
  def to_rgb(...) = self

  ##
  # Convert \RGB to Color::Grayscale via Color::HSL (for the luminance value).
  def to_grayscale(...) = Color::Grayscale.from_fraction(to_hsl.l)

  ##
  # Converts \RGB to Color::YIQ.
  def to_yiq(...)
    y = (r * 0.299) + (g * 0.587) + (b * 0.114)
    i = (r * 0.596) + (g * -0.275) + (b * -0.321)
    q = (r * 0.212) + (g * -0.523) + (b * 0.311)
    Color::YIQ.from_fraction(y, i, q)
  end

  ##
  # Converts \RGB to Color::HSL.
  #
  # The conversion here is based on formulas from http://www.easyrgb.com/math.php and
  # elsewhere.
  def to_hsl(...)
    min, max = [r, g, b].minmax
    delta = (max - min).to_f

    l = (max + min) / 2.0

    if near_zero?(delta) # close to 0.0, so it's a gray
      h = 0
      s = 0
    else
      s = if near_zero_or_less?(l - 0.5)
        delta / (max + min).to_f
      else
        delta / (2 - max - min).to_f
      end

      # This is based on the conversion algorithm from
      # http://en.wikipedia.org/wiki/HSV_color_space#Conversion_from_RGB_to_HSL_or_HSV
      # Contributed by Adam Johnson
      sixth = 1 / 6.0
      if r == max # near_zero_or_less?(r - max)
        h = (sixth * ((g - b) / delta))
        h += 1.0 if g < b
      elsif g == max # near_zero_or_less(g - max)
        h = (sixth * ((b - r) / delta)) + (1.0 / 3.0)
      elsif b == max # near_zero_or_less?(b - max)
        h = (sixth * ((r - g) / delta)) + (2.0 / 3.0)
      end

      h += 1 if h < 0
      h -= 1 if h > 1
    end

    Color::HSL.from_fraction(h, s, l)
  end

  ##
  # Converts \RGB to Color::XYZ using the D65 reference white. This is based on conversion
  # formulas presented by Bruce Lindbloom, in particular [RGB to XYZ][rgbxyz].
  #
  # [rgbxyz]: http://www.brucelindbloom.com/index.html?Eqn_RGB_to_XYZ.html
  #
  # The conversion is performed assuming the \RGB value is in the sRGB color space. No
  # other \RGB color spaces are currently supported.
  #
  # :call-seq:
  #   to_xyz(color_space: :srgb)
  def to_xyz(*args, **kwargs)
    color_space = kwargs[:color_space] || args.first || :sRGB

    case color_space.to_s.downcase
    when "srgb"
      # Inverse sRGB companding. Linearizes RGB channels with respect to energy.
      rr, gg, bb = [r, g, b].map {
        if _1 > 0.04045
          (((_1 + 0.055) / 1.055)**2.4)
        else
          (_1 / 12.92)
        end * 100.0
      }

      # Convert using the RGB/XYZ matrix at:
      # http://www.brucelindbloom.com/index.html?Eqn_RGB_XYZ_Matrix.html#WSMatrices
      Color::XYZ.from_values(
        rr * 0.4124564 + gg * 0.3575761 + bb * 0.1804375,
        rr * 0.2126729 + gg * 0.7151522 + bb * 0.0721750,
        rr * 0.0193339 + gg * 0.1191920 + bb * 0.9503041
      )
    else
      raise ArgumentError, "Unsupported color space #{color_space}."
    end
  end

  ##
  # Converts \RGB to Color::CIELAB via Color::XYZ.
  #
  # Based on the [XYZ to CIELAB][xyztolab] formula presented by Bruce Lindbloom.
  #
  # [xyztolab]: http://www.brucelindbloom.com/index.html?Eqn_XYZ_to_Lab.html
  #
  # The conversion is performed assuming the \RGB value is in the sRGB color space. No
  # other \RGB color spaces are currently supported. By default, uses the D65 reference
  # white for the conversion.
  #
  # :call-seq:
  #   to_lab(color_space: :sRGB, white: Color::XYZ::D65)
  def to_lab(...) = to_xyz(...).to_lab(...)

  ##
  # Present the color as an HTML/CSS \RGB hex triplet (+ccddee+).
  def hex
    "%02x%02x%02x" % [red, green, blue].map(&:round)
  end

  ##
  # Present the color as an HTML/CSS color string (+#ccddee+).
  def html
    "##{hex}"
  end

  ##
  # Present the color as an CSS `rgb` function with optional `alpha`.
  #
  # ```ruby
  # rgb = Color::RGB.from_percentage(0, 50, 100)
  # rgb.css             # => rgb(0 50.00% 100.00%)
  # rgb.css(alpha: 0.5) # => rgb(0 50.00% 100.00% / 0.50)
  # ```
  def css(alpha: nil)
    params = [css_value(red_p, :percent), css_value(green_p, :percent), css_value(blue_p, :percent)].join(" ")
    params = "#{params} / #{css_value(alpha)}" if alpha

    "rgb(#{params})"
  end

  ##
  # Computes the ΔE* 2000 difference via Color::CIELAB. See Color::CIELAB#delta_e2000.
  def delta_e2000(other) = to_lab.delta_e2000(coerce(other).to_lab)

  ##
  # Mix the \RGB hue with white so that the \RGB hue is the specified percentage of the
  # resulting color.
  #
  # Strictly speaking, this isn't a `lighten_by` operation, but it mostly works.
  def lighten_by(percent) = mix_with(Color::RGB::WhiteFFF, percent)

  ##
  # Mix the \RGB hue with black so that the \RGB hue is the specified percentage of the
  # resulting color.
  #
  # Strictly speaking, this isn't a `darken_by` operation, but it mostly works.
  def darken_by(percent) = mix_with(Color::RGB::Black000, percent)

  ##
  # Mix the mask color with the current color at the stated opacity percentage (0..100).
  def mix_with(mask, opacity)
    opacity = normalize(opacity / 100.0)
    mask = coerce(mask)

    with(
      r: (r * opacity) + (mask.r * (1 - opacity)),
      g: (g * opacity) + (mask.g * (1 - opacity)),
      b: (b * opacity) + (mask.b * (1 - opacity))
    )
  end

  ##
  # Returns the brightness value for a color, a number between 0..1.
  #
  # Based on the Y value of Color::YIQ encoding, representing luminosity, or perceived
  # brightness.
  def brightness = to_yiq.y

  ##
  # Returns a new \RGB color with the brightness adjusted by the specified percentage via
  # Color::HSL. Negative percentages will darken the color; positive percentages will
  # brighten the color.
  #
  # ```ruby
  # dark_blue = Color::RGB::DarkBlue  # => RGB [#00008b]
  # dark_blue.adjust_brightness(10)   # => RGB [#000099]
  # dark_blue.adjust_brightness(-10)  # => RGB [#00007d]
  # ```
  def adjust_brightness(percent)
    hsl = to_hsl
    hsl.with(l: hsl.l * percent_adjustment(percent)).to_rgb
  end

  ##
  # Returns a new \RGB color with the saturation adjusted by the specified percentage via
  # Color::HSL. Negative percentages will reduce the saturation; positive percentages will
  # increase the saturation.
  #
  # ```ruby
  # dark_blue = Color::RGB::DarkBlue  # => RGB [#00008b]
  # dark_blue.adjust_saturation(10)   # => RGB [#00008b]
  # dark_blue.adjust_saturation(-10)  # => RGB [#070784]
  # ```
  def adjust_saturation(percent)
    hsl = to_hsl
    hsl.with(s: hsl.s * percent_adjustment(percent)).to_rgb
  end

  ##
  # Returns a new \RGB color with the hue adjusted by the specified percentage via
  # Color::HSL. Negative percentages will reduce the hue; positive percentages will
  # increase the hue.
  #
  # ```ruby
  # dark_blue = Color::RGB::DarkBlue  # => RGB [#00008b]
  # dark_blue.adjust_hue(10)          # => RGB [#38008b]
  # dark_blue.adjust_hue(-10)         # => RGB [#00388b]
  # ```
  def adjust_hue(percent)
    hsl = to_hsl
    hsl.with(h: hsl.h * percent_adjustment(percent)).to_rgb
  end

  ##
  # Determines the closest match to this color from a list of provided colors or `nil` if
  # `color_list` is empty or no color is found within the `threshold_distance`.
  #
  # The default search uses the CIE ΔE* 1994 algorithm (CIE94) to find near matches based
  # on the perceived visual differences between the colors. The default value for
  # `algorithm` is `:delta_e94`.
  #
  # `threshold_distance` is used to determine the minimum color distance permitted. Uses
  # the CIE ΔE* 1994 algorithm (CIE94) to find near matches based on perceived visual
  # color. The default value (1000.0) is an arbitrarily large number. The values `:jnd`
  # and `:just_noticeable` may be passed as the `threshold_distance` to use the value
  # `2.3`.
  #
  # All ΔE* formulae were designed to use 1.0 as a "just noticeable difference" (JND),
  # but CIE ΔE*ab 1976 defined JND as 2.3.
  #
  # :call-seq:
  #   closest_match(color_list, algorithm: :delta_e94, threshold_distance: 1000.0)
  def closest_match(color_list, *args, **kwargs)
    color_list = [color_list].flatten(1)
    return nil if color_list.empty?

    algorithm = kwargs[:algorithm] || args.first || :delta_e94
    threshold_distance = kwargs[:threshold_distance] || args[1] || 1000.0

    threshold_distance =
      case threshold_distance
      when :jnd, :just_noticeable
        2.3
      else
        threshold_distance.to_f
      end

    closest_distance = threshold_distance
    best_match = nil

    color_list.each do |c|
      distance = contrast(c, algorithm)
      if distance < closest_distance
        closest_distance = distance
        best_match = c
      end
    end

    best_match
  end

  ##
  # The Delta E (CIE94) algorithm http://en.wikipedia.org/wiki/Color_difference#CIE94
  #
  # There is a newer version, CIEDE2000, that uses slightly more complicated math, but
  # addresses "the perceptual uniformity issue" left lingering by the CIE94 algorithm.
  #
  # Since our source is treated as sRGB, we use the "graphic arts" presets for k_L, k_1,
  # and k_2
  #
  # The calculations go through LCH(ab). (?)
  #
  # See also http://www.brucelindbloom.com/index.html?Eqn_DeltaE_CIE94.html
  def delta_e94(...) = to_lab.delta_e94(...)

  ##
  def red = normalize(r * 255.0, 0.0..255.0) # :nodoc:

  ##
  def red_p = normalize(r * 100.0, 0.0..100.0) # :nodoc:

  ##
  def green = normalize(g * 255.0, 0.0..255.0) # :nodoc:

  ##
  def green_p = normalize(g * 100.0, 0.0..100.0) # :nodoc:

  ##
  def blue = normalize(b * 255.0, 0.0..255.0) # :nodoc:

  ##
  def blue_p = normalize(b * 100.0, 0.0..100.0) # :nodoc:

  ##
  # Return a Grayscale color object created from the largest of the `r`, `g`, and `b`
  # values.
  def max_rgb_as_grayscale = Color::Grayscale.from_fraction([r, g, b].max)

  ##
  def inspect = "RGB [#{html}]" # :nodoc:

  ##
  def pretty_print(q) # :nodoc:
    q.text "RGB"
    q.breakable
    q.group 2, "[", "]" do
      q.text html
    end
  end

  ##
  def to_a = [red, green, blue] # :nodoc:

  ##
  alias_method :deconstruct, :to_a # :nodoc:

  ##
  def deconstruct_keys(_keys) = {r:, g:, b:, red:, green:, blue:} # :nodoc:

  ##
  def to_internal = [r, g, b] # :nodoc:

  ##
  # Outputs how much contrast this color has with another RGB color.
  #
  # The `delta_e94` algorithm uses ΔE*94 for contrast calculations and the `delta_e2000`
  # algorithm uses ΔE*2000.
  #
  # The `naive` algorithm treats the foreground and background colors as the same.
  # Any result over about 0.22 should have a high likelihood of being legible, but the
  # larger the difference, the more contrast. Otherwise, to be safe go with something
  # > 0.3.
  #
  # :call-seq:
  #   contrast(other, algorithm: :naive)
  #   contrast(other, algorithm: :delta_e94)
  #   contrast(other, algorithm: :delta_e2000)
  def contrast(other, *args, **kwargs)
    other = coerce(other)

    algorithm = kwargs[:algorithm] || args.first || :naive

    case algorithm
    when :delta_e94
      delta_e94(other)
    when :delta_e2000
      delta_e2000(other)
    when :naive
      # The following numbers have been set with some care.
      ((diff_brightness(other) * 0.65) +
       (diff_hue(other) * 0.20) +
       (diff_luminosity(other) * 0.15))
    else
      raise ARgumentError, "Unknown algorithm #{algorithm.inspect}"
    end
  end

  private

  ##
  def percent_adjustment(percent) # :nodoc:
    percent /= 100.0
    percent += 1.0
    percent = [percent, 2.0].min
    [0.0, percent].max
  end

  ##
  # Provides the luminosity difference between two rbg vals
  def diff_luminosity(other) # :nodoc:
    l1 = (0.2126 * other.r**2.2) +
      (0.7152 * other.b**2.2) +
      (0.0722 * other.g**2.2)

    l2 = (0.2126 * r**2.2) +
      (0.7152 * b**2.2) +
      (0.0722 * g**2.2)

    (([l1, l2].max + 0.05) / ([l1, l2].min + 0.05) - 1) / 20.0
  end

  ##
  # Provides the brightness difference.
  def diff_brightness(other) # :nodoc:
    br1 = (299 * other.r + 587 * other.g + 114 * other.b)
    br2 = (299 * r + 587 * g + 114 * b)
    (br1 - br2).abs / 1000.0
  end

  ##
  # Provides the euclidean distance between the two color values
  def diff_euclidean(other)
    ((((other.r - r)**2) +
      ((other.g - g)**2) +
      ((other.b - b)**2))**0.5) / 1.7320508075688772
  end

  ##
  # Difference in the two colors' hue
  def diff_hue(other) # :nodoc:
    ((r - other.r).abs +
     (g - other.g).abs +
     (b - other.b).abs) / 3
  end
end

class << Color::RGB
  ##
  # Creates a RGB color object from percentage values (0.0 .. 100.0).
  #
  # ```ruby
  # Color::RGB.from_percentage(10, 20, 30)
  # ```
  def from_percentage(*args, **kwargs)
    r, g, b, names =
      case [args, kwargs]
      in [[r, g, b], {}]
        [r, g, b, nil]
      in [[_, _, _, _], {}]
        args
      in [[], {r:, g:, b:}]
        [r, g, b, nil]
      in [[], {r:, g:, b:, names:}]
        [r, g, b, names]
      else
        new(*args, **kwargs)
      end

    new(r: r / 100.0, g: g / 100.0, b: b / 100.0, names: names)
  end

  # Creates a RGB color object from the standard three byte range (0 .. 255).
  #
  # ```ruby
  # Color::RGB.from_values(32, 64, 128)
  # Color::RGB.from_values(0x20, 0x40, 0x80)
  # ```
  def from_values(*args, **kwargs)
    r, g, b, names =
      case [args, kwargs]
      in [[r, g, b], {}]
        [r, g, b, nil]
      in [[_, _, _, _], {}]
        args
      in [[], {r:, g:, b:}]
        [r, g, b, nil]
      in [[], {r:, g:, b:, names:}]
        [r, g, b, names]
      else
        new(*args, **kwargs)
      end

    new(r: r / 255.0, g: g / 255.0, b: b / 255.0, names: names)
  end

  ##
  alias_method :from_fraction, :new

  ##
  alias_method :from_internal, :new # :nodoc:

  ##
  # Creates a RGB color object from an HTML color descriptor (e.g., `"fed"` or
  # `"#cabbed;"`.
  #
  # ```ruby
  # Color::RGB.from_html("fed")
  # Color::RGB.from_html("#fed")
  # Color::RGB.from_html("#cabbed")
  # Color::RGB.from_html("cabbed")
  # ```
  def from_html(html_color)
    h = html_color.scan(/\h/i)
    r, g, b = case h.size
    when 3
      h.map { |v| (v * 2).to_i(16) }
    when 6
      h.each_slice(2).map { |v| v.join.to_i(16) }
    else
      raise ArgumentError, "Not a supported HTML color type."
    end

    from_values(r, g, b)
  end

  ##
  # Find or create a color by an HTML hex code. This differs from the #from_html method
  # in that if the color code matches a named color, the existing color will be
  # returned.
  #
  # ```ruby
  # Color::RGB.by_hex('ff0000').name # => 'red'
  # Color::RGB.by_hex('ff0001').name # => nil
  # ```
  #
  # An exception will be raised if the value provided is not found or cannot be
  # interpreted as a valid hex colour.
  def by_hex(hex) = __by_hex.fetch(html_hexify(hex)) { from_html(hex) }

  ##
  # Return a color as identified by the color name.
  def by_name(name, &block) = __by_name.fetch(name.to_s.downcase, &block)

  ##
  # Return a color as identified by the color name, or by hex.
  def by_css(name_or_hex, &block) = by_name(name_or_hex) { by_hex(name_or_hex, &block) }

  ##
  # Extract named or hex colors from the provided text.
  def extract_colors(text, mode = :both)
    require "color/rgb/colors"
    text = text.downcase
    regex = case mode
    when :name
      Regexp.union(__by_name.keys)
    when :hex
      Regexp.union(__by_hex.keys)
    when :both
      Regexp.union(__by_hex.keys + __by_name.keys)
    else
      raise ArgumentError, "Unknown mode #{mode}"
    end

    text.scan(regex).map { |match|
      case mode
      when :name
        by_name(match)
      when :hex
        by_hex(match)
      when :both
        by_css(match)
      end
    }
  end

  private

  ##
  def __by_hex # :nodoc:
    require "color/rgb/colors"
    @__by_hex
  end

  ##
  def __by_name # :nodoc:
    require "color/rgb/colors"
    @__by_name
  end

  ##
  def html_hexify(hex) # :nodoc:
    h = hex.to_s.downcase.scan(/\h/)
    case h.size
    when 3
      h.map { |v| (v * 2) }.join
    when 6
      h.join
    else
      raise ArgumentError, "Not a supported HTML color type."
    end
  end
end
