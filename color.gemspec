# -*- encoding: utf-8 -*-
# stub: color 1.8 ruby lib

Gem::Specification.new do |s|
  s.name = "color".freeze
  s.version = "1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/halostatue/color/issues", "homepage_uri" => "https://github.com/halostatue/color", "source_code_uri" => "https://github.com/halostatue/color" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Austin Ziegler".freeze, "Matt Lyon".freeze]
  s.date = "2022-09-29"
  s.description = "Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace\nmanipulation support to applications that require it. It also provides 152\nnamed RGB colours (184 with spelling variations) that are commonly supported in\nHTML, SVG, and X11 applications. A technique for generating monochromatic\ncontrasting palettes is also included.\n\nThe Color library performs purely mathematical manipulation of the colours\nbased on colour theory without reference to colour profiles (such as sRGB or\nAdobe RGB). For most purposes, when working with RGB and HSL colour spaces,\nthis won't matter. Absolute colour spaces (like CIE L*a*b* and XYZ) and cannot\nbe reliably converted to relative colour spaces (like RGB) without colour\nprofiles.\n\nColor 1.8 adds an alpha parameter to all <tt>#css_rgba</tt> calls, fixes a bug\nexposed by new constant lookup semantics in Ruby 2, and ensures that\n<tt>Color.equivalent?</tt> can only be called on Color instances.\n\nBarring bugs introduced in this release, this (really) is the last version of\ncolor that supports Ruby 1.8, so make sure that your gem specification is set\nproperly (to <tt>~> 1.8</tt>) if that matters for your application. This\nversion will no longer be supported one year after the release of color 2.0.".freeze
  s.email = ["halostatue@gmail.com".freeze, "matt@postsomnia.com".freeze]
  s.extra_rdoc_files = ["Code-of-Conduct.rdoc".freeze, "Contributing.rdoc".freeze, "History.rdoc".freeze, "Licence.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.files = [".autotest".freeze, ".coveralls.yml".freeze, ".gemtest".freeze, ".hoerc".freeze, ".minitest.rb".freeze, ".travis.yml".freeze, "Code-of-Conduct.rdoc".freeze, "Contributing.rdoc".freeze, "Gemfile".freeze, "History.rdoc".freeze, "Licence.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "Rakefile".freeze, "lib/color.rb".freeze, "lib/color/cmyk.rb".freeze, "lib/color/css.rb".freeze, "lib/color/grayscale.rb".freeze, "lib/color/hsl.rb".freeze, "lib/color/palette.rb".freeze, "lib/color/palette/adobecolor.rb".freeze, "lib/color/palette/gimp.rb".freeze, "lib/color/palette/monocontrast.rb".freeze, "lib/color/rgb.rb".freeze, "lib/color/rgb/colors.rb".freeze, "lib/color/rgb/contrast.rb".freeze, "lib/color/rgb/metallic.rb".freeze, "lib/color/yiq.rb".freeze, "test/minitest_helper.rb".freeze, "test/test_adobecolor.rb".freeze, "test/test_cmyk.rb".freeze, "test/test_color.rb".freeze, "test/test_css.rb".freeze, "test/test_gimp.rb".freeze, "test/test_grayscale.rb".freeze, "test/test_hsl.rb".freeze, "test/test_monocontrast.rb".freeze, "test/test_rgb.rb".freeze, "test/test_yiq.rb".freeze]
  s.homepage = "https://github.com/halostatue/color".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace manipulation support to applications that require it".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.16"])
    s.add_development_dependency(%q<hoe-doofus>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<hoe-gemspec2>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<hoe-git>.freeze, ["~> 1.6"])
    s.add_development_dependency(%q<hoe-travis>.freeze, ["~> 1.2"])
    s.add_development_dependency(%q<minitest-around>.freeze, ["~> 0.3"])
    s.add_development_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<minitest-bisect>.freeze, ["~> 1.2"])
    s.add_development_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<minitest-moar>.freeze, ["~> 0.0"])
    s.add_development_dependency(%q<minitest-pretty_diff>.freeze, ["~> 0.1"])
    s.add_development_dependency(%q<rake>.freeze, ["< 14"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.7"])
    s.add_development_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
    s.add_development_dependency(%q<hoe>.freeze, ["~> 3.25"])
  else
    s.add_dependency(%q<minitest>.freeze, ["~> 5.16"])
    s.add_dependency(%q<hoe-doofus>.freeze, ["~> 1.0"])
    s.add_dependency(%q<hoe-gemspec2>.freeze, ["~> 1.1"])
    s.add_dependency(%q<hoe-git>.freeze, ["~> 1.6"])
    s.add_dependency(%q<hoe-travis>.freeze, ["~> 1.2"])
    s.add_dependency(%q<minitest-around>.freeze, ["~> 0.3"])
    s.add_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
    s.add_dependency(%q<minitest-bisect>.freeze, ["~> 1.2"])
    s.add_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
    s.add_dependency(%q<minitest-moar>.freeze, ["~> 0.0"])
    s.add_dependency(%q<minitest-pretty_diff>.freeze, ["~> 0.1"])
    s.add_dependency(%q<rake>.freeze, ["< 14"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.7"])
    s.add_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
    s.add_dependency(%q<hoe>.freeze, ["~> 3.25"])
  end
end
