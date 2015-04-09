# A Packed RGB Color oject
class Color::PackedRGB
  include Color

  def initialize(packed_rgb)
    @packed_rgb = packed_rgb
  end


  # Unpacks the decimal rgb into an standard RGB color
  #
  #   Color::Packedrgb(-6306817)
  def to_rgb
    alpha = (@packed_rgb >> 24) & 0xFF
    red   = (@packed_rgb >> 16) & 0xFF
    green = (@packed_rgb >> 8) & 0xFF
    blue  = @packed_rgb & 0xFF

    Color::RGB.new(red, green, blue)
  end

  # Return the raw packed rgb value
  #
  #   Color::PackedRGB(-6306817).packed_rgb
  def packed_rgb
    @packed_rgb
  end

end
