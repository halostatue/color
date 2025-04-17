# frozen_string_literal: true

##
# \Grayscale is a color object representing shades of gray as a ratio of black to white,
# where 0% (0.0) gray is black and 100% (1.0) gray is white.
#
# \Grayscale colors are immutable Data class instances. Array deconstruction is `[gray]`
# and hash deconstruction is `{g:, gray:}`. See #g, #gray.
class Color::Grayscale
  include Color

  ##
  # :attr_reader: brightness
  # Returns the grayscale value as a proportion of white (0.0 .. 1.0).

  ##
  # :attr_reader: g
  # Returns the grayscale value as a proportion of white (0.0 .. 1.0).

  ##
  # :attr_reader: gray
  # Returns the grayscale value as a percentage of white (0.0 .. 100.0).

  ##
  # Creates a grayscale color object from a percentage value (0.0 .. 100.0).
  #
  # ```ruby
  # Color::Grayscale.from_percentage(50) # => Grayscale [0.50%]
  # Color::Grayscale.from_values(50) # => Grayscale [0.50%]
  # ```
  #
  # :call-seq:
  #   from_percentage(g)
  #   from_percentage(g:)
  #   from_values(g)
  #   from_values(g:)
  def self.from_percentage(*args, **kwargs)
    g =
      case [args, kwargs]
      in [[g], {}]
        g
      in [[], {g:}]
        g
      else
        new(*args, **kwargs)
      end

    new(g: g / 100.0)
  end

  class << self
    alias_method :from_values, :from_percentage
    alias_method :from_fraction, :new
    alias_method :from_internal, :from_fraction # :nodoc:
  end

  ##
  # Creates a grayscale color object from a fractional value (0.0 .. 1.0).
  #
  # ```ruby
  # Color::Grayscale.from_fraction(0.5)
  # Color::Grayscale.new(0.5)
  # Color::Grayscale[g: 0.5]
  # ```
  def initialize(g:)
    super(g: normalize(g))
  end

  ##
  # Coerces the other Color object to grayscale.
  def coerce(other) = other.to_grayscale

  ##
  # Convert \Grayscale to Color::CMYK.
  def to_cmyk(...) = Color::CMYK.from_fraction(0, 0, 0, 1.0 - g.to_f)

  ##
  # Convert \Grayscale to Color::RGB.
  def to_rgb(...) = Color::RGB.from_fraction(g, g, g)

  ##
  def to_grayscale(...) = self

  ##
  # Convert \Grayscale to Color::YIQ.
  #
  # This approximates the actual value, as I and Q are calculated by treating the
  # grayscale value as a RGB value. The Y (intensity or brightness) value is the same as
  # the grayscale value.
  def to_yiq(...)
    y = g
    i = (g * 0.596) + (g * -0.275) + (g * -0.321)
    q = (g * 0.212) + (g * -0.523) + (g * 0.311)
    Color::YIQ.from_fraction(y, i, q)
  end

  ##
  # Converts \Grayscale to Color::HSL.
  def to_hsl(...) = Color::HSL.from_fraction(0, 0, g)

  ##
  # Converts \Grayscale to Color::CIELAB via Color::RGB.
  def to_lab(...) = to_rgb(...).to_lab(...)

  ##
  # Present the color as an HTML/CSS color string (e.g., `#dddddd`).
  def html
    "##{("%02x" % translate_range(g, to: 0.0..255.0)) * 3}"
  end

  ##
  # Present the color as a CSS `rgb` color with optional `alpha`.
  #
  # ```ruby
  # Color::Grayscale[0.5].css               # => rgb(50.00% 50.00% 50.00%)
  # Color::Grayscale[0.5].css(alpha: 0.75)  # => rgb(50.00% 50.00% 50.00% / 0.75)
  # ```
  def css(alpha: nil)
    params = ([css_value(gray, :percent)] * 3).join(" ")
    params = "#{params} / #{css_value(alpha)}" if alpha

    "rgb(#{params})"
  end

  ##
  # Lightens the grayscale color by the stated percent.
  def lighten_by(percent) = Color::Grayscale.from_fraction([g + (g * (percent / 100.0)), 1.0].min)

  ##
  # Darken the grayscale color by the stated percent.
  def darken_by(percent) = Color::Grayscale.from_fraction([g - (g * (percent / 100.0)), 0.0].max)

  ##
  alias_method :brightness, :g

  ##
  def gray = g * 100.0

  ##
  def inspect = "Grayscale [%.2f%%]" % [gray] # :nodoc:

  ##
  def pretty_print(q) # :nodoc:
    q.text "Grayscale"
    q.breakable
    q.group 2, "[", "]" do
      q.text "%.2f%%" % gray
    end
  end

  ##
  def to_a = [gray] # :nodoc:

  ##
  alias_method :deconstruct, :to_a

  ##
  def deconstruct_keys(_keys) = {g:, gray:}

  ##
  def to_internal = [g] # :nodoc:

  ##
  def components = 1 # :nodoc:
end
