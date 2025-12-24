# frozen_string_literal: true

##
# A \Color object for the \CIELAB color space (also known as L\*a\*\b*). Color is
# expressed in a three-dimensional, device-independent "standard observer" model, often
# in relation to a "reference white" color, usually Color::XYZ::D65 (most purposes) or
# Color::XYZ::D50 (printing).
#
# `L*` is the perceptual lightness, bounded to values between 0 (black) and 100 (white).
# `a*` is the range of green (negative) / red (positive) and `b*` is the range of blue
# (negative) / yellow (positive).
#
# The `a*` and `b*` ranges are _technically_ unbounded but \Color clamps them to the
# values `-128..127`.
#
# For more information, see [CIELAB](https://en.wikipedia.org/wiki/CIELAB_color_space).
#
# \CIELAB colors are immutable Data class instances. Array deconstruction is `[l, a, b]`
# and hash deconstruction is `{l:, a:, b:}` (see #l, #a, #b).
class Color::CIELAB
  include Color

  ##
  # Standard weights applied for perceptual differences using the ΔE*94 algorithm.
  DE94_WEIGHTS = {
    graphic_arts: {k_1: 0.045, k_2: 0.015, k_l: 1.0}.freeze,
    textiles: {k_1: 0.048, k_2: 0.014, k_l: 2.0}.freeze
  }.freeze

  RANGES = {L: 0.0..100.0, ab: -128.0..127.0}.freeze # :nodoc:
  private_constant :RANGES

  ##
  # :attr_reader: l
  # The `L*` attribute of this \CIELAB color object expressed as a value 0..100.

  ##
  # :attr_reader: a
  # The `a*` attribute of this \CIELAB color object expressed as a value -128..127.

  ##
  # :attr_reader: b
  # The `b*` attribute of this \CIELAB color object expressed as a value -128..127.

  ##
  # Creates a \CIELAB color representation from percentage values.
  #
  # `l` must be between 0% and 100%; `a` and `b` must be between -100% and 100% and will
  # be transposed to the native value -128..127.
  #
  # ```ruby
  # Color::CIELAB.from_percentage(10, -30, 30)  # => CIELAB [10.0000 -38.7500 37.7500]
  # ```
  #
  # :call-seq:
  #   from_percentage(l, a, b)
  #   from_percentage(l:, a:, b:)
  def self.from_percentage(*args, **kwargs)
    l, a, b =
      case [args, kwargs]
      in [[_, _, _], {}]
        args
      in [[], {l:, a:, b:}]
        [l, a, b]
      else
        new(*args, **kwargs)
      end

    new(
      l: l,
      a: Color.translate_range(a, from: -100.0..100.0, to: RANGES[:ab]),
      b: Color.translate_range(b, from: -100.0..100.0, to: RANGES[:ab])
    )
  end

  class << self
    alias_method :from_values, :new
    alias_method :from_internal, :new # :nodoc:
  end

  ##
  # Creates a \CIELAB color representation from `L*a*b*` native values. The `l` value
  # must be between 0 and 100 and the `a` and `b` values must be between -128 and 127.
  #
  # ```ruby
  # Color::CIELAB.new(10, 35, -35)         # => CIELAB [10.00 35.00 -35.00]
  # Color::CIELAB.from_values(10, 35, -35) # => CIELAB [10.00 35.00 -35.00]
  # Color::CIELAB[l: 10, a: 35, b: -35]    # => CIELAB [10.00 35.00 -35.00]
  # ```
  def initialize(l:, a:, b:)
    super(
      l: normalize(l, RANGES[:L]),
      a: normalize(a, RANGES[:ab]),
      b: normalize(b, RANGES[:ab])
    )
  end

  ##
  # Coerces the other Color object into \CIELAB.
  def coerce(other) = other.to_lab

  ##
  # Converts \CIELAB to Color::CMYK via Color::RGB.
  #
  # See #to_rgb and Color::RGB#to_cmyk.
  def to_cmyk(...) = to_rgb(...).to_cmyk(...)

  ##
  # Converts \CIELAB to Color::Grayscale via Color::RGB.
  #
  # See #to_rgb and Color::RGB#to_grayscale.
  def to_grayscale(...) = to_rgb(...).to_grayscale(...)

  ##
  def to_lab(...) = self

  ##
  # Converts \CIELAB to Color::HSL via Color::RGB.
  #
  # See #to_rgb and Color::RGB#to_hsl.
  def to_hsl(...) = to_rgb(...).to_hsl(...)

  ##
  # Converts \CIELAB to Color::RGB via Color::XYZ.
  #
  # See #to_xyz and Color::XYZ#to_rgb.
  def to_rgb(...) = to_xyz(...).to_rgb(...)

  ##
  # Converts \CIELAB to Color::XYZ based on a reference white.
  #
  # Accepts a single keyword parameter, `white`, indicating the reference white used for
  # conversion scaling. If none is provided, Color::XYZ::D65 is used.
  #
  # :call-seq:
  #   to_xyz(white: Color::XYZ::D65)
  def to_xyz(*args, **kwargs)
    fy = (l + 16.0) / 116
    fz = fy - b / 200.0
    fx = a / 500.0 + fy

    xr = ((fx3 = fx**3) > Color::XYZ::E) ? fx3 : (116.0 * fx - 16) / Color::XYZ::K
    yr = (l > Color::XYZ::EK) ? ((l + 16.0) / 116)**3 : l / Color::XYZ::K
    zr = ((fz3 = fz**3) > Color::XYZ::E) ? fz3 : (116.0 * fz - 16) / Color::XYZ::K

    ref = kwargs[:white] || args.first
    ref = Color::XYZ::D65 unless ref.is_a?(Color::XYZ)

    ref.scale(xr, yr, zr)
  end

  ##
  # Converts \CIELAB to Color::YIQ via Color::XYZ.
  def to_yiq(...) = to_xyz(...).to_yiq(...)

  ##
  # Render the CSS `lab()` function for this \CIELAB object, adding an `alpha` if
  # provided.
  def css(alpha: nil, **)
    params = [css_value(l, :percent), css_value(a), css_value(b)].join(" ")
    params = "#{params} / #{css_value(alpha)}" if alpha

    "lab(#{params})"
  end

  ##
  # Implements the \CIELAB ΔE* 2000 perceptual color distance metric with more reliable
  # results over \CIELAB ΔE* 1994.
  #
  # See [CIEDE2000][ciede2000] for precise details on the mathematical formulas. The
  # implementation here is based on Sharma, Wu, and Dala in [CIEDE2000.xls][ciede2000xls],
  # published as supplementary materials for their paper "The CIEDE2000 Color-Difference
  # Formula: Implementation Notes, Supplementary Test Data, and Mathematical
  # Observations,", G. Sharma, W. Wu, E. N. Dalal, Color Research and Application, vol.
  # 30. No. 1, pp. 21-30, February 2005.
  #
  # Do not override the `klch` parameter unless you _really_ know what you're doing.
  #
  # See also <http://www.brucelindbloom.com/index.html?Eqn_DeltaE_CIE2000.html>
  #
  # [ciede2000]: https://en.wikipedia.org/wiki/Color_difference#CIEDE2000
  # [ciede2000xls]: http://www.ece.rochester.edu/~gsharma/ciede2000/dataNprograms/CIEDE2000.xls
  def delta_e2000(other, klch: {L: 1.0, C: 1.0, H: 1.0})
    other = coerce(other)
    klch => L: k_l, C: k_c, H: k_h
    self => l: l_star_1, a: a_star_1, b: b_star_1
    other => l: l_star_2, a: a_star_2, b: b_star_2

    v_25_pow_7 = 25**7

    c_star_1 = Math.sqrt(a_star_1**2 + b_star_1**2)
    c_star_2 = Math.sqrt(a_star_2**2 + b_star_2**2)

    c_mean = ((c_star_1 + c_star_2) / 2.0)
    c_mean_pow_7 = c_mean**7
    c_mean_g = (0.5 * (1.0 - Math.sqrt(c_mean_pow_7 / (c_mean_pow_7 + v_25_pow_7))))

    a_1_prime = ((1.0 + c_mean_g) * a_star_1)
    a_2_prime = ((1.0 + c_mean_g) * a_star_2)

    c_1_prime = Math.sqrt(a_1_prime**2 + b_star_1**2)
    c_2_prime = Math.sqrt(a_2_prime**2 + b_star_2**2)

    h_1_prime =
      if a_1_prime + b_star_1 == 0
        0
      else
        (to_degrees(Math.atan2(b_star_1, a_1_prime)) % 360.0)
      end
    h_2_prime =
      if a_2_prime + b_star_2 == 0
        0
      else
        (to_degrees(Math.atan2(b_star_2, a_2_prime)) % 360.0)
      end

    delta_lower_h_prime =
      if h_2_prime - h_1_prime < -180
        h_2_prime + 360 - h_1_prime
      elsif h_2_prime - h_1_prime > 180
        h_2_prime - h_1_prime - 360.0
      else
        h_2_prime - h_1_prime
      end

    delta_upper_l_prime = l_star_2 - l_star_1
    delta_upper_c_prime = c_2_prime - c_1_prime
    delta_upper_h_prime = (
      2.0 *
      Math.sqrt(c_1_prime * c_2_prime) *
      Math.sin(to_radians(delta_lower_h_prime / 2.0))
    )

    l_prime_mean = ((l_star_1 + l_star_2) / 2.0)
    c_prime_mean = ((c_1_prime + c_2_prime) / 2.0)
    h_prime_mean =
      if c_1_prime * c_2_prime == 0
        h_1_prime + h_2_prime
      elsif (h_2_prime - h_1_prime).abs <= 180
        ((h_1_prime + h_2_prime) / 2.0)
      elsif h_2_prime + h_1_prime <= 360
        ((h_1_prime + h_2_prime) / 2.0 + 180.0)
      else
        ((h_1_prime + h_2_prime) / 2.0 - 180.0)
      end

    l_prime_mean50sq = ((l_prime_mean - 50)**2)

    upper_s_l = (1 + (0.015 * l_prime_mean50sq / Math.sqrt(20 + l_prime_mean50sq)))
    upper_s_c = (1 + 0.045 * c_prime_mean)
    upper_t = (
      1 -
      0.17 * Math.cos(to_radians(h_prime_mean - 30)) +
      0.24 * Math.cos(to_radians(2 * h_prime_mean)) +
      0.32 * Math.cos(to_radians(3 * h_prime_mean + 6)) -
      0.2 * Math.cos(to_radians(4 * h_prime_mean - 63))
    )

    upper_s_h = (1 + 0.015 * c_prime_mean * upper_t)

    delta_theta = (30 * Math.exp(-1 * ((h_prime_mean - 275) / 25.0)**2))
    upper_r_c = (2 * Math.sqrt(c_prime_mean**7 / (c_prime_mean**7 + v_25_pow_7)))
    upper_r_t = (-Math.sin(to_radians(2 * delta_theta)) * upper_r_c)
    delta_l_prime_div_kl_div_sl = (delta_upper_l_prime / upper_s_l / k_l.to_f)
    delta_c_prime_div_kc_div_sc = (delta_upper_c_prime / upper_s_c / k_c.to_f)
    delta_h_prime_div_kh_div_sh = (delta_upper_h_prime / upper_s_h / k_h.to_f)

    Math.sqrt(
      delta_l_prime_div_kl_div_sl**2 +
      delta_c_prime_div_kc_div_sc**2 +
      delta_h_prime_div_kh_div_sh**2 +
      upper_r_t * delta_c_prime_div_kc_div_sc * delta_h_prime_div_kh_div_sh
    )
  end

  ##
  # Implements the \CIELAB ΔE* 1994 perceptual color distance metric. This version is an
  # improvement over previous versions, but it does not handle perceptual discontinuities
  # as well as \CIELAB ΔE* 2000. This is implemented because some functions still require
  # the 1994 algorithm for proper operation.
  #
  # See [CIE94][cie94] for precise details on the mathematical formulas.
  #
  # Different weights for `k_l`, `k_1`, and `k_2` may be applied via the `weight` keyword
  # parameter. This may be provided either as a Hash with `k_l`, `k_1`, and `k_2` values
  # or as a key to DE94_WEIGHTS. The default weight is `:graphic_arts`.
  #
  # See also <http://www.brucelindbloom.com/index.html?Eqn_DeltaE_CIE94.html>.
  #
  # [cie94]: https://en.wikipedia.org/wiki/Color_difference#CIE94
  def delta_e94(other, weight: :graphic_arts)
    weight = DE94_WEIGHTS[weight] if DE94_WEIGHTS.key?(weight)
    raise ArgumentError, "Unsupported weight #{weight.inspect}." unless weight.is_a?(Hash)

    weight => k_1:, k_2:, k_l:

    # Under some circumstances in real computers, the computed value of ΔH could be an
    # imaginary number (it's a square root value), so instead of √(((ΔL/(kL*sL))²) +
    # ((ΔC/(kC*sC))²) + ((ΔH/(kH*sH))²)), we have implemented the final computation as
    # √(((ΔL/(kL*sL))²) + ((ΔC/(kC*sC))²) + (ΔH2/(kH*sH)²)) and not performing the square
    # root when computing ΔH2.

    k_c = k_h = 1.0

    other = coerce(other)

    self => l: l_1, a: a_1, b: b_1
    other => l: l_2, a: a_2, b: b_2

    delta_a = a_1 - a_2
    delta_b = b_1 - b_2

    cab_1 = Math.sqrt((a_1**2) + (b_1**2))
    cab_2 = Math.sqrt((a_2**2) + (b_2**2))

    delta_upper_l = l_1 - l_2
    delta_upper_c = cab_1 - cab_2

    delta_h2 = (delta_a**2) + (delta_b**2) - (delta_upper_c**2)

    s_upper_l = 1.0
    s_upper_c = 1 + k_1 * cab_1
    s_upper_h = 1 + k_2 * cab_1

    composite_upper_l = (delta_upper_l / (k_l * s_upper_l))**2
    composite_upper_c = (delta_upper_c / (k_c * s_upper_c))**2
    composite_upper_h = delta_h2 / ((k_h * s_upper_h)**2)
    Math.sqrt(composite_upper_l + composite_upper_c + composite_upper_h)
  end

  ##
  alias_method :to_a, :deconstruct

  ##
  alias_method :to_internal, :deconstruct # :nodoc:

  ##
  def inspect = "CIELAB [%.4f %.4f %.4f]" % [l, a, b] # :nodoc:

  ##
  def pretty_print(q) # :nodoc:
    q.text "CIELAB"
    q.breakable
    q.group 2, "[", "]" do
      q.text "%.4f" % l
      q.fill_breakable
      q.text "%.4f" % a
      q.fill_breakable
      q.text "%.4f" % b
    end
  end
end
