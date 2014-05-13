class Color::RGB
  class << self
    private
    def named(rgb, *names)
      __named_color(self, new(*rgb), *names)
    end
  end

  named [0xf0, 0xf8, 0xff], :AliceBlue
  named [0xfa, 0xeb, 0xd7], :AntiqueWhite
  named [0x00, 0xff, 0xff], :Aqua
  named [0x7f, 0xff, 0xd4], :Aquamarine
  named [0xf0, 0xff, 0xff], :Azure
  named [0xf5, 0xf5, 0xdc], :Beige
  named [0xff, 0xe4, 0xc4], :Bisque
  named [0x00, 0x00, 0x00], :Black
  named [0xff, 0xeb, 0xcd], :BlanchedAlmond
  named [0x00, 0x00, 0xff], :Blue
  named [0x8a, 0x2b, 0xe2], :BlueViolet
  named [0xa5, 0x2a, 0x2a], :Brown
  named [0xde, 0xb8, 0x87], :BurlyWood, :Burlywood
  named [0x5f, 0x9e, 0xa0], :CadetBlue
  named [0xff, 0x5e, 0xd0], :Carnation
  named [0x8d, 0x00, 0x00], :Cayenne
  named [0x7f, 0xff, 0x00], :Chartreuse
  named [0xd2, 0x69, 0x1e], :Chocolate
  named [0xff, 0x7f, 0x50], :Coral
  named [0x64, 0x95, 0xed], :CornflowerBlue
  named [0xff, 0xf8, 0xdc], :Cornsilk
  named [0xdc, 0x14, 0x3c], :Crimson
  named [0x00, 0xff, 0xff], :Cyan
  named [0x00, 0x00, 0x8b], :DarkBlue
  named [0x00, 0x8b, 0x8b], :DarkCyan
  named [0xb8, 0x86, 0x0b], :DarkGoldenRod, :DarkGoldenrod
  named [0xa9, 0xa9, 0xa9], :DarkGray, :DarkGrey
  named [0x00, 0x64, 0x00], :DarkGreen
  named [0xbd, 0xb7, 0x6b], :DarkKhaki
  named [0x8b, 0x00, 0x8b], :DarkMagenta
  named [0x55, 0x6b, 0x2f], :DarkOliveGreen, :DarkoliveGreen
  named [0xff, 0x8c, 0x00], :DarkOrange
  named [0x99, 0x32, 0xcc], :DarkOrchid
  named [0x8b, 0x00, 0x00], :DarkRed
  named [0xe9, 0x96, 0x7a], :DarkSalmon, :Darksalmon
  named [0x8f, 0xbc, 0x8f], :DarkSeaGreen
  named [0x48, 0x3d, 0x8b], :DarkSlateBlue
  named [0x2f, 0x4f, 0x4f], :DarkSlateGray, :DarkSlateGrey
  named [0x00, 0xce, 0xd1], :DarkTurquoise
  named [0x94, 0x00, 0xd3], :DarkViolet
  named [0xff, 0x8c, 0x00], :Darkorange
  named [0xff, 0x14, 0x93], :DeepPink
  named [0x00, 0xbf, 0xbf], :DeepSkyBlue
  named [0x69, 0x69, 0x69], :DimGray, :DimGrey
  named [0x1e, 0x90, 0xff], :DodgerBlue
  named [0xd1, 0x92, 0x75], :Feldspar
  named [0xb2, 0x22, 0x22], :FireBrick, :Firebrick
  named [0xff, 0xfa, 0xf0], :FloralWhite
  named [0x22, 0x8b, 0x22], :ForestGreen
  named [0xff, 0x00, 0xff], :Fuchsia
  named [0xdc, 0xdc, 0xdc], :Gainsboro
  named [0xf8, 0xf8, 0xff], :GhostWhite
  named [0xff, 0xd7, 0x00], :Gold
  named [0xda, 0xa5, 0x20], :GoldenRod, :Goldenrod
  named [0x80, 0x80, 0x80], :Gray, :Grey
  named [10, 10, 10, 100.0], :Gray10, :Grey10
  named [20, 20, 20, 100.0], :Gray20, :Grey20
  named [30, 30, 30, 100.0], :Gray30, :Grey30
  named [40, 40, 40, 100.0], :Gray40, :Grey40
  named [50, 50, 50, 100.0], :Gray50, :Grey50
  named [60, 60, 60, 100.0], :Gray60, :Grey60
  named [70, 70, 70, 100.0], :Gray70, :Grey70
  named [80, 80, 80, 100.0], :Gray80, :Grey80
  named [90, 90, 90, 100.0], :Gray90, :Grey90
  named [0x00, 0x80, 0x00], :Green
  named [0xad, 0xff, 0x2f], :GreenYellow
  named [0xf0, 0xff, 0xf0], :HoneyDew, :Honeydew
  named [0xff, 0x69, 0xb4], :HotPink
  named [0xcd, 0x5c, 0x5c], :IndianRed
  named [0x4b, 0x00, 0x82], :Indigo
  named [0xff, 0xff, 0xf0], :Ivory
  named [0xf0, 0xe6, 0x8c], :Khaki
  named [0xe6, 0xe6, 0xfa], :Lavender
  named [0xff, 0xf0, 0xf5], :LavenderBlush
  named [0x7c, 0xfc, 0x00], :LawnGreen
  named [0xff, 0xfa, 0xcd], :LemonChiffon
  named [0xad, 0xd8, 0xe6], :LightBlue
  named [0xf0, 0x80, 0x80], :LightCoral
  named [0xe0, 0xff, 0xff], :LightCyan
  named [0xfa, 0xfa, 0xd2], :LightGoldenRodYellow, :LightGoldenrodYellow
  named [0xd3, 0xd3, 0xd3], :LightGray, :LightGrey
  named [0x90, 0xee, 0x90], :LightGreen
  named [0xff, 0xb6, 0xc1], :LightPink
  named [0xff, 0xa0, 0x7a], :LightSalmon, :Lightsalmon
  named [0x20, 0xb2, 0xaa], :LightSeaGreen
  named [0x87, 0xce, 0xfa], :LightSkyBlue
  named [0x84, 0x70, 0xff], :LightSlateBlue
  named [0x77, 0x88, 0x99], :LightSlateGray, :LightSlateGrey
  named [0xb0, 0xc4, 0xde], :LightSteelBlue, :LightsteelBlue
  named [0xff, 0xff, 0xe0], :LightYellow
  named [0x00, 0xff, 0x00], :Lime
  named [0x32, 0xcd, 0x32], :LimeGreen
  named [0xfa, 0xf0, 0xe6], :Linen
  named [0xff, 0x00, 0xff], :Magenta
  named [0x80, 0x00, 0x00], :Maroon
  named [0x66, 0xcd, 0xaa], :MediumAquaMarine, :MediumAquamarine
  named [0x00, 0x00, 0xcd], :MediumBlue
  named [0xba, 0x55, 0xd3], :MediumOrchid
  named [0x93, 0x70, 0xdb], :MediumPurple
  named [0x3c, 0xb3, 0x71], :MediumSeaGreen
  named [0x7b, 0x68, 0xee], :MediumSlateBlue
  named [0x00, 0xfa, 0x9a], :MediumSpringGreen
  named [0x48, 0xd1, 0xcc], :MediumTurquoise
  named [0xc7, 0x15, 0x85], :MediumVioletRed
  named [0x19, 0x19, 0x70], :MidnightBlue
  named [0xf5, 0xff, 0xfa], :MintCream
  named [0xff, 0xe4, 0xe1], :MistyRose
  named [0xff, 0xe4, 0xb5], :Moccasin
  named [0xff, 0xde, 0xad], :NavajoWhite
  named [0x00, 0x00, 0x80], :Navy
  named [0xfd, 0xf5, 0xe6], :OldLace
  named [0x80, 0x80, 0x00], :Olive
  named [0x6b, 0x8e, 0x23], :OliveDrab, :Olivedrab
  named [0xff, 0xa5, 0x00], :Orange
  named [0xff, 0x45, 0x00], :OrangeRed
  named [0xda, 0x70, 0xd6], :Orchid
  named [0xee, 0xe8, 0xaa], :PaleGoldenRod, :PaleGoldenrod
  named [0x98, 0xfb, 0x98], :PaleGreen
  named [0xaf, 0xee, 0xee], :PaleTurquoise
  named [0xdb, 0x70, 0x93], :PaleVioletRed
  named [0xff, 0xef, 0xd5], :PapayaWhip
  named [0xff, 0xda, 0xb9], :PeachPuff, :Peachpuff
  named [0xcd, 0x85, 0x3f], :Peru
  named [0xff, 0xc0, 0xcb], :Pink
  named [0xdd, 0xa0, 0xdd], :Plum
  named [0xb0, 0xe0, 0xe6], :PowderBlue
  named [0x80, 0x00, 0x80], :Purple
  named [0xff, 0x00, 0x00], :Red
  named [0xbc, 0x8f, 0x8f], :RosyBrown
  named [0x41, 0x69, 0xe1], :RoyalBlue
  named [0x8b, 0x45, 0x13], :SaddleBrown
  named [0xfa, 0x80, 0x72], :Salmon
  named [0xf4, 0xa4, 0x60], :SandyBrown
  named [0x2e, 0x8b, 0x57], :SeaGreen
  named [0xff, 0xf5, 0xee], :SeaShell, :Seashell
  named [0xa0, 0x52, 0x2d], :Sienna
  named [0xc0, 0xc0, 0xc0], :Silver
  named [0x87, 0xce, 0xeb], :SkyBlue
  named [0x6a, 0x5a, 0xcd], :SlateBlue
  named [0x70, 0x80, 0x90], :SlateGray, :SlateGrey
  named [0xff, 0xfa, 0xfa], :Snow
  named [0x00, 0xff, 0x7f], :SpringGreen
  named [0x46, 0x82, 0xb4], :SteelBlue
  named [0xd2, 0xb4, 0x8c], :Tan
  named [0x00, 0x80, 0x80], :Teal
  named [0xd8, 0xbf, 0xd8], :Thistle
  named [0xff, 0x63, 0x47], :Tomato
  named [0x40, 0xe0, 0xd0], :Turquoise
  named [0xee, 0x82, 0xee], :Violet
  named [0xd0, 0x20, 0x90], :VioletRed
  named [0xf5, 0xde, 0xb3], :Wheat
  named [0xff, 0xff, 0xff], :White
  named [0xf5, 0xf5, 0xf5], :WhiteSmoke
  named [0xff, 0xff, 0x00], :Yellow
  named [0x9a, 0xcd, 0x32], :YellowGreen
end

