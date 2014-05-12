# frozen_string_literal: true

class Color::RGB
  # Outputs how much contrast this color has with another RGB color.
  # Computes the same regardless of which one is considered foreground. If
  # the other color does not have a #to_rgb method, this will throw an
  # exception. Anything over about 0.22 should have a high likelihood of
  # being legible. Otherwise, to be safe go with something > 0.3.
  def contrast(other, algorithm = nil)
    other = coerce(other)

    case algorithm
    when :delta_e94
      Color::LAB.delta_e94(to_lab, other.to_lab)
    when :delta_e2000
      Color::LAB.delta_e2000(to_lab, other.to_lab)
    else
      # The following numbers have been set with some care.
      ((diff_brightness(other) * 0.65) +
       (diff_hue(other) * 0.20) +
       (diff_luminosity(other) * 0.15))
    end
  end

  # Provides the luminosity difference between two rbg vals
  def diff_luminosity(other)
    other = coerce(other)
    l1 = (0.2126 * other.r**2.2) +
      (0.7152 * other.b**2.2) +
      (0.0722 * other.g**2.2)

    l2 = (0.2126 * r**2.2) +
      (0.7152 * b**2.2) +
      (0.0722 * g**2.2)

    (([l1, l2].max + 0.05) / ([l1, l2].min + 0.05) - 1) / 20.0
  end

  # Provides the brightness difference.
  def diff_brightness(other)
    other = other.to_rgb
    br1 = (299 * other.r + 587 * other.g + 114 * other.b)
    br2 = (299 * r + 587 * g + 114 * b)
    (br1 - br2).abs / 1000.0
  end

  # Provides the euclidean distance between the two color values
  def diff_euclidean(other)
    other = other.to_rgb
    ((((other.r - r)**2) +
      ((other.g - g)**2) +
      ((other.b - b)**2))**0.5) / 1.7320508075688772
  end

  # Difference in the two colors' hue
  def diff_hue(other)
    other = other.to_rgb
    ((r - other.r).abs +
     (g - other.g).abs +
     (b - other.b).abs) / 3
  end
end
