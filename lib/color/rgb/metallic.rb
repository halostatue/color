# -*- ruby encoding: utf-8 -*-

class Color::RGB
  # This namespace contains some RGB metallic colours suggested by Jim
  # Freeze.
  module Metallic; end

  class << self
    private
    def metallic(rgb, *names)
      __named_color(Metallic, new(*rgb), *names)
    end
  end

  metallic [0x99, 0x99, 0x99], :Aluminum
  metallic [0xd9, 0x87, 0x19], :CoolCopper
  metallic [0xb8, 0x73, 0x33], :Copper
  metallic [0x4c, 0x4c, 0x4c], :Iron
  metallic [0x19, 0x19, 0x19], :Lead
  metallic [0xb3, 0xb3, 0xb3], :Magnesium
  metallic [0xe6, 0xe6, 0xe6], :Mercury
  metallic [0x80, 0x80, 0x80], :Nickel
  metallic [0x60, 0x00, 0x00], :PolySilicon, :Poly
  metallic [0xcc, 0xcc, 0xcc], :Silver
  metallic [0x66, 0x66, 0x66], :Steel
  metallic [0x7f, 0x7f, 0x7f], :Tin
  metallic [0x33, 0x33, 0x33], :Tungsten
end
