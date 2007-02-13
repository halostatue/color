#--
# Color
# Colour management with Ruby
# http://rubyforge.org/projects/color
#   Version 1.4.0
#
# Licensed under a MIT-style licence. See Licence.txt in the main
# distribution for full licensing information.
#
# Copyright (c) 2005 - 2007 Austin Ziegler and Matt Lyon
#
# $Id: test_all.rb 55 2007-02-03 23:29:34Z austin $
#++

# A colour object representing YIQ (NTSC) colour encoding.
class Color::YIQ
  # Creates a YIQ colour object from fractional values 0 .. 1.
  #
  #   Color::YIQ.new(0.3, 0.2, 0.1)
  def self.from_fraction(y = 0, i = 0, q = 0)
    color = Color::YIQ.new
    color.y = y
    color.i = i
    color.q = q
    color
  end

  # Creates a YIQ colour object from percentages 0 .. 100.
  #
  #   Color::YIQ.new(10, 20, 30)
  def initialize(y = 0, i = 0, q = 0)
    @y = y / 100.0
    @i = i / 100.0
    @q = q / 100.0
  end

  # Compares the other colour to this one. The other colour will be
  # converted to YIQ before comparison, so the comparison between a YIQ
  # colour and a non-YIQ colour will be approximate and based on the other
  # colour's #to_yiq conversion. If there is no #to_yiq conversion, this
  # will raise an exception. This will report that two YIQ values are
  # equivalent if all component colours are within COLOR_TOLERANCE of each
  # other.
  def ==(other)
    other = other.to_yiq
    other.kind_of?(Color::YIQ) and
    ((@y - other.y).abs <= Color::COLOR_TOLERANCE) and
    ((@i - other.i).abs <= Color::COLOR_TOLERANCE) and
    ((@q - other.q).abs <= Color::COLOR_TOLERANCE) 
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

  attr_accessor :y, :i, :q
  remove_method :y=, :i=, :q=
  def y=(yy) #:nodoc:
    yy = 1.0 if yy > 1
    yy = 0.0 if yy < 0
    @y = yy
  end
  def i=(ii) #:nodoc:
    ii = 1.0 if ii > 1
    ii = 0.0 if ii < 0
    @i = ii
  end
  def q=(qq) #:nodoc:
    qq = 1.0 if qq > 1
    qq = 0.0 if qq < 0
    @q = qq
  end
end
