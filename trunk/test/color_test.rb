$:.unshift(File.dirname(__FILE__) + "/../lib/")

require 'test/unit'
require 'color'

class ColorTest < Test::Unit::TestCase
  
  COLORS = {
    :red =>       {:html => '#ff0000', :rgb => [255,0,0]},
    :yellow =>    {:html => '#ffff00', :rgb => [255,255,0]},
    :blue =>      {:html => '#0000ff', :rgb => [0,0,255]},
    :brown =>     {:html => '#a16328', :rgb => [161,99,40]},
    :cayenne =>   {:html => '#8d0000', :rgb => [141,0,0]},
    :carnation => {:html => '#ff5ed0', :rgb => [255,94,208]}
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
  
end