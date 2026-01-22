# frozen_string_literal: true

##
# The \CMYK color model is a subtractive color model based on additive percentages of
# colored inks: cyan, magenta, yellow, and key (most often black).
#
# \CMYK [30% 0% 80% 30%] would be mixed from 30% cyan, 0% magenta, 80% yellow, and 30%
# black.
#
# \CMYK colors are immutable Data class instances. Array deconstruction is `[cyan,
# magenta, yellow, key]` and hash deconstruction is `{c:, cyan:, m:, magenta:, y:, yellow:
# k:, key:}`. See #c, #cyan, #m, #magenta, #y, #yellow, #k, #key.
class Color::CMYK
  include Color

  ##
  # :attr_reader: c
  # Returns the cyan (`C`) component as a value 0.0 .. 1.0.

  ##
  # :attr_reader: cyan
  # Returns the cyan (`C`) component as a percentage value (0.0 .. 100.0).

  ##
  # :attr_reader: m
  # Returns the magenta (`M`) component as a value 0.0 .. 1.0.

  ##
  # :attr_reader: magenta
  # Returns the magenta (`M`) component as a percentage value (0.0 .. 100.0).

  ##
  # :attr_reader: y
  # Returns the yellow (`Y`) component as a value 0.0 .. 1.0.

  ##
  # :attr_reader: yellow
  # Returns the yellow (`Y`) component as a percentage value (0.0 .. 100.0).

  ##
  # :attr_reader: k
  # Returns the key or black (`K`) component as a value 0.0 .. 1.0.

  ##
  # :attr_reader: b
  # Returns the key or black (`K`) component as a value 0.0 .. 1.0.

  ##
  # :attr_reader: key
  # Returns the key or black (`K`) component as a percentage value (0.0 .. 100.0).

  ##
  # :attr_reader: black
  # Returns the key or black (`K`) component as a percentage value (0.0 .. 100.0).

  ##
  # Creates a CMYK color object from percentage values (0.0 .. 100.0).
  #
  # ```ruby
  # Color::CMYK.from_percentage(30, 0, 80, 30) # => CMYK [30.00% 0.00% 80.00% 30.00%]
  # Color::CMYK.from_values(30, 0, 80, 30)     # => CMYK [30.00% 0.00% 80.00% 30.00%]
  # ```
  #
  # :call-seq:
  #   from_percentage(c, m, y, k)
  #   from_percentage(c:, m:, y:, k:)
  #   from_values(c, m, y, k)
  #   from_values(c:, m:, y:, k:)
  def self.from_percentage(*args, **kwargs)
    c, m, y, k =
      case [args, kwargs]
      in [[_, _, _, _], {}]
        args
      in [[], {c:, m:, y:, k:}]
        [c, m, y, k]
      else
        new(*args, **kwargs)
      end

    new(c: c / 100.0, m: m / 100.0, y: y / 100.0, k: k / 100.0)
  end

  class << self
    alias_method :from_values, :from_percentage

    alias_method :from_fraction, :new
    alias_method :from_internal, :new # :nodoc:
  end

  ##
  # Creates a CMYK color object from fractional values (0.0 .. 1.0).
  #
  # ```ruby
  # Color::CMYK.from_fraction(0.3, 0, 0.8, 0.3) # => CMYK [30.00% 0.00% 80.00% 30.00%]
  # Color::CMYK.new(0.3, 0, 0.8, 0.3)           # => CMYK [30.00% 0.00% 80.00% 30.00%]
  # Color::CMYK[c: 0.3, m: 0, y: 0.8, k: 0.3]   # => CMYK [30.00% 0.00% 80.00% 30.00%]
  # ```
  def initialize(c:, m:, y:, k:)
    super(c: normalize(c), m: normalize(m), y: normalize(y), k: normalize(k))
  end

  ##
  # Output a CSS representation of the CMYK color using `device-cmyk()`.
  #
  # If an `alpha` value is provided, it will be included in the output.
  #
  # A `fallback` may be provided or included automatically depending on the value
  # provided, which may be `true`, `false`, a Color object, or a Hash with `:color` and/or
  # `:alpha` keys. The default value is `true`.
  #
  # When `fallback` is:
  #
  # - `true`: this CMYK color will be converted to RGB and this will be provided as the
  #   fallback color. If an `alpha` value is provided, it will be used for the fallback.
  # - `false`: no fallback color will be included.
  # - a Color object will be used to produce the `fallback` value.
  # - a Hash will be checked for `:color` and/or `:alpha` keys:
  #   - if `:color` is present, it will be used for the fallback color; if not present,
  #     the CMYK color will be converted to RGB.
  #   - if `:alpha` is present, it will be used for the fallback color; if not present,
  #     the fallback color will be presented _without_ alpha.
  #
  # Examples:
  #
  # ```ruby
  # cmyk = Color::CMYK.from_percentage(30, 0, 80, 30)
  # cmyk.css
  # # => device-cmyk(30.00% 0 80.00% 30.00%, rgb(49.00% 70.00% 14.00%))
  #
  # cmyk.css(alpha: 0.5)
  # # => device-cmyk(30.00% 0 80.00% 30.00% / 0.50, rgb(49.00% 70.00% 14.00% / 0.50))
  #
  # cmyk.css(fallback: false)
  # # => device-cmyk(30.00% 0 80.00% 30.00%)
  #
  # cmyk.css(alpha: 0.5, fallback: false)
  # # => device-cmyk(30.00% 0 80.00% 30.00% / 0.50)
  #
  # cmyk.css(fallback: Color::RGB::Blue)
  # # => device-cmyk(30.00% 0 80.00% 30.00%, rgb(0.00% 0.00% 100.00%))
  #
  # cmyk.css(alpha: 0.5, fallback: Color::RGB::Blue)
  # # => device-cmyk(30.00% 0 80.00% 30.00% / 0.50, rgb(0.00% 0.00% 100.00% / 0.50))
  #
  # cmyk.css(alpha: 0.5, fallback: { color: Color::RGB::Blue })
  # # => device-cmyk(30.00% 0 80.00% 30.00% / 0.50, rgb(0.00% 0.00% 100.00%))
  #
  # cmyk.css(alpha: 0.5, fallback: { color: Color::RGB::Blue, alpha: 0.3 })
  # # => device-cmyk(30.00% 0 80.00% 30.00% / 0.50, rgb(0.00% 0.00% 100.00% / 0.30))
  #
  # cmyk.css(alpha: 0.5, fallback: { alpha: 0.3 })
  # # => device-cmyk(30.00% 0 80.00% 30.00% / 0.50, rgb(49.00% 70.00% 14.00% / 0.30))
  # ```
  def css(alpha: nil, fallback: true)
    if fallback.is_a?(Color)
      device_cmyk(alpha, fallback, alpha)
    elsif fallback.is_a?(Hash)
      device_cmyk(alpha, fallback.fetch(:color) { to_rgb }, fallback[:alpha])
    elsif fallback == true
      device_cmyk(alpha, to_rgb, alpha)
    else
      device_cmyk(alpha, nil, nil)
    end
  end

  ##
  # Coerces the other Color object into CMYK.
  def coerce(other) = other.to_cmyk

  ##
  def to_cmyk(...) = self

  ##
  # Converts CMYK to Color::Grayscale.
  #
  # There are multiple methods for grayscale conversion, but this implements a variant of
  # the Adobe PDF conversion method with higher precision:
  #
  # ```
  # g = 1.0 - min(1.0, 0.299 * c + 0.587 * m + 0.114 * y + k)
  # ```
  #
  # The default Adobe conversion uses lower precision conversion constants (0.3, 0.59, and
  # 0.11) instead of the more precise NTSC/YIQ values.
  def to_grayscale(...)
    gc = 0.299 * c
    gm = 0.587 * m
    gy = 0.114 * y
    g = 1.0 - [1.0, gc + gm + gy + k].min
    Color::Grayscale.from_fraction(g)
  end

  ##
  # Converts CMYK to Color::YIQ via Color::RGB.
  def to_yiq(...) = to_rgb(...).to_yiq(...)

  ##
  # Converts CMYK to Color::RGB.
  #
  # Most color experts strongly suggest that this is not a good idea (some suggesting that
  # it's a very bad idea). CMYK represents additive percentages of inks on white paper,
  # whereas RGB represents mixed color intensities on an unlit (black) screen.
  #
  # The color conversion can be done and there are two different methods (standard and
  # Adobe PDF) that provide slightly different results. Using CMYK [33% 66% 83% 25%], the
  # standard method provides an approximate RGB color of (128, 65, 33) or #804121. The
  # Adobe PDF method provides an approximate RGB color of (107, 23, 0) or #6b1700.
  #
  # Which is correct? The colors may seem to be drastically different in the RGB color
  # space, they differ mostly in intensity. The Adobe PDF conversion is a darker, slightly
  # redder brown; the standard conversion is a lighter brown. Because of this subtlety,
  # both methods are offered for conversion. The Adobe PDF method is not used by default;
  # to use it, pass `rgb_method: :adobe` to #to_rgb.
  #
  #   # Adobe PDF CMYK -> RGB Conversion
  #   r = 1.0 - min(1.0, c + k)
  #   g = 1.0 - min(1.0, m + k)
  #   b = 1.0 - min(1.0, y + k)
  #
  #   # Standard CMYK -> RGB Conversion
  #   r = 1.0 - (c * (1.0 - k) + k)
  #   g = 1.0 - (m * (1.0 - k) + k)
  #   b = 1.0 - (y * (1.0 - k) + k)
  #
  # :call-seq:
  #   to_rgb(rgb_method: :standard)
  def to_rgb(*args, **kwargs)
    values =
      if kwargs[:rgb_method] == :adobe || args.first == :adobe
        adobe_cmyk_rgb
      else
        standard_cmyk_rgb
      end

    Color::RGB.from_fraction(*values)
  end

  ##
  # Converts CMYK to Color::HSL via Color::RGB.
  def to_hsl(...) = to_rgb(...).to_hsl(...)

  ##
  # Converts CMYK to Color::CIELAB via Color::RGB.
  def to_lab(...) = to_rgb(...).to_lab(...)

  ##
  # Converts CMYK to Color::XYZ via Color::RGB.
  def to_xyz(...) = to_rgb(...).to_xyz(...)

  ##
  def inspect = "CMYK [%.2f%% %.2f%% %.2f%% %.2f%%]" % [cyan, magenta, yellow, key] # :nodoc:

  ##
  def pretty_print(q) # :nodoc:
    q.text "CMYK"
    q.breakable
    q.group 2, "[", "]" do
      q.text "%.2f%%" % cyan
      q.fill_breakable
      q.text "%.2f%%" % magenta
      q.fill_breakable
      q.text "%.2f%%" % yellow
      q.fill_breakable
      q.text "%.2f%%" % key
    end
  end

  ##
  def cyan = c * 100.0 # :nodoc:

  ##
  def magenta = m * 100.0 # :nodoc:

  ##
  def yellow = y * 100.0 # :nodoc:

  ##
  alias_method :b, :k # :nodoc:

  ##
  def key = k * 100.0 # :nodoc:

  ##
  alias_method :black, :key # :nodoc:

  ##
  def to_a = [cyan, magenta, yellow, key] # :nodoc:

  ##
  alias_method :deconstruct, :to_a # :nodoc:

  ##
  def deconstruct_keys(_keys) = {c:, m:, y:, k:, cyan:, magenta:, yellow:, key:} # :nodoc:

  ##
  def to_internal = [c, m, y, k] # :nodoc:

  ##
  def components = 4 # :nodoc:

  private

  ##
  # Implements the Adobe PDF conversion of CMYK to RGB.
  def adobe_cmyk_rgb = [c, m, y].map { 1.0 - [1.0, _1 + k].min } # :nodoc:

  ##
  # Implements the standard conversion of CMYK to RGB.
  def standard_cmyk_rgb = [c, m, y].map { 1.0 - (_1 * (1.0 - k) + k) } # :nodoc:

  ##
  def device_cmyk(alpha, fallback, fallback_alpha) # :nodoc:
    params = [
      css_value(cyan, :percent),
      css_value(magenta, :percent),
      css_value(yellow, :percent),
      css_value(key, :percent)
    ].join(" ")
    params = "#{params} / #{css_value(alpha)}" if alpha
    fallback = fallback&.css(alpha: fallback_alpha)

    if fallback
      "device-cmyk(#{params}, #{fallback})"
    else
      "device-cmyk(#{params})"
    end
  end
end
