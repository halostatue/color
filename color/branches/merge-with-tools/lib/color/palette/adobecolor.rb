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

require 'color/palette'

# A class that can read an Adobe Color palette file (used for Photoshop
# swatches) and provide a Hash-like interface to the contents. Not all
# colour formats in ACO files are supported. Based largely off the
# information found by Larry Tesler[http://www.nomodes.com/aco.html].
#
# Not all Adobe Color files have named colours; all named entries are
# returned as an array.
#
#   pal = Color::Palette::AdobeColor.from_file(my_aco_palette)
#   pal[0]          => Color::RGB<...>
#   pal["white"]    => [ Color::RGB<...> ]
#   pal["unknown"]  => [ Color::RGB<...>, Color::RGB<...>, ... ]
#
# AdobeColor palettes are always indexable by insertion order (an integer key).
#
# This has only been teested on Adobe Color version 1 files (Photoshop <=
# 7.x).
class Color::Palette::AdobeColor
  include Enumerable

  class << self
    # Create an AdobeColor palette object from the named file.
    def from_file(filename)
      File.open(filename, "rb") { |io| Color::Palette::AdobeColor.from_io(io) }
    end

    # Create an AdobeColor palette object from the provided IO.
    def from_io(io)
      Color::Palette::AdobeColor.new(io.read)
    end
  end

  # Create a new AdobeColor palette from the palette file as a string.
  def initialize(palette)
    @colors   = []
    @names    = {}
    @valid    = false
    @version  = nil

    class << palette
      def readwords(count = 1)
        @offset ||= 0
        val = self[@offset, count * 2].unpack("n" * count)
        @offset += count * 2
        val
      end

      def readutf16(count = 1)
        @offset ||= 0
        val = self[@offset, count * 2]
        @offset += count * 2
        val
      end
    end

    @version, count = palette.readwords 2

    raise "Unknown AdobeColor palette version #@version." unless @version.between?(1, 2)

    count.times do
      space, w, x, y, z = palette.readwords 5
      name = nil
      if @version == 2
        palette.readwords
        len = palette.readwords
        name = palette.readutf16(len[0] - 1)
        palette.readwords
      end

      color = case space
              when 0 then Color::RGB.new(w / 256, x / 256, y / 256)
              when 1 then # HS[BV] -- Convert to RGB
                h = w / 65535.0
                s = x / 65535.0
                v = y / 65535.0

                if Color.near_zero_or_less?(s)
                  Color::RGB.from_fraction(v, v, v)
                else
                  if Color.near_one_or_more?(h)
                    vh = 0
                  else
                    vh = h * 6.0
                  end

                  vi = vh.floor
                  v1 = v.to_f * (1 - s.to_f)
                  v2 = v.to_f * (1 - s.to_f * (vh - vi))
                  v3 = v.to_f * (1 - s.to_f * (1 - (vh - vi)))

                  case vi
                  when 0 then Color::RGB.from_fraction(v, v3, v1)
                  when 1 then Color::RGB.from_fraction(v2, v, v1)
                  when 2 then Color::RGB.from_fraction(v1, v, v3)
                  when 3 then Color::RGB.from_fraction(v1, v2, v)
                  when 4 then Color::RGB.from_fraction(v3, v1, v)
                  else Color::RGB.from_fraction(v, v1, v2)
                  end
                end
              when 2 then
                Color::CMYK.from_percent(100 - (w / 655.35),
                                         100 - (x / 655.35),
                                         100 - (y / 655.35),
                                         100 - (z / 655.35))
              when 8
                g = [w, 10000].min / 100.0
                Color::GrayScale.from_percent(g)
              when 9 # Wide CMYK
                c = [w, 10000].min / 100.0
                m = [x, 10000].min / 100.0
                y = [y, 10000].min / 100.0
                k = [z, 10000].min / 100.0
                Color::CMYK.from_percent(c, m, y, k)
              end

      @colors << color

      if name
        @names[name] ||= []
        @names[name] << color
      end
    end
  end

  # Provides the colour or colours at the provided selectors.
  def values_at(*selectors)
    @colors.values_at(*selectors)
  end

  # If a Numeric +key+ is provided, the single colour value at that position
  # will be returned. If a String +key+ is provided, the colour set (an
  # array) for that colour name will be returned.
  def [](key)
    if key.kind_of?(Numeric)
      @colors[key]
    else
      @names[key]
    end
  end

  # Loops through each colour.
  def each
    @colors.each { |el| yield el }
  end

  # Loops through each named colour set.
  def each_name #:yields color_name, color_set:#
    @names.each { |color_name, color_set| yield color_name, color_set }
  end

  def size
    @colors.size
  end

  attr_reader :version
end
