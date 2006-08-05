$:.unshift(File.dirname(__FILE__) + "/../lib/")

require 'test/unit'
require 'color'

class TestColor < Test::Unit::TestCase
  
  COLORS = {
    :red =>       {:html => '#ff0000', :rgb => [255,0,0],     :hsl => [0,100,50] },
    :yellow =>    {:html => '#ffff00', :rgb => [255,255,0],   :hsl => [60,100,50] },
    :blue =>      {:html => '#0000ff', :rgb => [0,0,255],     :hsl => [240,100,50] },
    :brown =>     {:html => '#a16328', :rgb => [161,99,40],   :hsl => [29,60,39] },
    :carnation => {:html => '#ff5ed0', :rgb => [255,94,208],  :hsl => [318,100,68] },
    :cayenne =>   {:html => '#8d0000', :rgb => [141,0,0],     :hsl => [0,100,28] }
  }
  
  ## eigenclass conversion methods
  
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
      assert_equivalent color[:hsl], Color.rgb_to_hsl_human(color[:rgb])
    end
  end
  
  def test_hsl_to_rgb
    COLORS.each_value do |color|
      assert_equivalent color[:rgb], Color.hsl_to_rgb(color[:hsl])
    end
  end
  
  def test_hsl_to_rgb_with_floats
    COLORS.each_value do |color|
      assert_equivalent color[:rgb], Color.hsl_to_rgb([(color[:hsl][0]/360.0), (color[:hsl][1]/100.0), (color[:hsl][2]/100.0)])
    end
  end
  
  # instance methods
  
  def test_intialize_from_hex
    COLORS.each_value do |color|
      instance = Color.new(color[:html])
      assert_equal color[:hsl], instance.to_hsl
    end
  end
  
  def test_hue
    assert_equal 60, Color.new(COLORS[:yellow][:html]).hue
  end
  
  def test_hue_is
    assert_equal 0.1, Color.new('000000').hue = 0.1
    assert_equal 100, Color.new('000000').hue = 100
    assert_equal 80, Color.new(COLORS[:yellow][:html]).hue += 20
    # TODO: is there a way to have -= return 340 instead of -20 ?
    red = Color.new(COLORS[:red][:html])
    red.hue -= 20
    assert_equal 340, red.hue
  end
  
  def test_saturation
    assert_equal 60, Color.new(COLORS[:brown][:html]).saturation
  end
  
  def test_saturation_is
    assert_equal 0.1, Color.new('000000').saturation = 0.1
    assert_equal 10, Color.new('000000').saturation = 10
    assert_equal 80, Color.new(COLORS[:red][:html]).saturation -= 20
    assert_equal 70, Color.new(COLORS[:brown][:html]).saturation += 10
  end
  
  def test_saturation_is_lower_limit
    brown = Color.new(COLORS[:brown][:html])
    brown.saturation -= 80
    assert_equal 0, brown.saturation
  end
  
  def test_saturation_is_upper_limit
    brown = Color.new(COLORS[:brown][:html])
    brown.saturation += 80
    assert_equal 100, brown.saturation
  end
  
  def test_lightness
    assert_equal 50, Color.new(COLORS[:red][:html]).lightness
  end
  
  def test_lightness_is
    assert_equal 0.1, Color.new('000000').lightness = 0.1
    assert_equal 10, Color.new('000000').lightness = 10
    assert_equal 30, Color.new(COLORS[:red][:html]).lightness -= 20
    assert_equal 70, Color.new(COLORS[:red][:html]).lightness += 20
  end
  
  def test_lightness_is_lower_limit
    red = Color.new(COLORS[:red][:html])
    red.lightness -= 80
    assert_equal 0, red.lightness
  end
  
  def test_saturation_is_upper_limit
    red = Color.new(COLORS[:red][:html])
    red.lightness += 80
    assert_equal 100, red.lightness
  end
  
  def test_mix_with
    red, yellow = Color.new(COLORS[:red][:html]), Color.new(COLORS[:yellow][:html])
    assert_equal 30, red.mix_with(yellow, 0.5).hue
  end
  
  #helpers
  
  def assert_equivalent(target=[], input=[])
    difference = 0
    target.each_with_index {|value, index| difference += (value - input[index]).abs }
    assert difference <= 5, "[#{input.join(',')}] is not close enough to [#{target.join(',')}]"
  end
  
end