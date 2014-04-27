# A colour object representing YIQ (NTSC) colour encoding.
class Color::YIQ
  include Color

  # Creates a YIQ colour object from fractional values 0 .. 1.
  #
  #   Color::YIQ.new(0.3, 0.2, 0.1)
  def self.from_fraction(y = 0, i = 0, q = 0, &block)
    new(y, i, q, 1.0, &block)
  end

  # Creates a YIQ colour object from percentages 0 .. 100.
  #
  #   Color::YIQ.new(10, 20, 30)
  def initialize(y = 0, i = 0, q = 0, radix = 100.0, &block) # :yields self:
    @y, @i, @q = [ y, i, q ].map { |v| Color.normalize(v / radix) }
    block.call if block
  end

  def coerce(other)
    other.to_yiq
  end

  def to_yiq
    self
  end

  def brightness
    @y
  end
  def to_grayscale
    Color::GrayScale.new(@y)
  end
  alias to_greyscale to_grayscale

  def y
    @y
  end
  def y=(yy)
    @y = Color.normalize(yy)
  end
  def i
    @i
  end
  def i=(ii)
    @i = Color.normalize(ii)
  end
  def q
    @q
  end
  def q=(qq)
    @q = Color.normalize(qq)
  end

  def inspect
    "YIQ [%.2f%%, %.2f%%, %.2f%%]" % [ @y * 100, @i * 100, @q * 100 ]
  end

  def to_a
    [ y, i, q ]
  end
end
