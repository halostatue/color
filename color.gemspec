# stub: color 2.0pre0 ruby lib

Gem::Specification.new do |s|
  s.name = "color"
  s.version = "2.0pre0"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Austin Ziegler", "Matt Lyon"]
  s.description = "Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace\nmanipulation support to applications that require it. It also provides 152\nnamed RGB colours (184 with spelling variations) that are commonly supported in\nHTML, SVG, and X11 applications. A technique for generating monochromatic\ncontrasting palettes is also included.\n\nThe Color library performs purely mathematical manipulation of the colours\nbased on colour theory without reference to colour profiles (such as sRGB or\nAdobe RGB). For most purposes, when working with RGB and HSL colour spaces,\nthis won't matter. Absolute colour spaces (like CIE L*a*b* and XYZ) and cannot\nbe reliably converted to relative colour spaces (like RGB) without colour\nprofiles.\n\n<strong>NOTE</strong>: This is a prerelease version of Color 2.0, currently is\nunder development. The goal is to be mathematically more robust and do as many\ncolour transformations as possible more accurately than previously done. Many\nof the transforms will be performed with Matrix math; where it makes sense and\nincreases transformation fidelity, Rational numbers will also be used rather\nthan fractional numbers.\n\nColor 2.0 is a major release to the Color library.\n* Color 2.0 is no longer tested on Ruby 1.8 and changes will be accepted that\n  remove compatibility with Ruby 1.8.\n* INSERT FURTHER CHANGES HERE"
  s.email = ["halostatue@gmail.com", "matt@postsomnia.com"]
  s.extra_rdoc_files = ["Code-of-Conduct.rdoc", "Contributing.rdoc", "History.rdoc", "Licence.rdoc", "Manifest.txt", "README.rdoc"]
  s.files = [".autotest", ".coveralls.yml", ".gemtest", ".hoerc", ".minitest.rb", ".travis.yml", "Code-of-Conduct.rdoc", "Contributing.rdoc", "Gemfile", "History.rdoc", "Licence.rdoc", "Manifest.txt", "README.rdoc", "Rakefile", "lib/color.rb", "lib/color/cmyk.rb", "lib/color/css.rb", "lib/color/grayscale.rb", "lib/color/hsl.rb", "lib/color/palette.rb", "lib/color/palette/adobecolor.rb", "lib/color/palette/gimp.rb", "lib/color/palette/monocontrast.rb", "lib/color/rgb.rb", "lib/color/rgb/colors.rb", "lib/color/rgb/contrast.rb", "lib/color/rgb/metallic.rb", "lib/color/yiq.rb", "test/minitest_helper.rb", "test/test_adobecolor.rb", "test/test_cmyk.rb", "test/test_color.rb", "test/test_css.rb", "test/test_gimp.rb", "test/test_grayscale.rb", "test/test_hsl.rb", "test/test_monocontrast.rb", "test/test_rgb.rb", "test/test_yiq.rb"]
  s.homepage = "https://github.com/halostatue/color"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.rubygems_version = "2.4.8"
  s.summary = "Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace manipulation support to applications that require it"

  if s.respond_to? :specification_version
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new("1.2.0")
      s.add_development_dependency("minitest", ["~> 5.8"])
      s.add_development_dependency("rdoc", ["~> 4.0"])
      s.add_development_dependency("hoe-doofus", ["~> 1.0"])
      s.add_development_dependency("hoe-gemspec2", ["~> 1.1"])
      s.add_development_dependency("hoe-git", ["~> 1.6"])
      s.add_development_dependency("hoe-travis", ["~> 1.2"])
      s.add_development_dependency("minitest-around", ["~> 0.3"])
      s.add_development_dependency("minitest-autotest", ["~> 1.0"])
      s.add_development_dependency("minitest-bisect", ["~> 1.2"])
      s.add_development_dependency("minitest-focus", ["~> 1.1"])
      s.add_development_dependency("minitest-moar", ["~> 0.0"])
      s.add_development_dependency("minitest-pretty_diff", ["~> 0.1"])
      s.add_development_dependency("rake", ["~> 10.0"])
      s.add_development_dependency("simplecov", ["~> 0.7"])
      s.add_development_dependency("hoe", ["~> 3.14"])
    else
      s.add_dependency("minitest", ["~> 5.8"])
      s.add_dependency("rdoc", ["~> 4.0"])
      s.add_dependency("hoe-doofus", ["~> 1.0"])
      s.add_dependency("hoe-gemspec2", ["~> 1.1"])
      s.add_dependency("hoe-git", ["~> 1.6"])
      s.add_dependency("hoe-travis", ["~> 1.2"])
      s.add_dependency("minitest-around", ["~> 0.3"])
      s.add_dependency("minitest-autotest", ["~> 1.0"])
      s.add_dependency("minitest-bisect", ["~> 1.2"])
      s.add_dependency("minitest-focus", ["~> 1.1"])
      s.add_dependency("minitest-moar", ["~> 0.0"])
      s.add_dependency("minitest-pretty_diff", ["~> 0.1"])
      s.add_dependency("rake", ["~> 10.0"])
      s.add_dependency("simplecov", ["~> 0.7"])
      s.add_dependency("hoe", ["~> 3.14"])
    end
  else
    s.add_dependency("minitest", ["~> 5.8"])
    s.add_dependency("rdoc", ["~> 4.0"])
    s.add_dependency("hoe-doofus", ["~> 1.0"])
    s.add_dependency("hoe-gemspec2", ["~> 1.1"])
    s.add_dependency("hoe-git", ["~> 1.6"])
    s.add_dependency("hoe-travis", ["~> 1.2"])
    s.add_dependency("minitest-around", ["~> 0.3"])
    s.add_dependency("minitest-autotest", ["~> 1.0"])
    s.add_dependency("minitest-bisect", ["~> 1.2"])
    s.add_dependency("minitest-focus", ["~> 1.1"])
    s.add_dependency("minitest-moar", ["~> 0.0"])
    s.add_dependency("minitest-pretty_diff", ["~> 0.1"])
    s.add_dependency("rake", ["~> 10.0"])
    s.add_dependency("simplecov", ["~> 0.7"])
    s.add_dependency("hoe", ["~> 3.14"])
  end
end
