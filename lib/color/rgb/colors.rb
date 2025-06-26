# frozen_string_literal: true

class Color::RGB
  # :stopdoc:

  class << self
    def __create_named_colors(mod, *colors)
      @__by_hex ||= {}
      @__by_name ||= {}

      colors.each do |color|
        color => {rgb:, names:}

        raise ArgumentError, "Names cannot be empty" if names.nil? || names.empty?

        used = names - mod.constants.map(&:to_sym)

        if used.length < names.length
          raise ArgumentError, "#{names.join(", ")} already defined in #{mod}"
        end

        rgb = rgb.with(names: Array(names).flatten.compact.map { _1.to_s.downcase }.sort.uniq)
        names.each { mod.const_set(_1, rgb) }
        rgb.names.each { @__by_name[_1] = @__by_name[_1.to_s] = rgb }
        lower = rgb.name.downcase

        @__by_name[lower] = @__by_name[lower.to_s] = rgb
        @__by_hex[rgb.hex] = rgb
      end
    end
  end

  __create_named_colors(
    self,
    {rgb: from_values(0xf0, 0xf8, 0xff), names: [:AliceBlue]},
    {rgb: from_values(0xfa, 0xeb, 0xd7), names: [:AntiqueWhite]},
    {rgb: from_values(0x00, 0xff, 0xff), names: [:Aqua]},
    {rgb: from_values(0x7f, 0xff, 0xd4), names: [:Aquamarine]},
    {rgb: from_values(0xf0, 0xff, 0xff), names: [:Azure]},
    {rgb: from_values(0xf5, 0xf5, 0xdc), names: [:Beige]},
    {rgb: from_values(0xff, 0xe4, 0xc4), names: [:Bisque]},
    {rgb: from_values(0x00, 0x00, 0x00), names: [:Black]},
    {rgb: from_values(0xff, 0xeb, 0xcd), names: [:BlanchedAlmond]},
    {rgb: from_values(0x00, 0x00, 0xff), names: [:Blue]},
    {rgb: from_values(0x8a, 0x2b, 0xe2), names: [:BlueViolet]},
    {rgb: from_values(0xa5, 0x2a, 0x2a), names: [:Brown]},
    {rgb: from_values(0xde, 0xb8, 0x87), names: [:BurlyWood, :Burlywood]},
    {rgb: from_values(0x5f, 0x9e, 0xa0), names: [:CadetBlue]},
    {rgb: from_values(0xff, 0x5e, 0xd0), names: [:Carnation]},
    {rgb: from_values(0x8d, 0x00, 0x00), names: [:Cayenne]},
    {rgb: from_values(0x7f, 0xff, 0x00), names: [:Chartreuse]},
    {rgb: from_values(0xd2, 0x69, 0x1e), names: [:Chocolate]},
    {rgb: from_values(0xff, 0x7f, 0x50), names: [:Coral]},
    {rgb: from_values(0x64, 0x95, 0xed), names: [:CornflowerBlue]},
    {rgb: from_values(0xff, 0xf8, 0xdc), names: [:Cornsilk]},
    {rgb: from_values(0xdc, 0x14, 0x3c), names: [:Crimson]},
    {rgb: from_values(0x00, 0xff, 0xff), names: [:Cyan]},
    {rgb: from_values(0x00, 0x00, 0x8b), names: [:DarkBlue]},
    {rgb: from_values(0x00, 0x8b, 0x8b), names: [:DarkCyan]},
    {rgb: from_values(0xb8, 0x86, 0x0b), names: [:DarkGoldenRod, :DarkGoldenrod]},
    {rgb: from_values(0xa9, 0xa9, 0xa9), names: [:DarkGray, :DarkGrey]},
    {rgb: from_values(0x00, 0x64, 0x00), names: [:DarkGreen]},
    {rgb: from_values(0xbd, 0xb7, 0x6b), names: [:DarkKhaki]},
    {rgb: from_values(0x8b, 0x00, 0x8b), names: [:DarkMagenta]},
    {rgb: from_values(0x55, 0x6b, 0x2f), names: [:DarkOliveGreen, :DarkoliveGreen]},
    {rgb: from_values(0xff, 0x8c, 0x00), names: [:DarkOrange, :Darkorange]},
    {rgb: from_values(0x99, 0x32, 0xcc), names: [:DarkOrchid]},
    {rgb: from_values(0x8b, 0x00, 0x00), names: [:DarkRed]},
    {rgb: from_values(0xe9, 0x96, 0x7a), names: [:DarkSalmon, :Darksalmon]},
    {rgb: from_values(0x8f, 0xbc, 0x8f), names: [:DarkSeaGreen]},
    {rgb: from_values(0x48, 0x3d, 0x8b), names: [:DarkSlateBlue]},
    {rgb: from_values(0x2f, 0x4f, 0x4f), names: [:DarkSlateGray, :DarkSlateGrey]},
    {rgb: from_values(0x00, 0xce, 0xd1), names: [:DarkTurquoise]},
    {rgb: from_values(0x94, 0x00, 0xd3), names: [:DarkViolet]},
    {rgb: from_values(0xff, 0x14, 0x93), names: [:DeepPink]},
    {rgb: from_values(0x00, 0xbf, 0xff), names: [:DeepSkyBlue]},
    {rgb: from_values(0x69, 0x69, 0x69), names: [:DimGray, :DimGrey]},
    {rgb: from_values(0x1e, 0x90, 0xff), names: [:DodgerBlue]},
    {rgb: from_values(0xd1, 0x92, 0x75), names: [:Feldspar]},
    {rgb: from_values(0xb2, 0x22, 0x22), names: [:FireBrick, :Firebrick]},
    {rgb: from_values(0xff, 0xfa, 0xf0), names: [:FloralWhite]},
    {rgb: from_values(0x22, 0x8b, 0x22), names: [:ForestGreen]},
    {rgb: from_values(0xff, 0x00, 0xff), names: [:Fuchsia]},
    {rgb: from_values(0xdc, 0xdc, 0xdc), names: [:Gainsboro]},
    {rgb: from_values(0xf8, 0xf8, 0xff), names: [:GhostWhite]},
    {rgb: from_values(0xff, 0xd7, 0x00), names: [:Gold]},
    {rgb: from_values(0xda, 0xa5, 0x20), names: [:GoldenRod, :Goldenrod]},
    {rgb: from_values(0x80, 0x80, 0x80), names: [:Gray, :Grey]},
    {rgb: from_fraction(0.05, 0.05, 0.05), names: [:Gray05, :Gray5, :Grey05, :Grey5]},
    *(10..95).step(5).map {
      v = _1 / 100.0
      {rgb: from_fraction(v, v, v), names: [:"Gray#{_1}", :"Grey#{_1}"]}
    },
    {rgb: from_values(0x00, 0x80, 0x00), names: [:Green]},
    {rgb: from_values(0xad, 0xff, 0x2f), names: [:GreenYellow]},
    {rgb: from_values(0xf0, 0xff, 0xf0), names: [:HoneyDew, :Honeydew]},
    {rgb: from_values(0xff, 0x69, 0xb4), names: [:HotPink]},
    {rgb: from_values(0xcd, 0x5c, 0x5c), names: [:IndianRed]},
    {rgb: from_values(0x4b, 0x00, 0x82), names: [:Indigo]},
    {rgb: from_values(0xff, 0xff, 0xf0), names: [:Ivory]},
    {rgb: from_values(0xf0, 0xe6, 0x8c), names: [:Khaki]},
    {rgb: from_values(0xe6, 0xe6, 0xfa), names: [:Lavender]},
    {rgb: from_values(0xff, 0xf0, 0xf5), names: [:LavenderBlush]},
    {rgb: from_values(0x7c, 0xfc, 0x00), names: [:LawnGreen]},
    {rgb: from_values(0xff, 0xfa, 0xcd), names: [:LemonChiffon]},
    {rgb: from_values(0xad, 0xd8, 0xe6), names: [:LightBlue]},
    {rgb: from_values(0xf0, 0x80, 0x80), names: [:LightCoral]},
    {rgb: from_values(0xe0, 0xff, 0xff), names: [:LightCyan]},
    {rgb: from_values(0xfa, 0xfa, 0xd2), names: [:LightGoldenRodYellow, :LightGoldenrodYellow]},
    {rgb: from_values(0xd3, 0xd3, 0xd3), names: [:LightGray, :LightGrey]},
    {rgb: from_values(0x90, 0xee, 0x90), names: [:LightGreen]},
    {rgb: from_values(0xff, 0xb6, 0xc1), names: [:LightPink]},
    {rgb: from_values(0xff, 0xa0, 0x7a), names: [:LightSalmon, :Lightsalmon]},
    {rgb: from_values(0x20, 0xb2, 0xaa), names: [:LightSeaGreen]},
    {rgb: from_values(0x87, 0xce, 0xfa), names: [:LightSkyBlue]},
    {rgb: from_values(0x84, 0x70, 0xff), names: [:LightSlateBlue]},
    {rgb: from_values(0x77, 0x88, 0x99), names: [:LightSlateGray, :LightSlateGrey]},
    {rgb: from_values(0xb0, 0xc4, 0xde), names: [:LightSteelBlue, :LightsteelBlue]},
    {rgb: from_values(0xff, 0xff, 0xe0), names: [:LightYellow]},
    {rgb: from_values(0x00, 0xff, 0x00), names: [:Lime]},
    {rgb: from_values(0x32, 0xcd, 0x32), names: [:LimeGreen]},
    {rgb: from_values(0xfa, 0xf0, 0xe6), names: [:Linen]},
    {rgb: from_values(0xff, 0x00, 0xff), names: [:Magenta]},
    {rgb: from_values(0x80, 0x00, 0x00), names: [:Maroon]},
    {rgb: from_values(0x66, 0xcd, 0xaa), names: [:MediumAquaMarine, :MediumAquamarine]},
    {rgb: from_values(0x00, 0x00, 0xcd), names: [:MediumBlue]},
    {rgb: from_values(0xba, 0x55, 0xd3), names: [:MediumOrchid]},
    {rgb: from_values(0x93, 0x70, 0xdb), names: [:MediumPurple]},
    {rgb: from_values(0x3c, 0xb3, 0x71), names: [:MediumSeaGreen]},
    {rgb: from_values(0x7b, 0x68, 0xee), names: [:MediumSlateBlue]},
    {rgb: from_values(0x00, 0xfa, 0x9a), names: [:MediumSpringGreen]},
    {rgb: from_values(0x48, 0xd1, 0xcc), names: [:MediumTurquoise]},
    {rgb: from_values(0xc7, 0x15, 0x85), names: [:MediumVioletRed]},
    {rgb: from_values(0x19, 0x19, 0x70), names: [:MidnightBlue]},
    {rgb: from_values(0xf5, 0xff, 0xfa), names: [:MintCream]},
    {rgb: from_values(0xff, 0xe4, 0xe1), names: [:MistyRose]},
    {rgb: from_values(0xff, 0xe4, 0xb5), names: [:Moccasin]},
    {rgb: from_values(0xff, 0xde, 0xad), names: [:NavajoWhite]},
    {rgb: from_values(0x00, 0x00, 0x80), names: [:Navy]},
    {rgb: from_values(0xfd, 0xf5, 0xe6), names: [:OldLace]},
    {rgb: from_values(0x80, 0x80, 0x00), names: [:Olive]},
    {rgb: from_values(0x6b, 0x8e, 0x23), names: [:OliveDrab, :Olivedrab]},
    {rgb: from_values(0xff, 0xa5, 0x00), names: [:Orange]},
    {rgb: from_values(0xff, 0x45, 0x00), names: [:OrangeRed]},
    {rgb: from_values(0xda, 0x70, 0xd6), names: [:Orchid]},
    {rgb: from_values(0xee, 0xe8, 0xaa), names: [:PaleGoldenRod, :PaleGoldenrod]},
    {rgb: from_values(0x98, 0xfb, 0x98), names: [:PaleGreen]},
    {rgb: from_values(0xaf, 0xee, 0xee), names: [:PaleTurquoise]},
    {rgb: from_values(0xdb, 0x70, 0x93), names: [:PaleVioletRed]},
    {rgb: from_values(0xff, 0xef, 0xd5), names: [:PapayaWhip]},
    {rgb: from_values(0xff, 0xda, 0xb9), names: [:PeachPuff, :Peachpuff]},
    {rgb: from_values(0xcd, 0x85, 0x3f), names: [:Peru]},
    {rgb: from_values(0xff, 0xc0, 0xcb), names: [:Pink]},
    {rgb: from_values(0xdd, 0xa0, 0xdd), names: [:Plum]},
    {rgb: from_values(0xb0, 0xe0, 0xe6), names: [:PowderBlue]},
    {rgb: from_values(0x80, 0x00, 0x80), names: [:Purple]},
    {rgb: from_values(0x66, 0x33, 0x99), names: [:RebeccaPurple]},
    {rgb: from_values(0xff, 0x00, 0x00), names: [:Red]},
    {rgb: from_values(0xbc, 0x8f, 0x8f), names: [:RosyBrown]},
    {rgb: from_values(0x41, 0x69, 0xe1), names: [:RoyalBlue]},
    {rgb: from_values(0x8b, 0x45, 0x13), names: [:SaddleBrown]},
    {rgb: from_values(0xfa, 0x80, 0x72), names: [:Salmon]},
    {rgb: from_values(0xf4, 0xa4, 0x60), names: [:SandyBrown]},
    {rgb: from_values(0x2e, 0x8b, 0x57), names: [:SeaGreen]},
    {rgb: from_values(0xff, 0xf5, 0xee), names: [:SeaShell, :Seashell]},
    {rgb: from_values(0xa0, 0x52, 0x2d), names: [:Sienna]},
    {rgb: from_values(0xc0, 0xc0, 0xc0), names: [:Silver]},
    {rgb: from_values(0x87, 0xce, 0xeb), names: [:SkyBlue]},
    {rgb: from_values(0x6a, 0x5a, 0xcd), names: [:SlateBlue]},
    {rgb: from_values(0x70, 0x80, 0x90), names: [:SlateGray, :SlateGrey]},
    {rgb: from_values(0xff, 0xfa, 0xfa), names: [:Snow]},
    {rgb: from_values(0x00, 0xff, 0x7f), names: [:SpringGreen]},
    {rgb: from_values(0x46, 0x82, 0xb4), names: [:SteelBlue]},
    {rgb: from_values(0xd2, 0xb4, 0x8c), names: [:Tan]},
    {rgb: from_values(0x00, 0x80, 0x80), names: [:Teal]},
    {rgb: from_values(0xd8, 0xbf, 0xd8), names: [:Thistle]},
    {rgb: from_values(0xff, 0x63, 0x47), names: [:Tomato]},
    {rgb: from_values(0x40, 0xe0, 0xd0), names: [:Turquoise]},
    {rgb: from_values(0xee, 0x82, 0xee), names: [:Violet]},
    {rgb: from_values(0xd0, 0x20, 0x90), names: [:VioletRed]},
    {rgb: from_values(0xf5, 0xde, 0xb3), names: [:Wheat]},
    {rgb: from_values(0xff, 0xff, 0xff), names: [:White]},
    {rgb: from_values(0xf5, 0xf5, 0xf5), names: [:WhiteSmoke]},
    {rgb: from_values(0xff, 0xff, 0x00), names: [:Yellow]},
    {rgb: from_values(0x9a, 0xcd, 0x32), names: [:YellowGreen]}
  )

  # :stopdoc:
  # This namespace contains some RGB metallic colors suggested by Jim
  # Freeze.
  # :startdoc:

  module Metallic; end

  __create_named_colors(
    Metallic,
    {rgb: from_values(0x99, 0x99, 0x99), names: [:Aluminum]},
    {rgb: from_values(0xd9, 0x87, 0x19), names: [:CoolCopper]},
    {rgb: from_values(0xb8, 0x73, 0x33), names: [:Copper]},
    {rgb: from_values(0x4c, 0x4c, 0x4c), names: [:Iron]},
    {rgb: from_values(0x19, 0x19, 0x19), names: [:Lead]},
    {rgb: from_values(0xb3, 0xb3, 0xb3), names: [:Magnesium]},
    {rgb: from_values(0xe6, 0xe6, 0xe6), names: [:Mercury]},
    {rgb: from_values(0x80, 0x80, 0x80), names: [:Nickel]},
    {rgb: from_values(0x60, 0x00, 0x00), names: [:PolySilicon, :Poly]},
    {rgb: from_values(0xcc, 0xcc, 0xcc), names: [:Silver]},
    {rgb: from_values(0x66, 0x66, 0x66), names: [:Steel]},
    {rgb: from_values(0x7f, 0x7f, 0x7f), names: [:Tin]},
    {rgb: from_values(0x33, 0x33, 0x33), names: [:Tungsten]}
  )

  class << self
    undef :__create_named_colors
  end

  # :startdoc:
end
