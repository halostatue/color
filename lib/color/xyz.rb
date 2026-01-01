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
  # Color::XYZ.from_fraction(0.95047, 1.0, 1.0883)
  # Color::XYZ.new(0.95047, 1.0, 1.08883)
  # Color::XYZ[x: 0.95047, y: 1.0, z: 1.08883]
  # ```
  def initialize(x:, y:, z:)
    # The X and Z values in the XYZ color model are technically unbounded. With Y scaled
    # to 1.0, we will clamp X to 0.0..2.2 and Z to 0.0..2.8.

    super(
      x: normalize(x, 0.0..2.2),
      y: normalize(y),
      z: normalize(z, 0.0..2.8)
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

  ##
  # White points for standard illuminants at 2° (CIE 1931).
  WP2 = {
    A: new(1.09849161234507, 1.0, 0.355798257454902),
    B: new(0.9909274480248, 1.0, 0.853132732288615),
    C: new(0.980705971659919, 1.0, 1.18224949392713),
    D50: new(0.964211994421199, 1.0, 0.825188284518828),
    D55: new(0.956797052643698, 1.0, 0.921480586017327),
    D65: new(0.950430051970945, 1.0, 1.08880649180926),
    D75: new(0.949722089884072, 1.0, 1.22639352072415),
    D93: new(0.953014035205816, 1.0, 1.41274275520851),
    E: new(1, 1.0, 1.0000300003),
    F1: new(0.92833634773327, 1.0, 1.03664719660806),
    F2: new(0.991446614618029, 1.0, 0.673159423379253),
    F3: new(1.03753487192493, 1.0, 0.49860512300279),
    F4: new(1.0914726375561, 1.0, 0.388132609288601),
    F5: new(0.908719701138108, 1.0, 0.987228866815325),
    F6: new(0.973091283635895, 1.0, 0.601905497618128),
    F7: new(0.950171560440895, 1.0, 1.08629642000425),
    F8: new(0.96412543554007, 1.0, 0.823331010452962),
    F9: new(1.00364797081623, 1.0, 0.678683511708377),
    F10: new(0.961735119213027, 1.0, 0.817123325737787),
    F11: new(1.00898894280487, 1.0, 0.642616604353936),
    F12: new(1.08046289656537, 1.0, 0.392275166291635),
    "FL3.0": new(1.09273493677163, 1.0, 0.3868088271758),
    "FL3.1": new(1.01981788966256, 1.0, 0.658275307980718),
    "FL3.2": new(0.916836289619075, 1.0, 0.990985751671998),
    "FL3.3": new(1.09547365817462, 1.0, 0.377937175364828),
    "FL3.4": new(1.02096949891068, 1.0, 0.702342047930283),
    "FL3.5": new(0.968888888888889, 1.0, 0.808888888888889),
    "FL3.6": new(1.08380716934487, 1.0, 0.388380716934487),
    "FL3.7": new(0.996868475991649, 1.0, 0.612734864300626),
    "FL3.8": new(0.974380395433027, 1.0, 0.810359231411863),
    "FL3.9": new(0.970505617977528, 1.0, 0.838483146067416),
    "FL3.10": new(0.944962143273151, 1.0, 0.967093768200349),
    "FL3.11": new(1.08422095615556, 1.0, 0.392865989596235),
    "FL3.12": new(1.02846401718582, 1.0, 0.656820622986037),
    "FL3.13": new(0.955112219451372, 1.0, 0.815738431698531),
    "FL3.14": new(0.951034063260341, 1.0, 1.09032846715328),
    HP1: new(1.28433734939759, 1.0, 0.125301204819277),
    HP2: new(1.14911014911015, 1.0, 0.255892255892256),
    HP3: new(1.05570552147239, 1.0, 0.398282208588957),
    HP4: new(1.00395048722676, 1.0, 0.62970766394522),
    HP5: new(1.01696741179639, 1.0, 0.676272555884729),
    "LED-B1": new(1.11819519372241, 1.0, 0.3339872486513),
    "LED-B2": new(1.08599202392822, 1.0, 0.406530408773679),
    "LED-B3": new(1.0088638195004, 1.0, 0.677142089712597),
    "LED-B4": new(0.977155910908053, 1.0, 0.87835522558538),
    "LED-B5": new(0.963535228677379, 1.0, 1.12669962917182),
    "LED-BH1": new(1.10034431874078, 1.0, 0.359075258239056),
    "LED-RGB1": new(1.08216575635241, 1.0, 0.292567086202802),
    "LED-V1": new(1.12462908011869, 1.0, 0.348170128585559),
    "LED-V2": new(1.00158940397351, 1.0, 0.647417218543046),
    ID50: new(0.952803997779012, 1.0, 0.823431426985008),
    ID65: new(0.939522225582099, 1.0, 1.08436649531297)
  }.freeze

  ##
  # The D50 standard illuminant white point at 2° (CIE 1931).
  D50 = WP2[:D50]

  ##
  # The D65 standard illuminant white point at 2° (CIE 1931).
  D65 = WP2[:D65]

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
    # https://en.wikipedia.org/wiki/Lab_color_space#Forward_transformation
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
      if _1 <= 0.0031308
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
