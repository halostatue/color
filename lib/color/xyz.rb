class Color::XYZ
  include Color

  def self.d65_reference_white
    @d65_reference_white ||= new(95.047, 100.00, 108.883)
  end

  attr_reader :x, :y, :z

  def initialize(x, y, z, radix = 100.0)
    @x, @y, @z = [x, y, z].map {|v| v / radix }
  end

  def [](component)
    case component.to_s
    when 'x' then @x
    when 'y' then @y
    when 'z' then @z
    else nil
    end
  end

  def scale3(xm, ym, zm)
    Color::XYZ.new(@x * xm, @y * ym, @z * zm, 1)
  end

  def to_a
    [@x, @y, @z]
  end

  def to_lab(reference_white = Color::XYZ.d65_reference_white)
    # Calculate the ratio of the XYZ values to the reference white.
    # http://www.brucelindbloom.com/index.html?Equations.html
    rel = scale3(1.0 / reference_white.x, 1.0 / reference_white.y, 1.0 / reference_white.z)

    # NOTE: This should be using Rational instead of floating point values,
    # otherwise there will be discontinuities.
    # http://www.brucelindbloom.com/LContinuity.html
    epsilon = (216 / 24389.0)
    kappa   = (24389 / 27.0)

    # And now transform
    # http://en.wikipedia.org/wiki/Lab_color_space#Forward_transformation
    # There is a brief explanation there as far as the nature of the calculations,
    # as well as a much nicer looking modeling of the algebra.
    f = rel.map { |t|
      if (t > (epsilon))
        t ** (1.0 / 3)
      else # t <= epsilon
        ((kappa * t) + 16) / 116.0
        # The 4/29 here is for when t = 0 (black). 4/29 * 116 = 16, and 16 -
        # 16 = 0, which is the correct value for L* with black.
#       ((1.0/3)*((29.0/6)**2) * t) + (4.0/29)
      end
    }
    Color::LAB.new(
      (116 * f.y) - 16,
      500 * (f.x - f.y),
      200 * (f.y - f.z))
  end

  def to_rgb
    linear = Color::RGB.new(
      ( @x * 3.24045483602140870 - @y * 1.53713885010257500 - @z * 0.49853154686848090),
      (-@x * 0.96926638987565370 + @y * 1.87601092884249100 + @z * 0.04155608234667354),
      ( @x * 0.05564341960421365 - @y * 0.20402585426769812 + @z * 1.05722516245792870),
      1)

    # sRGB companding from linear values
    rgb = linear.map { |v|
      if v > 0.0031308
        1.055 * (v ** (1/2.4)) - 0.055
      else
        v * 12.92
      end
    }
  end

  def to_s
    "xyz(#{@x}, #{@y}, #{@z})"
  end
end
