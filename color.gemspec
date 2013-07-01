# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "color"
  s.version = "1.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Austin Ziegler", "Matt Lyon"]
  s.cert_chain = ["/Users/AZiegler/.gem/gem-public_cert.pem"]
  s.date = "2013-07-01"
  s.description = "Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace\nmanipulation support to applications that require it. It also provides 152\nnamed RGB colours (184 with spelling variations) that are commonly supported in\nHTML, SVG, and X11 applications. A technique for generating monochromatic\ncontrasting palettes is also included.\n\nThe capabilities of the Color library are limited to pure mathematical\nmanipulation of the colours based on colour theory without reference to colour\nprofiles (such as sRGB or Adobe RGB). For most purposes, when working with the\nRGB and HSL colours, this won't matter. However, some colour models (like CIE\nL*a*b*) are not supported because Color does not yet support colour profiles,\ngiving no meaningful way to convert colours in absolute colour spaces (like\nL*a*b*, XYZ) to non-absolute colour spaces (like RGB).\n\nColor version 1.4.2 updates the release and install as a RubyGem to remove an\nunnecessary dependency, adds code climate analysis, and Travis CI support."
  s.email = ["austin@rubyforge.org", "matt@postsomnia.com"]
  s.extra_rdoc_files = ["History.rdoc", "Licence.rdoc", "Manifest.txt", "README.rdoc", "Contributing.rdoc", "History.rdoc", "Licence.rdoc", "README.rdoc"]
  s.files = [".hoerc", "History.rdoc", "Licence.rdoc", "Manifest.txt", "README.rdoc", "Rakefile", "lib/color.rb", "lib/color/cmyk.rb", "lib/color/css.rb", "lib/color/grayscale.rb", "lib/color/hsl.rb", "lib/color/palette.rb", "lib/color/palette/adobecolor.rb", "lib/color/palette/gimp.rb", "lib/color/palette/monocontrast.rb", "lib/color/rgb-colors.rb", "lib/color/rgb.rb", "lib/color/rgb/metallic.rb", "lib/color/yiq.rb", "test/test_adobecolor.rb", "test/test_cmyk.rb", "test/test_color.rb", "test/test_css.rb", "test/test_gimp.rb", "test/test_grayscale.rb", "test/test_hsl.rb", "test/test_monocontrast.rb", "test/test_rgb.rb", "test/test_yiq.rb", "Contributing.rdoc", ".gemtest"]
  s.homepage = "http://color.rubyforge.org"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "color"
  s.rubygems_version = "1.8.25"
  s.signing_key = "/Users/AZiegler/.gem/gem-private_key.pem"
  s.summary = "Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace manipulation support to applications that require it"
  s.test_files = ["test/test_adobecolor.rb", "test/test_cmyk.rb", "test/test_color.rb", "test/test_css.rb", "test/test_gimp.rb", "test/test_grayscale.rb", "test/test_hsl.rb", "test/test_monocontrast.rb", "test/test_rgb.rb", "test/test_yiq.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, ["~> 5.0"])
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<hoe-bundler>, ["~> 1.2"])
      s.add_development_dependency(%q<hoe-doofus>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
      s.add_development_dependency(%q<hoe-git>, ["~> 1.5"])
      s.add_development_dependency(%q<hoe-rubygems>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe-travis>, ["~> 1.2"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.6"])
    else
      s.add_dependency(%q<minitest>, ["~> 5.0"])
      s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<hoe-bundler>, ["~> 1.2"])
      s.add_dependency(%q<hoe-doofus>, ["~> 1.0"])
      s.add_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
      s.add_dependency(%q<hoe-git>, ["~> 1.5"])
      s.add_dependency(%q<hoe-rubygems>, ["~> 1.0"])
      s.add_dependency(%q<hoe-travis>, ["~> 1.2"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<hoe>, ["~> 3.6"])
    end
  else
    s.add_dependency(%q<minitest>, ["~> 5.0"])
    s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<hoe-bundler>, ["~> 1.2"])
    s.add_dependency(%q<hoe-doofus>, ["~> 1.0"])
    s.add_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
    s.add_dependency(%q<hoe-git>, ["~> 1.5"])
    s.add_dependency(%q<hoe-rubygems>, ["~> 1.0"])
    s.add_dependency(%q<hoe-travis>, ["~> 1.2"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<hoe>, ["~> 3.6"])
  end
end
