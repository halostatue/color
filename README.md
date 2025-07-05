# Color -- Color Math in Ruby

- code :: <https://github.com/halostatue/color>
- issues :: <https://github.com/halostatue/color/issues>
- changelog :: <https://github.com/halostatue/color/blob/main/CHANGELOG.md>
- continuous integration ::
  [![Build Status](https://github.com/halostatue/color/actions/workflows/ci.yml/badge.svg)][ci-workflow]
- test coverage ::
  [![Coverage](https://coveralls.io/repos/halostatue/color/badge.svg?branch=main&service=github)][coveralls]

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

Color 2.0 is a major release, dropping support for all versions of Ruby prior to
3.2 as well as removing or renaming a number of features. The main breaking
changes are:

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

[ci-workflow]: https://github.com/halostatue/color/actions/workflows/ci.yml
[coveralls]: https://coveralls.io/github/halostatue/color?branch=main
