# :title: Color -- Colour Management with Ruby
# :main: README.rdoc

# = Colour Management with Ruby
module Color
  COLOR_VERSION = '2.0pre0'

  class RGB; end
  class CMYK; end
  class HSL; end
  class GrayScale; end
  class LAB; end
  class XYZ; end
  class YIQ; end

  # The maximum "resolution" for colour math; if any value is less than or
  # equal to this value, it is treated as zero.
  COLOR_EPSILON = 1e-5
  # The tolerance for comparing the components of two colours. In general,
  # colours are considered equal if all of their components are within this
  # tolerance value of each other.
  COLOR_TOLERANCE = 1e-4

  # Compares the +other+ colour to this one. The +other+ colour will be
  # coerced to the same type as the current colour. Such converted colour
  # comparisons will always be more approximate than non-converted
  # comparisons.
  #
  # If the +other+ colour cannot be coerced to the current colour class, a
  # +NoMethodError+ exception will be raised.
  #
  # All values are compared as floating-point values, so two colours will be
  # reported equivalent if all component values are within COLOR_TOLERANCE
  # of each other.
  def ==(other)
    Color.equivalent?(self, other)
  end

  # The primary name for the colour.
  def name
    names.first
  end

  # All names for the colour.
  def names
    self.names = nil unless defined? @names
    @names
  end
  def names=(n) # :nodoc:
    @names = Array(n).flatten.compact.map { |e| e.to_s.downcase }.sort.uniq
  end
  alias_method :name=, :names=

  # Apply block to every color component, returning new color
  def map(&block)
    self.class.new *to_a.map(&block), 1
  end

  # Scale color components returning new color. If one argument
  # given every component is multiplied by that factor.
  # Or each component may be given it's own factor:
  #   rgb.scale(0, 0.5, 2) -> red = 0, green / 2, blue * 2
  def scale(*factors)
    if factors.size == 1
      map {|v| v * factors.first }
    else
      new_components = to_a.zip(factors).map {|c, f| c * f }
      self.class.new *new_components, 1
    end
  end
end

class << Color
  # Returns +true+ if the value is less than COLOR_EPSILON.
  def near_zero?(value)
    (value.abs <= Color::COLOR_EPSILON)
  end

  # Returns +true+ if the value is within COLOR_EPSILON of zero or less than
  # zero.
  def near_zero_or_less?(value)
    (value < 0.0 or near_zero?(value))
  end

  # Returns +true+ if the value is within COLOR_EPSILON of one.
  def near_one?(value)
    near_zero?(value - 1.0)
  end

  # Returns +true+ if the value is within COLOR_EPSILON of one or more than
  # one.
  def near_one_or_more?(value)
    (value > 1.0 or near_one?(value))
  end

  # Returns +true+ if the two values provided are near each other.
  def near?(x, y)
    (x - y).abs <= Color::COLOR_TOLERANCE
  end

  # Returns +true+ if the two colours are roughly equivalent. If colour
  # conversions are required, this all conversions will be implemented
  # using the default conversion mechanism.
  def equivalent?(a, b)
    a.to_a.zip(a.coerce(b).to_a).all? { |(x, y)| near?(x, y) }
  end

  # Coerces, if possible, the second given colour object to the first
  # given colour object type. This will probably involve colour
  # conversion and therefore a loss of fidelity.
  def coerce(a, b)
    a.coerce(b)
  end

  # Normalizes the value to the range (0.0) .. (1.0).
  def normalize(value)
    if near_zero_or_less? value
      0.0
    elsif near_one_or_more? value
      1.0
    else
      value
    end
  end
  alias_method :normalize_fractional, :normalize

  # Normalizes the value to the specified range.
  def normalize_to_range(value, range)
    range = (range.end..range.begin) if (range.end < range.begin)

    if value <= range.begin
      range.begin
    elsif value >= range.end
      range.end
    else
      value
    end
  end

  # Normalize the value to the range (0) .. (255).
  def normalize_byte(value)
    normalize_to_range(value, 0..255).to_i
  end
  alias_method :normalize_8bit, :normalize_byte

  # Normalize the value to the range (0) .. (65535).
  def normalize_word(value)
    normalize_to_range(value, 0..65535).to_i
  end
  alias_method :normalize_16bit, :normalize_word
end

require 'color/rgb'
require 'color/cmyk'
require 'color/grayscale'
require 'color/hsl'
require 'color/lab'
require 'color/xyz'
require 'color/yiq'
require 'color/css'
