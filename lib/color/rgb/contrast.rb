# -*- ruby encoding: utf-8 -*-

class Color::RGB
  # Outputs how much contrast this color has with another RGB color.
  # Computes the same regardless of which one is considered foreground. If
  # the other color does not have a #to_rgb method, this will throw an
  # exception. Anything over about 0.22 should have a high likelihood of
  # being legible, but the larger the difference, the more contrast.
  # Otherwise, to be safe go with something > 0.3
  def contrast(other)
    other = coerce(other)

    # The following numbers have been set with some care.
    ((diff_brightness(other) * 0.65) +
     (diff_hue(other)        * 0.20) +
     (diff_luminosity(other) * 0.15))
  end

  private
  # Provides the luminosity difference between two rbg vals
  def diff_luminosity(other)
    other = coerce(other)
    l1 = (0.2126 * (other.r) ** 2.2) +
         (0.7152 * (other.b) ** 2.2) +
         (0.0722 * (other.g) ** 2.2);

    l2 = (0.2126 * (self.r) ** 2.2) +
         (0.7152 * (self.b) ** 2.2) +
         (0.0722 * (self.g) ** 2.2);

    ((([l1, l2].max) + 0.05) / ( ([l1, l2].min) + 0.05 ) - 1) / 20.0
  end

  # Provides the brightness difference.
  def diff_brightness(other)
    other = other.to_rgb
    br1 = (299 * other.r + 587 * other.g + 114 * other.b)
    br2 = (299 * self.r + 587 * self.g + 114 * self.b)
    (br1 - br2).abs / 1000.0;
  end

  # Provides the euclidean distance between the two color values
  def diff_euclidean(other)
    other = other.to_rgb
    ((((other.r - self.r) ** 2) +
      ((other.g - self.g) ** 2) +
      ((other.b - self.b) ** 2)) ** 0.5) / 1.7320508075688772
  end

  # Difference in the two colors' hue
  def diff_hue(other)
    other = other.to_rgb
    ((self.r - other.r).abs +
     (self.g - other.g).abs +
     (self.b - other.b).abs) / 3
  end
end
