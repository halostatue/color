# -*- encoding: utf-8 -*-
# stub: color 1.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "color"
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Austin Ziegler", "Matt Lyon"]
  s.date = "2014-04-26"
  s.description = "Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace\nmanipulation support to applications that require it. It also provides 152\nnamed RGB colours (184 with spelling variations) that are commonly supported in\nHTML, SVG, and X11 applications. A technique for generating monochromatic\ncontrasting palettes is also included.\n\nThe capabilities of the Color library are limited to pure mathematical\nmanipulation of the colours based on colour theory without reference to colour\nprofiles (such as sRGB or Adobe RGB). For most purposes, when working with the\nRGB and HSL colours, this won't matter. However, some colour models (like CIE\nL*a*b*) are not supported because Color does not yet support colour profiles,\ngiving no meaningful way to convert colours in absolute colour spaces (like\nL*a*b*, XYZ) to non-absolute colour spaces (like RGB).\n\nColor version 1.5.1 is mostly a maintenance release, fixing some bugs that may\nhave been introduced with the previous release on Ruby 1.8.7. New features\ninclude an experimental contrast comparison method for RGB colours (found in\nlib/color/rgb/contrast.rb) provided by Dave Heitzman, and methods suggested by\nThomas Sawyer based on the Spectrum library.\n\nBarring bugs introduced in this release, this will be the last version of color\nthat supports Ruby 1.8, so make sure that your gem specification is set\nproperly, to <tt>~> 1.5</tt> if that matters for your application."
  s.email = ["halostatue@gmail.com", "matt@postsomnia.com"]
  s.extra_rdoc_files = ["Contributing.rdoc", "History.rdoc", "Licence.rdoc", "Manifest.txt", "README.rdoc", "Contributing.rdoc", "History.rdoc", "Licence.rdoc", "README.rdoc"]
  s.files = [".autotest", ".gemtest", ".hoerc", ".minitest.rb", ".travis.yml", "Contributing.rdoc", "Gemfile", "History.rdoc", "Licence.rdoc", "Manifest.txt", "README.rdoc", "Rakefile", "lib/color.rb", "lib/color/cmyk.rb", "lib/color/css.rb", "lib/color/grayscale.rb", "lib/color/hsl.rb", "lib/color/palette.rb", "lib/color/palette/adobecolor.rb", "lib/color/palette/gimp.rb", "lib/color/palette/monocontrast.rb", "lib/color/rgb.rb", "lib/color/rgb/colors.rb", "lib/color/rgb/contrast.rb", "lib/color/rgb/metallic.rb", "lib/color/yiq.rb", "test/minitest_helper.rb", "test/test_adobecolor.rb", "test/test_cmyk.rb", "test/test_color.rb", "test/test_css.rb", "test/test_gimp.rb", "test/test_grayscale.rb", "test/test_hsl.rb", "test/test_monocontrast.rb", "test/test_rgb.rb", "test/test_yiq.rb"]
  s.homepage = "http://color.rubyforge.org"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.rubygems_version = "2.2.1"
  s.summary = "Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace manipulation support to applications that require it"
  s.test_files = ["test/test_adobecolor.rb", "test/test_cmyk.rb", "test/test_color.rb", "test/test_css.rb", "test/test_gimp.rb", "test/test_grayscale.rb", "test/test_hsl.rb", "test/test_monocontrast.rb", "test/test_rgb.rb", "test/test_yiq.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, ["~> 5.3"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<hoe-doofus>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
      s.add_development_dependency(%q<hoe-git>, ["~> 1.5"])
      s.add_development_dependency(%q<hoe-rubygems>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe-travis>, ["~> 1.2"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.11"])
    else
      s.add_dependency(%q<minitest>, ["~> 5.3"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<hoe-doofus>, ["~> 1.0"])
      s.add_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
      s.add_dependency(%q<hoe-git>, ["~> 1.5"])
      s.add_dependency(%q<hoe-rubygems>, ["~> 1.0"])
      s.add_dependency(%q<hoe-travis>, ["~> 1.2"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<hoe>, ["~> 3.11"])
    end
  else
    s.add_dependency(%q<minitest>, ["~> 5.3"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<hoe-doofus>, ["~> 1.0"])
    s.add_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
    s.add_dependency(%q<hoe-git>, ["~> 1.5"])
    s.add_dependency(%q<hoe-rubygems>, ["~> 1.0"])
    s.add_dependency(%q<hoe-travis>, ["~> 1.2"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<hoe>, ["~> 3.11"])
  end
end
