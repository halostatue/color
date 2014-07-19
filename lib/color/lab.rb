class Color::LAB
  include Color

  attr_reader :l, :a, :b

  def initialize(l, a, b, radix = 100)
    @l, @a, @b = [l, a, b]#.map {|v| v / radix }
  end

  def [](component)
    case component.to_s
    when 'l' then @l
    when 'a' then @a
    when 'b' then @b
    else nil
    end
  end

  def to_a
    [@l, @a, @b]
  end

  def to_s
    "lab(#{@l}, #{@a}, #{@b})"
  end

  def to_rgb
    to_xyz.to_rgb
  end

  def to_xyz(reference_white = Color::XYZ.d65_reference_white)
    epsilon = (216 / 24389.0)
    kappa   = (24389 / 27.0)

    fy = (@l + 16.0) / 116
    fz = fy - @b / 200.0
    fx = @a / 500.0 + fy

    xr = if (fx3 = fx ** 3) > epsilon then fx3 else (116.0 * fx - 16) / kappa end
    yr = if @l > kappa * epsilon then ((@l + 16.0) / 116) ** 3 else @l / kappa end
    zr = if (fz3 = fz ** 3) > epsilon then fz3 else (116.0 * fz - 16) / kappa end

    reference_white.scale xr, yr, zr
  end
end
