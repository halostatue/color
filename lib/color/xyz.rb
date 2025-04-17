# frozen_string_literal: true

##
# A \Color object for the CIE 1931 \XYZ color space derived from the original CIE \RGB
# color space as linear transformation functions x̅(λ), y̅(λ), and z̅(λ) that describe the
# device-independent \CIE standard observer. It underpins most other CIE color systems
# (such as \CIELAB), but is directly used mostly for color instrument readings and color
# space transformations particularly in color profiles.
#
# The \XYZ color space ranges describe the mixture of wavelengths of light required to
# stimulate cone cells in the human eye, as well as the luminance (brightness) required.
# The `Y` component describes the luminance while the `X` and `Z` components describe two
# axes of chromaticity. Definitionally, the minimum value for any \XYZ color component is
# 0.
#
# As \XYZ describes imaginary colors, the color gamut is usually expressed in relation to
# a reference white of an illuminant (frequently often D65 or D50) and expressed as the
# `xyY` color space, computed as:
#
# ```
# x = X / (X + Y + Z)
# y = Y / (X + Y + Z)
# Y = Y
# ```
#
# The range of `Y` values is conventionally clamped to 0..100, whereas the `X` and `Z`
# values must be no lower than 0 and on the same scale.
#
# For more details, see [CIE XYZ color space][ciexyz].
#
# [ciexyz]: https://en.wikipedia.org/wiki/CIE_1931_color_space#CIE_XYZ_color_space
#
# \XYZ colors are immutable Data class instances. Array deconstruction is `[x * 100,
# y * 100, z * 100]` and hash deconstruction is `{x:, y:, z:}` (see #x, #y, #z).
class Color::XYZ
  include Color

  ##
  # :attr_reader: x
  # The X attribute of this \XYZ color object expressed as a value scaled to #y.

  ##
  # :attr_reader: y
  # The Y attribute of this \XYZ color object expressed as a value 0..1.

  ##
  # :attr_reader: z
  # The Z attribute of this \XYZ color object expressed as a value scaled to #y.

  ##
  # Creates a \XYZ color representation from native values. `y` must be between 0 and 100
  # and `x` and `z` values must be scaled to `y`.
  #
  # ```ruby
  # Color::XYZ.from_values(95.047, 100.00, 108.883)
  # Color::XYZ.from_values(x: 95.047, y: 100.00, z: 108.883)
  # ```
  #
  # call-seq:
  #   Color::XYZ.from_values(x, y, z)
  #   Color::XYZ.from_values(x:, y:, z:)
  def self.from_values(*args, **kwargs)
    x, y, z =
      case [args, kwargs]
      in [[_, _, _], {}]
        args
      in [[], {x:, y:, z:}]
        [x, y, z]
      else
        new(*args, **kwargs)
      end

    new(x: x / 100.0, y: y / 100.0, z: z / 100.0)
  end

  class << self
    alias_method :from_fraction, :new
    alias_method :from_internal, :new # :nodoc:
  end

  ##
  # Creates a \XYZ color representation from native values. The `y` value must be between
  # 0 and 1 and `x` and `z` must be fractional valiues greater than or equal to 0.
  #
  # ```ruby
  # Color::XYZ.from_fraction(0.95047, 1.0, 1.0.883)
  # Color::XYZ.new(0.95047, 1.0, 1.08883)
  # Color::XYZ[x: 0.95047, y: 1.0, z: 1.08883]
  # ```
  def initialize(x:, y:, z:)
    super(
      x: normalize(x, 0.0..1.0),
      y: normalize(y),
      z: normalize(z, 0.0..1.0)
    )
  end

  # :stopdoc:
  # NOTE: This should be using Rational instead of floating point values,
  # otherwise there will be discontinuities.
  # http://www.brucelindbloom.com/LContinuity.html
  # :startdoc:

  E = 216r/24389r # :nodoc:
  K = 24389r/27r # :nodoc:
  EK = E * K # :nodoc:

  # The D65 standard illuminant white point
  D65 = new(0.95047, 1.0, 1.08883)

  # The D50 standard illuminant white point
  D50 = new(0.96421, 1.0, 0.82521)

  ##
  # Coerces the other Color object into \XYZ.
  def coerce(other) = other.to_xyz

  ##
  def to_xyz(...) = self

  ##
  # Converts \XYZ to Color::CMYK via Color::RGB.
  #
  # See #to_rgb and Color::RGB#to_cmyk.
  def to_cmyk(...) = to_rgb(...).to_cmyk(...)

  ##
  # Converts \XYZ to Color::Grayscale using the #y value
  def to_grayscale(...) = Color::Grayscale.from_fraction(y)

  ##
  # Converts \XYZ to Color::HSL via Color::RGB.
  #
  # See #to_rgb and Color::RGB#to_hsl.
  def to_hsl(...) = to_rgb(...).to_hsl(...)

  ##
  # Converts \XYZ to Color::YIQ via Color::RGB.
  #
  # See #to_rgb and Color::RGB#to_yiq.
  def to_yiq(...) = to_rgb(...).to_yiq(...)

  ##
  # Converts \XYZ to Color::CIELAB.
  #
  # :call-seq:
  #   to_lab(white: Color::XYZ::D65)
  def to_lab(*args, **kwargs)
    ref = kwargs[:white] || args.first || Color::XYZ::D65
    # Calculate the ratio of the XYZ values to the reference white.
    # http://www.brucelindbloom.com/index.html?Equations.html
    rel = scale(1.0 / ref.x, 1.0 / ref.y, 1.0 / ref.z)

    # And now transform
    # http://en.wikipedia.org/wiki/Lab_color_space#Forward_transformation
    # There is a brief explanation there as far as the nature of the calculations,
    # as well as a much nicer looking modeling of the algebra.
    f = rel.map { |t|
      if t > E
        t**(1.0 / 3)
      else # t <= E
        ((K * t) + 16) / 116.0
        # The 4/29 here is for when t = 0 (black). 4/29 * 116 = 16, and 16 -
        # 16 = 0, which is the correct value for L* with black.
        #       ((1.0/3)*((29.0/6)**2) * t) + (4.0/29)
      end
    }
    Color::CIELAB.from_values(
      (116 * f.y) - 16,
      500 * (f.x - f.y),
      200 * (f.y - f.z)
    )
  end

  ##
  # Converts \XYZ to Color::RGB.
  #
  # This always assumes an sRGB target color space and a D65 white point.
  def to_rgb(...)
    # sRGB companding from linear values
    linear = [
      x * 3.2406255 + y * -1.5372080 + z * -0.4986286,
      x * -0.9689307 + y * 1.8757561 + z * 0.0415175,
      x * 0.0557101 + y * -0.2040211 + z * 1.0569959
    ].map {
      if _1.abs <= 0.0031308
        _1 * 12.92
      else
        1.055 * (_1**(1 / 2.4)) - 0.055
      end
    }

    Color::RGB.from_fraction(*linear)
  end

  def deconstruct = [x * 100.0, y * 100.0, z * 100.0] # :nodoc:
  alias_method :to_a, :deconstruct # :nodoc:

  def to_internal = [x, y, z] # :nodoc:

  def inspect = "XYZ [#{x} #{y} #{z}]" # :nodoc:

  def pretty_print(q) # :nodoc:
    q.text "XYZ"
    q.breakable
    q.group 2, "[", "]" do
      q.text "%.4f" % x
      q.fill_breakable
      q.text "%.4f" % y
      q.fill_breakable
      q.text "%.4f" % z
    end
  end
end
