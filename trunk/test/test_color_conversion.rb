$:.unshift(File.dirname(__FILE__) + "/../lib/")

require 'test/unit'
require 'color'

class ColorTest < Test::Unit::TestCase
  
  COLORS = {
    :red =>       {:html => '#ff0000', :rgb => [255,0,0],     :hsl => [0,100,50] },
    :yellow =>    {:html => '#ffff00', :rgb => [255,255,0],   :hsl => [60,100,50] },
    :blue =>      {:html => '#0000ff', :rgb => [0,0,255],     :hsl => [240,100,50] },
    :brown =>     {:html => '#a16328', :rgb => [161,99,40],   :hsl => [29,60,39] },
    :cayenne =>   {:html => '#8d0000', :rgb => [141,0,0],     :hsl => [0,100,28] },
    :carnation => {:html => '#ff5ed0', :rgb => [255,94,208],  :hsl => [318,100,68] }
  }
  
  def test_rgb_to_hex
    COLORS.each_value do |color|
      assert_equal color[:html], Color.rgb_to_rgbhex(color[:rgb])
    end
  end
  
  def test_hex_to_rgb
    COLORS.each_value do |color|
      assert_equal color[:rgb], Color.rgbhex_to_rgb(color[:html])
    end
  end
  
  def test_rgb_to_hsl
    COLORS.each_value do |color|
      assert_equal color[:hsl], Color.rgb_to_hsl(color[:rgb])
    end
  end
  
end