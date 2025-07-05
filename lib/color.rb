# frozen_string_literal: true

# # \Color -- \Color Math in Ruby
#
# - **code**: [github.com/halostatue/color](https://github.com/halostatue/color)
# - **issues**: [github.com/halostatue/color/issues](https://github.com/halostatue/color/issues)
# - **changelog**: [CHANGELOG](rdoc-ref:CHANGELOG.md)
#
# \Color is a Ruby library to provide RGB, CMYK, HSL, and other color space manipulation
# support to applications that require it. It provides optional named RGB colors that are
# commonly supported in HTML, SVG, and X11 applications.
#
# The \Color library performs purely mathematical manipulation of the colors based on
# color theory without reference to device color profiles (such as sRGB or Adobe RGB). For
# most purposes, when working with RGB and HSL color spaces, this won't matter. Absolute
# color spaces (like CIE LAB and CIE XYZ) cannot be reliably converted to relative color
# spaces (like RGB) without color profiles. When necessary for conversions, \Color
# provides \D65 and \D50 reference white values in Color::XYZ.
#
# Color 2.0 is a major release, dropping support for all versions of Ruby prior to 3.2 as
# well as removing or renaming a number of features. The main breaking changes are:
#
# - Color classes are immutable Data objects; they are no longer mutable.
# - RGB named colors are no longer loaded on gem startup, but must be required explicitly
#   (this is _not_ done via `autoload` because there are more than 100 named colors with
#   spelling variations) with `require "color/rgb/colors"`.
# - Color palettes have been removed.
# - `Color::CSS` and `Color::CSS#[]` have been removed.
module Color
  ##
  # The maximum "resolution" for color math; if any value is less than or equal to this
  # value, it is treated as zero.
  EPSILON = 1e-5

  ##
  # The tolerance for comparing the components of two colors. In general, colors are
  # considered equal if all of their components are within this tolerance value of each
  # other.
  TOLERANCE = 1e-4

  # :stopdoc:
  CIELAB = Data.define(:l, :a, :b)
  CMYK = Data.define(:c, :m, :y, :k)
  Grayscale = Data.define(:g)
  HSL = Data.define(:h, :s, :l)
  RGB = Data.define(:r, :g, :b, :names)
  XYZ = Data.define(:x, :y, :z)
  YIQ = Data.define(:y, :i, :q)
  # :startdoc:

  ##
  # It is useful to know the number of components in some cases. Since most colors are
  # defined with three components, we define a constant value here. Color classes that
  # require more or less should override this.
  #
  # We _could_ define this as `members.count`, but this would require a special case
  # for Color::RGB _regardless_ because there's an additional member for RGB colors
  # (names).
  def components = 3 # :nodoc:

  ##
  # Compares the `other` color to this one. The `other` color will be coerced to the same
  # type as the current color. Such converted color comparisons will always be more
  # approximate than non-converted comparisons.
  #
  # All values are compared as floating-point values, so two colors will be reported
  # equivalent if all component values are within +TOLERANCE+ of each other.
  def ==(other)
    other.is_a?(Color) && to_internal.zip(coerce(other).to_internal).all? { near?(_1, _2) }
  end

  ##
  # Apply the provided block to each color component in turn, returning a new color
  # instance.
  def map(&block) = self.class.from_internal(*to_internal.map(&block))

  ##
  # Apply the provided block to the color component pairs in turn, returning a new color
  # instance.
  def map_with(other, &block) = self.class.from_internal(*zip(other).map(&block))

  ##
  # Zip the color component pairs together.
  def zip(other) = to_internal.zip(coerce(other).to_internal)

  ##
  # Multiplies each component value by the scaling factor or factors, returning a new
  # color object with the scaled values.
  #
  # If a single scaling factor is provided, it is applied to all components:
  #
  # ```ruby
  # rgb = Color::RGB::Wheat # => RGB [#f5deb3]
  # rgb.scale(0.75)         # => RGB [#b8a786]
  # ```
  #
  # If more than one scaling factor is provided, there must be exactly one factor for each
  # color component of the color object or an `ArgumentError` will be raised.
  #
  # ```ruby
  # rgb = Color::RGB::Wheat # => RGB [#f5deb3]
  # # 0xf5 * 0 == 0x00, 0xde * 0.5 == 0x6f, 0xb3 * 2 == 0x166 (clamped to 0xff)
  # rgb.scale(0, 0.5, 2)    # => RGB [#006fff]
  #
  # rgb.scale(1, 2) # => Invalid scaling factors [1, 2] for Color::RGB (ArgumentError)
  # ```
  def scale(*factors)
    if factors.size == 1
      factor = factors.first
      map { _1 * factor }
    elsif factors.size != components
      raise ArgumentError, "Invalid scaling factors #{factors.inspect} for #{self.class}"
    else
      new_components = to_internal.zip(factors).map { _1 * _2 }
      self.class.from_internal(*new_components)
    end
  end

  ##
  def css_value(value, format = nil) # :nodoc:
    if value.nil?
      "none"
    elsif near_zero?(value)
      "0"
    else
      suffix =
        case format
        in :percent
          "%"
        in :degrees
          "deg"
        else
          ""
        end

      "%3.2f%s" % [value, suffix]
    end
  end

  private

  ##
  def from_internal(...) = self.class.from_internal(...)

  ##
  # Returns `true` if the value is less than EPSILON.
  def near_zero?(value) = (value.abs <= Color::EPSILON) # :nodoc:

  ##
  # Returns `true` if the value is within EPSILON of zero or less than zero.
  def near_zero_or_less?(value) = (value < 0.0 or near_zero?(value)) # :nodoc:

  ##
  # Returns +true+ if the value is within EPSILON of one.
  def near_one?(value) = near_zero?(value - 1.0) # :nodoc:

  ##
  # Returns +true+ if the value is within EPSILON of one or more than one.
  def near_one_or_more?(value) = (value > 1.0 or near_one?(value)) # :nodoc:

  ##
  # Returns +true+ if the two values provided are near each other.
  def near?(x, y) = (x - y).abs <= Color::TOLERANCE # :nodoc:

  ##
  def to_degrees(radians) # :nodoc:
    if radians < 0
      (Math::PI + radians % -Math::PI) * (180 / Math::PI) + 180
    else
      (radians % Math::PI) * (180 / Math::PI)
    end
  end

  ##
  def to_radians(degrees) # :nodoc:
    degrees = ((degrees % 360) + 360) % 360
    if degrees >= 180
      Math::PI * (degrees - 360) / 180.0
    else
      Math::PI * degrees / 180.0
    end
  end

  ##
  # Normalizes the value to the range (0.0) .. (1.0).
  module_function def normalize(value, range = 0.0..1.0) # :nodoc:
    value = value.clamp(range)
    if near?(value, range.begin)
      range.begin
    elsif near?(value, range.end)
      range.end
    else
      value
    end
  end

  ##
  # Translates a value from range `from` to range `to`. Both ranges must be closed.
  # As 0.0 .. 1.0 is a common internal range, it is the default for `from`.
  #
  # This is based on the formula:
  #
  #     [a, b] ← from ← [from.begin, from.end]
  #     [c, d] ← to ← [to.begin, to.end]
  #
  #     y = (((x - a) * (d - c)) / (b - a)) + c
  #
  # The value is clamped to the values of `to`.
  module_function def translate_range(x, to:, from: 0.0..1.0) # :nodoc:
    a, b = [from.begin, from.end]
    c, d = [to.begin, to.end]
    y = (((x - a) * (d - c)) / (b - a)) + c
    y.clamp(to)
  end

  ##
  # Normalizes the value to the specified range.
  def normalize_to_range(value, range) # :nodoc:
    range = (range.end..range.begin) if range.end < range.begin

    if value <= range.begin
      range.begin
    elsif value >= range.end
      range.end
    else
      value
    end
  end

  ##
  # Normalize the value to the range (0) .. (255).
  def normalize_byte(value) = normalize_to_range(value, 0..255).to_i # :nodoc:

  ##
  # Normalize the value to the range (0) .. (65535).
  def normalize_word(value) = normalize_to_range(value, 0..65535).to_i # :nodoc:
end

require "color/cmyk"
require "color/grayscale"
require "color/hsl"
require "color/cielab"
require "color/rgb"
require "color/xyz"
require "color/yiq"

require "color/version"
