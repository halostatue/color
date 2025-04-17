# frozen_string_literal: true

# A \Color object representing YIQ (NTSC) color encoding, where Y is the luma
# (brightness) value, and I (orange-blue) and Q (purple-green) are chrominance.
#
# All values are clamped between 0 and 1 inclusive.
#
# More more details, see [YIQ][wikiyiq].
#
# [wikiyiq]: https://en.wikipedia.org/wiki/YIQ
#
# \YIQ colors are immutable Data class instances. Array deconstruction is `[y, i, q]` and
# hash deconstruction is `{y:, i:, q:}` (see #y, #i, #q).
#
# \YIQ is only partially implemented: other \Color objects can only be converted _to_
# \YIQ, but it has few conversion functions for converting _from_ \YIQ.
class Color::YIQ
  include Color

  ##
  # :attr_reader: y
  # The `y` (luma) attribute of this \YIQ color expressed as a value 0..1.

  ##
  # :attr_reader: i
  # The `i` (orange-blue chrominance) attribute of this \YIQ color expressed as a value
  # 0..1.

  ##
  # :attr_reader: q
  # The `q` (purple-green chrominance) attribute of this \YIQ color expressed as a value
  # 0..1.

  ##
  # Creates a YIQ color object from percentage values 0 .. 1.
  #
  # ```ruby
  # Color::YIQ.from_percentage(30, 20, 10)            # => YIQ [30% 20% 10%]
  # Color::YIQ.from_percentage(y: 30, i: 20, q: 10)   # => YIQ [30% 20% 10%]
  # Color::YIQ.from_values(30, 20, 10)                # => YIQ [30% 20% 10%]
  # Color::YIQ.from_values(y: 30, i: 20, q: 10)       # => YIQ [30% 20% 10%]
  # ```
  def self.from_percentage(*args, **kwargs)
    y, i, q =
      case [args, kwargs]
      in [[_, _, _], {}]
        args
      in [[], {y:, i:, q:}]
        [y, i, q]
      else
        new(*args, **kwargs)
      end

    new(y: y / 100.0, i: i / 100.0, q: q / 100.0)
  end

  class << self
    alias_method :from_values, :from_percentage
    alias_method :from_fraction, :new # :nodoc:
    alias_method :from_internal, :new
  end

  ##
  # Creates a YIQ color object from fractional values 0 .. 1.
  #
  # ```ruby
  # Color::YIQ.from_fraction(0.3, 0.2, 0.1)   # => YIQ [30% 20% 10%]
  # Color::YIQ.new(0.3, 0.2, 0.1)             # => YIQ [30% 20% 10%]
  # Color::YIQ[y: 0.3, i: 0.2, q: 0.1]        # => YIQ [30% 20% 10%]
  # ```
  def initialize(y:, i:, q:) # :nodoc:
    super(y: normalize(y), i: normalize(i), q: normalize(q))
  end

  ##
  # Coerces the other Color object into \YIQ.
  def coerce(other) = other.to_yiq

  ##
  def to_yiq = self

  ##
  # Convert \YIQ to Color::Grayscale using the luma (#y) value.
  def to_grayscale = Color::Grayscale.from_fraction(y)

  ##
  alias_method :brightness, :y

  def inspect = "YIQ [%.2f%% %.2f%% %.2f%%]" % [y * 100, i * 100, q * 100] # :nodoc:

  def pretty_print(q) # :nodoc:
    q.text "YIQ"
    q.breakable
    q.group 2, "[", "]" do
      q.text "%.2f%%" % y
      q.fill_breakable
      q.text "%.2f%%" % i
      q.fill_breakable
      q.text "%.2f%%" % q
    end
  end

  alias_method :to_a, :deconstruct # :nodoc:
  alias_method :to_internal, :deconstruct # :nodoc:

  def deconstruct_keys(_keys) = {y:, i:, q:} # :nodoc:
end
