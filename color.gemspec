# -*- encoding: utf-8 -*-
# stub: color 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "color".freeze
  s.version = "2.1.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/halostatue/color/issues", "changelog_uri" => "https://github.com/halostatue/color/blob/main/CHANGELOG.md", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/halostatue/color" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Austin Ziegler".freeze, "Matt Lyon".freeze]
  s.date = "2025-08-08"
  s.description = "Color is a Ruby library to provide RGB, CMYK, HSL, and other color space manipulation support to applications that require it. It provides optional named RGB colors that are commonly supported in HTML, SVG, and X11 applications.  The Color library performs purely mathematical manipulation of the colors based on color theory without reference to device color profiles (such as sRGB or Adobe RGB). For most purposes, when working with RGB and HSL color spaces, this won't matter. Absolute color spaces (like CIE LAB and CIE XYZ) cannot be reliably converted to relative color spaces (like RGB) without color profiles. When necessary for conversions, Color provides D65 and D50 reference white values in Color::XYZ.  Color 2.1 fixes a Color::XYZ bug where the values were improperly clamped and adds more Color::XYZ white points for standard illuminants. It builds on the Color 2.0 major release, dropping support for all versions of Ruby prior to 3.2 as well as removing or renaming a number of features. The main breaking changes are:  - Color classes are immutable Data objects; they are no longer mutable. - RGB named colors are no longer loaded on gem startup, but must be required   explicitly (this is _not_ done via `autoload` because there are more than 100   named colors with spelling variations) with `require \"color/rgb/colors\"`. - Color palettes have been removed. - `Color::CSS` and `Color::CSS#[]` have been removed.".freeze
  s.email = ["halostatue@gmail.com".freeze, "matt@postsomnia.com".freeze]
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "CODE_OF_CONDUCT.md".freeze, "CONTRIBUTING.md".freeze, "CONTRIBUTORS.md".freeze, "LICENCE.md".freeze, "Manifest.txt".freeze, "README.md".freeze, "SECURITY.md".freeze, "licences/dco.txt".freeze]
  s.files = ["CHANGELOG.md".freeze, "CODE_OF_CONDUCT.md".freeze, "CONTRIBUTING.md".freeze, "CONTRIBUTORS.md".freeze, "LICENCE.md".freeze, "Manifest.txt".freeze, "README.md".freeze, "Rakefile".freeze, "SECURITY.md".freeze, "lib/color.rb".freeze, "lib/color/cielab.rb".freeze, "lib/color/cmyk.rb".freeze, "lib/color/grayscale.rb".freeze, "lib/color/hsl.rb".freeze, "lib/color/rgb.rb".freeze, "lib/color/rgb/colors.rb".freeze, "lib/color/version.rb".freeze, "lib/color/xyz.rb".freeze, "lib/color/yiq.rb".freeze, "licences/dco.txt".freeze, "test/fixtures/cielab.json".freeze, "test/minitest_helper.rb".freeze, "test/test_cmyk.rb".freeze, "test/test_color.rb".freeze, "test/test_grayscale.rb".freeze, "test/test_hsl.rb".freeze, "test/test_rgb.rb".freeze, "test/test_yiq.rb".freeze]
  s.homepage = "https://github.com/halostatue/color".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.2".freeze)
  s.rubygems_version = "3.6.9".freeze
  s.summary = "Color is a Ruby library to provide RGB, CMYK, HSL, and other color space manipulation support to applications that require it".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<hoe>.freeze, ["~> 4.0".freeze])
  s.add_development_dependency(%q<hoe-halostatue>.freeze, ["~> 2.1".freeze, ">= 2.1.1".freeze])
  s.add_development_dependency(%q<hoe-git>.freeze, ["~> 1.6".freeze])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 5.8".freeze])
  s.add_development_dependency(%q<minitest-autotest>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<minitest-focus>.freeze, ["~> 1.1".freeze])
  s.add_development_dependency(%q<minitest-moar>.freeze, ["~> 0.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 10.0".freeze, "< 14".freeze])
  s.add_development_dependency(%q<rdoc>.freeze, [">= 0.0".freeze, "< 7".freeze])
  s.add_development_dependency(%q<standard>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<json>.freeze, [">= 0.0".freeze])
  s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.22".freeze])
  s.add_development_dependency(%q<simplecov-lcov>.freeze, ["~> 0.8".freeze])
end
