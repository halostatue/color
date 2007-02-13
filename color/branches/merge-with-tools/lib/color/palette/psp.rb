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

# A class that can read a JASC Paint Shop Pro (PSP) palette file and provide
# an array-like interface to the contents. PSP colour palettes are RGB
# values only.
#
# JASC PSP palette colours are always unnamed.
#
#   pal = Color::Palette::PSP.from_file(my_gimp_palette)
#   pal[0]          => Color::RGB<...>
#
# PSP Palettes are always indexable by insertion order (an integer key).
class Color::Palette::PSP
  include Enumerable

  class << self
    # Create a PSP palette object from the named file.
    def from_file(filename)
      File.open(filename, "rb") { |io| Color::Palette::PSP.from_io(io) }
    end

    # Create a PSP palette object from the provided IO.
    def from_io(io)
      Color::Palette::PSP.new(io.read)
    end
  end

  # Create a new PSP palette from the palette file as a string.
  def initialize(palette)
    @colors   = []

    palette = palette.split($/)

    raise "Unknown palette file format" unless palette[0].chomp == "JASC-PAL"

    palette[3..-1].each do |line|
      line.chomp!

      next if line.empty?

      line.gsub!(/^\s+/, '')
      data = line.split(/\s+/, 3)
      data.map! { |el| el.to_i }

      color = Color::RGB.new(*data)

      @colors << color
    end
  end

  # Provides the colour or colours at the provided selectors.
  def values_at(*selectors)
    @colors.values_at(*selectors)
  end

  # The colour value at that +key+ will be returned.
  def [](key)
    @colors[key]
  end

  # Loops through each colour.
  def each
    @colors.each { |el| yield el }
  end

  def size
    @colors.size
  end
end
