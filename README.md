# Color -- Color Math in Ruby

[![RubyGems Version][shield-gems]][rubygems] ![Coveralls][shield-coveralls]
[![Build Status][shield-ci]][ci-workflow]

- code :: <https://github.com/halostatue/color>
- issues :: <https://github.com/halostatue/color/issues>
- docs :: <https://halostatue.github.io/color/>
- changelog :: <https://github.com/halostatue/color/blob/main/CHANGELOG.md>

## Description

Color is a Ruby library to provide RGB, CMYK, HSL, and other color space
manipulation support to applications that require it. It provides optional named
RGB colors that are commonly supported in HTML, SVG, and X11 applications.

The Color library performs purely mathematical manipulation of the colors based
on color theory without reference to device color profiles (such as sRGB or
Adobe RGB). For most purposes, when working with RGB and HSL color spaces, this
won't matter. Absolute color spaces (like CIE LAB and CIE XYZ) cannot be
reliably converted to relative color spaces (like RGB) without color profiles.
When necessary for conversions, Color provides D65 and D50 reference white
values in Color::XYZ.

Color 2.2 adds a minor feature where an RGB color created from values can
silently inherit the `#name` of a predefined color if `color/rgb/colors` has
already been loaded. It builds on the Color 2.0 major release, dropping support
for all versions of Ruby prior to 3.2 as well as removing or renaming a number
of features. The main breaking changes are:

- Color classes are immutable Data objects; they are no longer mutable.
- RGB named colors are no longer loaded on gem startup, but must be required
  explicitly (this is _not_ done via `autoload` because there are more than 100
  named colors with spelling variations) with `require "color/rgb/colors"`.
- Color palettes have been removed.
- `Color::CSS` and `Color::CSS#[]` have been removed.

## Example

Suppose you want to make a given RGB color a little lighter. Adjusting the RGB
color curves will change the hue and saturation will also change. Instead, use
the CIE LAB color space keeping the `color` components intact, altering only the
lightness component:

```ruby
c = Color::RGB.from_values(r, g, b).to_lab

if (t = c.l / 50.0) < 1
  c.l = 50 * ((1.0 - t) * Math.sqrt(t) + t**2)
end

c.to_rgb
```

## Color Semantic Versioning

The Color library uses a [Semantic Versioning][semver] scheme with one change:

- When PATCH is zero (`0`), it will be omitted from version references.

[ci-workflow]: https://github.com/halostatue/color/actions/workflows/ci.yml
[coveralls]: https://coveralls.io/github/halostatue/color?branch=main
[rubygems]: https://rubygems.org/gems/color
[semver]: https://semver.org/
[shield-ci]: https://img.shields.io/github/actions/workflow/status/halostatue/color/ci.yml?style=for-the-badge "Build Status"
[shield-coveralls]: https://img.shields.io/coverallsCoverage/github/halostatue/color?style=for-the-badge
[shield-gems]: https://img.shields.io/gem/v/color?style=for-the-badge "Version"
