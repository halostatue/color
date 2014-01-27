# This namespace contains some CSS colour names.
module Color::CSS
  # Returns the RGB colour for name or +nil+ if the name is not valid.
  def self.[](name)
    Color::RGB.by_name(name) { nil }
  end
end
