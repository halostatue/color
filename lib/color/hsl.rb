# frozen_string_literal: true

##
# The \HSL color model is a cylindrical-coordinate representation of the sRGB color model,
# standing for hue (measured in degrees on the cylinder), saturation (measured in
# percentage), and lightness (measured in percentage).
#
# \HSL colors are immutable Data class instances. Array deconstruction is `[hue,
# saturation, luminosity]` and hash deconstruction is `{h:, hue:, s:, saturation:, l:,
# luminosity:}`. See #h, #hue, #s, #saturation, #l, #luminosity.
class Color::HSL
  include Color

  ##
  # :attr_reader: h
  # Returns the hue of the color in the range 0.0..1.0.

  ##
  # :attr_reader: hue
  # Returns the hue of the color in degrees (0.0..360.0).

  ##
  # :attr_reader: s
  # Returns the saturation of the color in the range 0.0..1.0.

  ##
  # :attr_reader: saturation
  # Returns the percentage of saturation of the color (0.0..100.0).

  ##
  # :attr_reader: brightness
  # Returns the luminosity (#l) of the color.

  ##
  # :attr_reader: l
  # Returns the luminosity of the color in the range 0.0..1.0.

  ##
  # :attr_reader: luminosity
  # Returns the percentage of luminosity of the color.

  ##
  # Creates a \HSL color object from degrees (0.0 .. 360.0) and percentage values
  # (0.0 .. 100.0).
  #
  # ```ruby
  # Color::HSL.from_values(145, 30, 50)          # => HSL [145deg 30% 50%]
  # Color::HSL.from_values(h: 145, s: 30, l: 50) # => HSL [145deg 30% 50%]
  # ```
  #
  # :call-seq:
  #   from_values(h, s, l)
  #   from_values(h:, s:, l:)
  def self.from_values(*args, **kwargs)
    h, s, l =
      case [args, kwargs]
      in [[_, _, _], {}]
        args
      in [[], {h:, s:, l:}]
        [h, s, l]
      else
        new(*args, **kwargs)
      end

    new(h: h / 360.0, s: s / 100.0, l: l / 100.0)
  end

  class << self
    alias_method :from_fraction, :new
    alias_method :from_internal, :new # :nodoc:
  end

  ##
  # Creates a \HSL color object from fractional values (0.0 .. 1.0).
  #
  # ```ruby
  # Color::HSL.from_fraction(0.3, 0.3, 0.5) # => HSL [108deg 30% 50%]
  # Color::HSL.new(h: 0.3, s: 0.3, l: 0.5)  # => HSL [108deg 30% 50%]
  # Color::HSL[0.3, 0.3, 0.5]               # => HSL [108deg 30% 50%]
  # ```
  def initialize(h:, s:, l:)
    super(h: normalize(h), s: normalize(s), l: normalize(l))
  end

  ##
  # Coerces the other Color object into \HSL.
  def coerce(other) = other.to_hsl

  ##
  # Converts from \HSL to Color::RGB.
  #
  # As with all color conversions, this is an approximation. The code here is adapted from
  # fvd and van Dam, originally found at [1] (implemented similarly at [2]). This
  # simplifies the calculations with the following assumptions:
  #
  # - Luminance values <= 0 always translate to a black Color::RGB value.
  # - Luminance values >= 1 always translate to a white Color::RGB value.
  # - Saturation values <= 0 always translate to a shade of gray using luminance as
  #   a percentage of gray.
  #
  # [1] http://bobpowell.net/RGBHSB.aspx
  # [2] http://support.microsoft.com/kb/29240
  def to_rgb(...)
    if near_zero_or_less?(l)
      Color::RGB::Black000
    elsif near_one_or_more?(l)
      Color::RGB::WhiteFFF
    elsif near_zero?(s)
      Color::RGB.from_fraction(l, l, l)
    else
      Color::RGB.from_fraction(*compute_fvd_rgb)
    end
  end

  ##
  # Converts from \HSL to Color::YIQ via Color::RGB.
  def to_yiq(...) = to_rgb(...).to_yiq(...)

  ##
  # Converts from \HSL to Color::CMYK via Color::RGB.
  def to_cmyk(...) = to_rgb(...).to_cmyk(...)

  ##
  # Converts from \HSL to Color::Grayscale.
  #
  # Luminance is treated as the Grayscale ratio.
  def to_grayscale(...) = Color::Grayscale.from_fraction(l)

  ##
  # Converts from \HSL to Color::CIELAB via Color::RGB.
  def to_lab(...) = to_rgb(...).to_lab(...)

  ##
  # Converts from \HSL to Color::XYZ via Color::RGB.
  def to_xyz(...) = to_rgb(...).to_xyz(...)

  ##
  def to_hsl(...) = self

  ##
  # Present the color as a CSS `hsl` function with optional `alpha`.
  #
  # ```ruby
  # hsl = Color::HSL.from_values(145, 30, 50)
  # hsl.css             # => hsl(145deg 30% 50%)
  # hsl.css(alpha: 0.5) # => hsl(145deg 30% 50% / 0.50)
  # ```
  def css(alpha: nil)
    params = [
      css_value(hue, :degrees),
      css_value(saturation, :percent),
      css_value(luminosity, :percent)
    ].join(" ")
    params = "#{params} / #{css_value(alpha)}" if alpha

    "hsl(#{params})"
  end

  ##
  def brightness = l # :nodoc:

  ##
  def hue = h * 360.0 # :nodoc:

  ##
  def saturation = s * 100.0 # :nodoc:

  ##
  def luminosity = l * 100.0 # :nodoc:

  ##
  alias_method :lightness, :luminosity

  ##
  def inspect = "HSL [%.2fdeg %.2f%% %.2f%%]" % [hue, saturation, luminosity] # :nodoc:

  ##
  def pretty_print(q) # :nodoc:
    q.text "HSL"
    q.breakable
    q.group 2, "[", "]" do
      q.text "%.2fdeg" % hue
      q.fill_breakable
      q.text "%.2f%%" % saturation
      q.fill_breakable
      q.text "%.2f%%" % luminosity
    end
  end

  ##
  # Mix the mask color (which will be converted to a \HSL color) with the current color
  # at the stated fractional mix ratio (0.0..1.0).
  #
  # This implementation differs from Color::RGB#mix_with.
  #
  # :call-seq:
  #   mix_with(mask, mix_ratio: 0.5)
  def mix_with(mask, *args, **kwargs)
    mix_ratio = normalize(kwargs[:mix_ratio] || args.first || 0.5)

    map_with(mask) { ((_2 - _1) * mix_ratio) + _1 }
  end

  ##
  def to_a = [hue, saturation, luminosity] # :nodoc:

  ##
  alias_method :deconstruct, :to_a

  ##
  def deconstruct_keys(_keys) = {h:, s:, l:, hue:, saturation:, luminance:} # :nodoc:

  ##
  def to_internal = [h, s, l] # :nodoc:

  private

  ##
  # This algorithm calculates based on a mixture of the saturation and luminance, and then
  # takes the RGB values from the hue + 1/3, hue, and hue - 1/3 positions in a circular
  # representation of color divided into four parts (confusing, I know, but it's the way
  # that it works). See #hue_to_rgb for more information.
  def compute_fvd_rgb # :nodoc:
    t1, t2 = fvd_mix_sat_lum
    [h + (1 / 3.0), h, h - (1 / 3.0)].map { |v|
      hue_to_rgb(rotate_hue(v), t1, t2)
    }
  end

  ##
  # Mix saturation and luminance for use in hue_to_rgb. The base value is different
  # depending on whether luminance is <= 50% or > 50%.
  def fvd_mix_sat_lum # :nodoc:
    t = if near_zero_or_less?(l - 0.5)
      l * (1.0 + s.to_f)
    else
      l + s - (l * s.to_f)
    end
    [2.0 * l - t, t]
  end

  ##
  # In \HSL, hues are referenced as degrees in a color circle. The flow itself is endless;
  # therefore, we can rotate around. The only thing our implementation restricts is that
  # you should not be > 1.0.
  def rotate_hue(h) # :nodoc:
    h += 1.0 if near_zero_or_less?(h)
    h -= 1.0 if near_one_or_more?(h)
    h
  end

  ##
  # We calculate the interaction of the saturation/luminance mix (calculated earlier)
  # based on the position of the hue in the circular color space divided into quadrants.
  # Our hue range is [0, 1), not [0, 360º).
  #
  # - The first quadrant covers the first 60º [0, 60º].
  # - The second quadrant covers the next 120º (60º, 180º].
  # - The third quadrant covers the next 60º (180º, 240º].
  # - The fourth quadrant covers the final 120º (240º, 360º).
  def hue_to_rgb(h, t1, t2) # :nodoc:
    if near_zero_or_less?((6.0 * h) - 1.0)
      t1 + ((t2 - t1) * h * 6.0)
    elsif near_zero_or_less?((2.0 * h) - 1.0)
      t2
    elsif near_zero_or_less?((3.0 * h) - 2.0)
      t1 + (t2 - t1) * ((2 / 3.0) - h) * 6.0
    else
      t1
    end
  end
end
