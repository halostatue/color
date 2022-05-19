# stub: color 2.0pre0 ruby lib

Gem::Specification.new do |s|
  s.name = "color".freeze
  s.version = "2.0pre0"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = {"bug_tracker_uri" => "https://github.com/halostatue/color/issues", "homepage_uri" => "https://github.com/halostatue/color", "source_code_uri" => "https://github.com/halostatue/color"} if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Austin Ziegler".freeze, "Matt Lyon".freeze]
  s.description = "Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace\nmanipulation support to applications that require it. It also provides 152\nnamed RGB colours (184 with spelling variations) that are commonly supported in\nHTML, SVG, and X11 applications. A technique for generating monochromatic\ncontrasting palettes is also included.\n\nThe Color library performs purely mathematical manipulation of the colours\nbased on colour theory without reference to colour profiles (such as sRGB or\nAdobe RGB). For most purposes, when working with RGB and HSL colour spaces,\nthis won't matter. Absolute colour spaces (like CIE L*a*b* and XYZ) and cannot\nbe reliably converted to relative colour spaces (like RGB) without colour\nprofiles.\n\n<strong>NOTE</strong>: This is a prerelease version of Color 2.0, currently\nunder development. The goal is to be mathematically more robust and do as many\ncolour transformations as possible more accurately than previously done. Many\nof the transforms will be performed with Matrix math; where it makes sense and\nincreases transformation fidelity, Rational numbers will also be used rather\nthan fractional numbers.\n\nColor 2.0 is a major release to the Color library.\n\n* Color 2.0 is no longer tested on any version of Ruby below 2.6, and changes\n  that remove compatibility with those versions will be supported.\n* INSERT FURTHER CHANGES HERE".freeze
  s.email = ["halostatue@gmail.com".freeze, "matt@postsomnia.com".freeze]
  s.extra_rdoc_files = ["Code-of-Conduct.md".freeze, "Contributing.md".freeze, "History.md".freeze, "Licence.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.files = ["Code-of-Conduct.md".freeze, "Contributing.md".freeze, "History.md".freeze, "Licence.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "Rakefile".freeze, "lib/color.rb".freeze, "lib/color/cmyk.rb".freeze, "lib/color/css.rb".freeze, "lib/color/grayscale.rb".freeze, "lib/color/hsl.rb".freeze, "lib/color/palette.rb".freeze, "lib/color/palette/adobecolor.rb".freeze, "lib/color/palette/gimp.rb".freeze, "lib/color/palette/monocontrast.rb".freeze, "lib/color/rgb.rb".freeze, "lib/color/rgb/colors.rb".freeze, "lib/color/rgb/contrast.rb".freeze, "lib/color/rgb/metallic.rb".freeze, "lib/color/yiq.rb".freeze, "test/minitest_helper.rb".freeze, "test/test_adobecolor.rb".freeze, "test/test_cmyk.rb".freeze, "test/test_color.rb".freeze, "test/test_css.rb".freeze, "test/test_gimp.rb".freeze, "test/test_grayscale.rb".freeze, "test/test_hsl.rb".freeze, "test/test_monocontrast.rb".freeze, "test/test_rgb.rb".freeze, "test/test_yiq.rb".freeze]
  s.homepage = "https://github.com/halostatue/color".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7".freeze)
  s.rubygems_version = "3.3.13".freeze
  s.summary = "Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace manipulation support to applications that require it".freeze

  if s.respond_to? :specification_version
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency
    s.add_development_dependency("minitest".freeze, ["~> 5.15"])
    s.add_development_dependency("hoe-doofus".freeze, ["~> 1.0"])
    s.add_development_dependency("hoe-gemspec2".freeze, ["~> 1.1"])
    s.add_development_dependency("hoe-git".freeze, ["~> 1.6"])
    s.add_development_dependency("hoe-rubygems".freeze, ["~> 1.0"])
    s.add_development_dependency("minitest-around".freeze, ["~> 0.3"])
    s.add_development_dependency("minitest-autotest".freeze, ["~> 1.0"])
    s.add_development_dependency("minitest-bisect".freeze, ["~> 1.2"])
    s.add_development_dependency("minitest-focus".freeze, ["~> 1.1"])
    s.add_development_dependency("minitest-moar".freeze, ["~> 0.0"])
    s.add_development_dependency("minitest-pretty_diff".freeze, ["~> 0.1"])
    s.add_development_dependency("rake".freeze, [">= 10.0", "< 14.0"])
    s.add_development_dependency("standard".freeze, ["~> 1.0"])
    s.add_development_dependency("simplecov".freeze, ["~> 0.7"])
    s.add_development_dependency("rdoc".freeze, [">= 4.0", "< 7"])
    s.add_development_dependency("hoe".freeze, ["~> 3.23"])
  else
    s.add_dependency("minitest".freeze, ["~> 5.15"])
    s.add_dependency("hoe-doofus".freeze, ["~> 1.0"])
    s.add_dependency("hoe-gemspec2".freeze, ["~> 1.1"])
    s.add_dependency("hoe-git".freeze, ["~> 1.6"])
    s.add_dependency("hoe-rubygems".freeze, ["~> 1.0"])
    s.add_dependency("minitest-around".freeze, ["~> 0.3"])
    s.add_dependency("minitest-autotest".freeze, ["~> 1.0"])
    s.add_dependency("minitest-bisect".freeze, ["~> 1.2"])
    s.add_dependency("minitest-focus".freeze, ["~> 1.1"])
    s.add_dependency("minitest-moar".freeze, ["~> 0.0"])
    s.add_dependency("minitest-pretty_diff".freeze, ["~> 0.1"])
    s.add_dependency("rake".freeze, [">= 10.0", "< 14.0"])
    s.add_dependency("standard".freeze, ["~> 1.0"])
    s.add_dependency("simplecov".freeze, ["~> 0.7"])
    s.add_dependency("rdoc".freeze, [">= 4.0", "< 7"])
    s.add_dependency("hoe".freeze, ["~> 3.23"])
  end
end
