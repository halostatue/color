# -*- ruby encoding: utf-8 -*-

class Color::RGB
  # Outputs how much contrast this color has with another rgb color.
  # Computes the same regardless of which one is considered foreground. If
  # the other color does not have a to_rgb method, this will throw an
  # exception. Anything over about 0.22 should have a high likelihood of
  # being legible. Otherwise, to be safe go with something > 0.3
  def contrast(other_rgb, algorithm=nil)
    if other_rgb.respond_to? :to_rgb then
      c2 = other_rgb.to_rgb
    else
      raise "Unable to calculate contrast with object #{other_rgb.to_s}"
    end
    if algorithm==:delta_e94 
      Color::LAB.delta_e94(self.to_lab,other_rgb.to_lab )
    elsif algorithm==:delta_e2000 
      Color::LAB.delta_e2000(self.to_lab,other_rgb.to_lab )
    else 
      # The following numbers have been set with some care.
      ((diff_brightness(other_rgb) * 0.65) +
       (diff_hue(other_rgb) * 0.20) +
       (diff_luminosity(other_rgb) * 0.15))
    end 
  end

  # Provides the luminosity difference between two rbg vals
  def diff_luminosity(rgb)
    rgb = rgb.to_rgb
    l1 = (0.2126 * (rgb.r) ** 2.2) +
         (0.7152 * (rgb.b) ** 2.2) +
         (0.0722 * (rgb.g) ** 2.2);

    l2 = (0.2126 * (self.r) ** 2.2) +
         (0.7152 * (self.b) ** 2.2) +
         (0.0722 * (self.g) ** 2.2);

     ((([l1, l2].max) + 0.05) / ( ([l1, l2].min) + 0.05 ) - 1) / 20
  end

  # Provides the brightness difference.
  def diff_brightness(rgb)
    rgb = rgb.to_rgb
    br1 = (299 * rgb.r + 587 * rgb.g + 114 * rgb.b) ;
    br2 = (299 * self.r + 587 * self.g + 114 * self.b) ;
    (br1 - br2).abs / 1000;
  end

  # Provides the euclidean distance between the two color values
  def diff_euclidean(rgb)
    rgb = rgb.to_rgb
    ((((rgb.r - self.r) ** 2) +
      ((rgb.g - self.g) ** 2) +
      ((rgb.b - self.b) ** 2)) ** 0.5) / 1.7320508075688772
  end

  # Difference in the two colors' hue
  def diff_hue(rgb)
    rgb = rgb.to_rgb
    ((self.r - rgb.r).abs +
     (self.g - rgb.g).abs +
     (self.b - rgb.b).abs) / 3
  end
end
