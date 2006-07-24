class Color
  
  attr_accessor :rgb
  attr_accessor :hue
  attr_accessor :saturation
  attr_accessor :lightness
    
  def initialize(values, mode=:rgb)
    @rgb = case mode
    when :hsl
      Color.hsl_to_rgb(values)
    when :rgb
      values = [values].flatten
      case values.size
      when 1
        Color.rgbhex_to_rgb(values.first.sub(/#/,''))
      else
        values
      end
    when :cmyk
      Color.cmyk_to_rgb(values)
    end
    @rgb.each {|n| n.coerce(0).max.coerce(255).min }
    @hue, @saturation, @lightness = Color.rgb_to_hsl(@rgb)
  end
  
  def hue=(value)
    @hue = value
    @hue += 1 if @hue < 0 # color is _perceived_ as a wheel, not a continuum
    @hue -= 1 if @hue > 1
    @rgb = Color.hsl_to_rgb(self.hsl)
  end
  
  def saturation=(value)
    @saturation = value.coerce(0.0).max.coerce(1.0).min
    @rgb = Color.hsl_to_rgb(self.hsl)
  end
  
  def lightness=(value)
    @lightness = value.coerce(0.0).max.coerce(1.0).min
    @rgb = Color.hsl_to_rgb(self.hsl)
  end
  
  def mix_with(color, percent_as_decimal)
    target = color.to_hsl
    deltas = []
    self.hsl.each_with_index {|val, i| deltas[i] = target[i] - val }
    deltas.collect! {|n| n * percent_as_decimal }
    new_color = []
    deltas.each_with_index {|val, i| new_color[i] = val + self.hsl[i] }
    Color.new(new_color, :hsl)
  end
  
  def hsl
    [@hue, @saturation, @lightness]
  end
  
  alias_method :to_hsl, :hsl
  
  def to_hex
    Color.rgb_to_rgbhex(@rgb)
  end
  
  def to_cmyk
    Color.rgb_to_cmyk(@rgb)
  end
  
  class << self
    
    def rgb_to_rgbhex(rgb=[])
      '#' + rgb.collect {|n| "%02X" % n }.join('').downcase
    end
    
    def rgbhex_to_rgb(value)
      rg, blue = value.sub(/#/,'').hex.divmod(256)
      red, green = rg.divmod(256)
      return red, green, blue
    end
    
    # conversion formulas from http://www.easyrgb.com/math.php
    # They're on Wikipedia too. And elsewhere, really, but the easyrbg ones
    # were most easily translatable to ruby.
    #
    # What's the difference between HSL and HSV? Quite a bit. 
    # Wikipedia knows all:
    #   http://en.wikipedia.org/wiki/HSV_color_space
    #   http://en.wikipedia.org/wiki/HSL_color_space
    #
    # Generally, HSL has a more decoupled notion of saturation and lightness
    # whereas with HSV saturation and value are coupled in such a way as to
    # not behave intuitively. HSV is a bit more mathematically straightforward.
    # 
    # Since the author of this library is an artist and has a personal bias
    # towards HSL, this library reflects that bias and uses HSL internally.   
    # HSL is also part of the CSS3 Color Module, if I haven't convinced you yet.
    
    def rgb_to_hsl(rgb=[])
      r, g, b, min, max, delta = rgb_to_values(rgb)
      lightness = (max + min) / 2.0
      return [0,0,lightness] if delta.zero?  # gray, no chroma
      saturation = (lightness < 0.5) ? (delta / (max + min)) : (delta / (2.0 - max - min))
      hue = figure_hue_for(rgb)
      return hue, saturation, lightness
    end
    
    def hsl_to_rgb(hsl=[])
      h, s, l = hsl
      return [l,l,l].collect {|l| (l * 255.0).to_i } if s.zero?
      v2 = (l < 0.5) ? (l * (1 + s)) : (l + s) - (s * l)
      v1 = 2.0 * l - v2
      rgb = [h+(1/3.0), h, h-(1/3.0)]
      rgb.collect! do |hue|
        hue += 1 if hue < 0
        hue -= 1 if hue > 1
        if (6 * hue) < 1
          v1 + (v2 - v1) * 6 * hue
        elsif (2 * hue) < 1
          v2
        elsif (3 * hue) < 2
          v1 + (v2 - v1) * ((2 / 3.0) - hue) * 6
        else
          v1
        end
      end
      return rgb.collect {|n| (n * 255.0).round }
    end
    
    def rgb_to_hsv(rgb=[])
      r, g, b, min, max, delta = rgb_to_values(rgb)
      value = max
      return [0.0, 0.0, value] if delta.zero? # gray, no chroma
      saturation = delta / max
      hue = figure_hue_for(rgb)
      return hue, saturation, value
    end
        
    def rgb_to_cmyk(rgb=[])
      cmy = rgb.collect {|n| 1 - (n / 255.0)}
      k = cmy.min
      return [0.0,0.0,0.0,1.0] if k == 1.0  # black
      cmy.collect {|n| (n - k) / (1 - k) } << k
    end
    
    def cmyk_to_rgb(cmyk=[])
      c,m,y,k = cmyk
      [c,m,y].collect {|n| ((1 - (n * (1 - k) + k)) * 255.0).to_i }
    end
    
    private
    def rgb_to_float(rgb=[])
      rgb.collect! {|n| n / 255.0 }
      rgb << rgb.min << rgb.max << rgb.max - rgb.min
    end
    
    def figure_hue_for(rgb=[])
      r, g, b, min, max, delta = rgb_to_float(rgb)
      delta_r, delta_g, delta_b = [r,g,b].collect {|n| (((max - n) / 6.0) + (delta / 2.0)) / delta }
      hue = if r.eql? max
        delta_b - delta_g
      elsif g.eql? max
        (1 / 3.0) + delta_r - delta_b
      else # blue
        (2 / 3.0) + delta_g - delta_r
      end
      hue += 1 if hue < 0
      hue -= 1 if hue > 1
      hue
    end
    
  end
  
end