# Changelog

## 2.1.1 / 2025-08-08

Color 2.1.1 fixes a bug where `Color::RGB::Black` and `Color::RGB::White` are no
longer defined automatically because they are part of `color/rgb/colors`.
Internally, this defines `Color::RGB::Black000` and `Color::RGB::WhiteFFF`.

## 2.1.0 / 2025-07-20

Color 2.1.0 fixes a computation bug where CIE XYZ values were improperly clamped
and adds more Color::XYZ white points for standard illuminants.

- Fixes a bug where standard illuminant white points were improperly clamped and
  was seen in `Color::RGB#to_lab` since CIELAB conversions must go through the
  XYZ color model. Even though we were using the D65 white point, the Z value
  was being clamped to 1.0 instead of the correct value of ≅1.08. Reported by
  @r-plus in [#45][issue-45] and fixed in [#45][pr-46].

  The resulting Color::LAB values are not _exactly_ the same values under Color
  1.8, but they are within fractional differences deemed acceptable.

- Added more white points for standard illuminants in the Color::XYZ::WP2
  constant. The values here were derived from the
  [White points of standard illuminants][wp-std-illuminant] using the `xyY` to
  `XYZ` conversion formula where `X = (x * Y) / y` and
  `Z = ((1 - x - y) * Y) / y`. Only the values for CIE 1931 2° were computed.
  The values for Color::XYZ::D50 and Color::XYZ::D65 were replaced with these
  computed values.

## 2.0.1 / 2025-07-05

Color 2.0.1 is a minor documentation update.

## 2.0.0 / 2025-07-05

Color 2.0.0 is a major release of the Color library.

### 💣 Breaking Changes

Color 2.0 contains breaking changes. Functionality previously deprecated has
been removed, but other functionality has been changed or removed as part of
this release without prior warning.

- The minimum supported version of Ruby is 3.2.

- Color classes are now immutable implementations of Data objects (first
  introduced in Ruby 3.2). This will restrict Color 2 from running on versions
  of JRuby before JRuby 10.

- The constants `Color::COLOR_VERSION` and `Color::COLOR_TOOLS_VERSION` have
  been removed; there is only `Color::VERSION`. This reverses a planned
  deprecation decision made more than ten years ago that no longer makes sense.

- All named color classes at `Color` have been removed as planned.

- `Color::RGB::BeccaPurple` has been removed as an alias for
  `Color::RGB::RebeccaPurple`.

- The pseudo-constructor `Color.new` has been removed.

- Color class constructors no longer yield the constructed color if a block is
  passed.

- Renamed `Color::COLOR_EPSILON` and `Color::COLOR_TOLERANCE` to
  `Color::EPSILON` and `Color::TOLERANCE`. These aren't private constants
  because they need to be accessed throughout Color, but they are _internal_
  constants that should not be used outside of the Color library or functions
  exposed therein.

- PDF format functions `#pdf_fill` and `#pdf_stroke` have been removed from
  `Color::CMYK`, `Color::Grayscale`, and `Color::RGB`. The supporting internal
  constants `Color::<class>::PDF_FORMAT_STR` have also been removed.

- Palette processing classes, `Color::Palette::AdobeColor`,
  `Color::Palette::Gimp`, and `Color::Palette::MonoContrast` have been removed.
  Persons interested in using these are encouraged to extract them from
  [Color 1.8][color-1.8] and adapt them to use Color 2.0 APIs.

- CSS methods (`#css_rgb`, `#css_rgba`, `#css_hsl`, `#css_hsla`) have been
  replaced with `#css` on color classes that have CSS representations. The
  output of `#css` differs (Color 1.8 used the legacy CSS color formats; Color
  2.0 uses modern CSS color formats).

- `Color::GrayScale` has been renamed to `Color::Grayscale`. The alias constant
  `Color::GreyScale` has been removed.

- The `#html` method has been removed from all color classes except Color::RGB.

- Named RGB colors are no longer defined automatically, but must be loaded
  explicitly by requiring `color/rgb/colors`. This resolves [#30][issue-30]. The
  use of `Color::RGB#extract_colors`, `Color::RGB.by_hex`, `Color::RGB.by_name`,
  or `Color::RGB.by_css` will require `color/rgb/colors` automatically as they
  require the presence of the named colors.

- `Color:CSS#[]` has been removed, as has the containing namespace. It has
  always been a shallow wrapper around `Color::RGB.by_name`.

### 🚀 New Features

- `Color::CIELAB` and `Color::XYZ` namespaces have been added. Separate
  implementations were submitted by David Heitzman and @stiff (in [#8][pr-8] and
  [#11][pr-11]), but I have reworked the code substantially. These
  implementations were originally as `Color::LAB` and include a new contrast
  calculation using the ΔE\*00 algorithm.

### Internal

- Updated project structure for how I manage Ruby libraries in 2025. This
  includes increased release security (MFA is required for all releases,
  automated releases are enabled), full GitHub Actions, Dependabot, Standard
  Ruby, and more.

- Charles Nutter re-added JRuby support in CI. [#36][pr-36]

### Governance

Color 2.0 and later requires that all contributions be signed-off attesting that
the developer created the change and has the appropriate permissions or
ownership to contribute it to this project under the licence terms.

## 1.8 / 2015-10-26

- Add an optional `alpha` parameter to all `#css` calls. Thanks to Luke
  Bennellick (@bennell) and Alexander Popov (@AlexWayfer) for independently
  implemented submissions. Merged from [#15][pull-15].

- Improve constant detection to prevent incorrectly identified name collisions
  with various other libraries such as Azure deployment tools. Based on work by
  Matthew Draper (@matthewd) in [#24][pull-24].

- Prevent `Color.equivalent?` comparisons from using non-Color types for
  comparison. Fix provided by Benjamin Guest (@bguest) in [#18][pull-18].

- This project now has a [Code of Conduct](CODE_OF_CONDUCT.md).

## 1.7.1 / 2014-06-12

- Renamed `Color::RGB::BeccaPurple` to `Color::RGB::RebeccaPurple` as stipulated
  by Eric Meyer. For purposes of backwards compatibility, the previous name is
  still permitted, but its use is strongly discouraged, and it will be removed
  in the Color 2.0 release.
  <http://meyerweb.com/eric/thoughts/2014/06/19/rebeccapurple/>

## 1.7 / 2014-06-12

- Added `Color::RGB::BeccaPurple` (#663399) in honour of Rebecca Meyer, the
  daughter of Eric Meyer, who passed away on the 7 June 2014. Her favourite
  color was purple. `#663399becca`
  <https://twitter.com/meyerweb/status/476089708674428929>
  <http://www.zeldman.com/2014/06/10/the-color-purple/>
  <http://discourse.specifiction.org/t/name-663399-becca-purple-in-css4-color/225>

- Changed the homepage in the gem to point to GitHub instead of RubyForge, which
  has been shut down. Fixes [#10][issue-10], reported by @voxik.

## 1.6 / 2014-05-19

- Aaron Hill (@armahillo) implemented the CIE Delta E 94 method by which an RGB
  color can be asked for the closest matching color from a list of provided
  colors. Fixes [#5][issue-5].

- To implement `#closest_match` and `#delta_e94`, conversion methods for sRGB to
  XYZ and XYZ to L\*a\*b\* space were implemented. These should be considered
  experimental.

- Ensured that the gem manifest was up-to-date. Fixes [#4][issue-4] reported by
  @boutil. Thanks!

- Fixed problems with Travis builds. Note that Ruby 1.9.2 is no longer tested.
  Rubinius remains in a 'failure-tolerated' mode.

- Color 1.6 is, barring security patches, the last release of Color that will
  support Ruby 1.8.

## 1.5.1 / 2014-01-28

- color 1.5 was a yanked release.

- Added new methods to `Color::RGB` to make it so that the default defined
  colors can be looked up by hex, name, or both.

- Added a method to `Color::RGB` to extract colors from text by hex, name, or
  both.

- Added new common methods for color names. Converted colors do not retain
  names.

- Restructured color comparisons to use protocols instead of custom
  implementations. This makes it easier to implement new color classes. To make
  this work, color classes should `include` Color only need to implement
  `#coerce(other)`, `#to_a`, and supported conversion methods (e.g., `#to_rgb`).

- Added @daveheitzman's initial implementation of a RGB contrast method as an
  extension file: `require 'color/rgb/contrast'`. This method and the value it
  returns should be considered experimental; it requires further examination to
  ensure that the results produced are consistent with the contrast comparisons
  used in `Color::Palette::MonoContrast`.

- Reducing duplicated code.

- Moved `lib/color/rgb-colors.rb` to `lib/color/rgb/colors.rb`.

- Improved the way that named colors are specified internally.

- Fixed bugs with Ruby 1.8.7 that may have been introduced in color 1.4.2.

- Added simplecov for test coverage analysis.

- Modernized Travis CI support.

## 1.4.2 / 2013-06-30

- Modernized Hoe installation of Color, removing some dependencies.

- Switched to Minitest.

- Turned on Travis CI.

- Started using Code Climate.

- Small code formatting cleanup that touched pretty much every file.

## 1.4.1 / 2010-02-03

- Imported to GitHub.

- Converted to Hoe 2.5 spec format.

## 1.4.0 / 2007-02-11

- Merged Austin Ziegler's color-tools library (previously part of the Ruby PDF
  Tools project) with Matt Lyon's color library.

  - The HSL implementation from the Color class has been merged into
    `Color::HSL`. Color is a module the way it was for color-tools.

  - A thin veneer has been written to allow Color::new to return a `Color::HSL`
    instance; `Color::HSL` supports as many methods as possible that were
    previously supported by the Color class.

  - Values that were previously rounded by Color are no longer rounded;
    fractional values matter.

- Converted to hoe for project management.

- Moved to the next step of deprecating `Color::<name>` values; printing a
  warning for each use (see the history for color-tools 1.3.0).

- Print a warning on the access of either `VERSION` or `COLOR_TOOLS_VERSION`;
  the version constant is now `COLOR_VERSION`.

- Added humanized versions of accessors (e.g., CMYK colors now have both #cyan
  and #c to access the cyan component of the color; #cyan provides the value as
  a percentage).

- Added CSS3 formatters for RGB, RGBA, HSL, and HSLA outputs. Note that the
  Color library does not yet have a way of setting alpha opacity, so the output
  for RGBA and HSLA are at full alpha opacity (1.0). The values are output with
  two decimal places.

- Applied a patch to provide simple arithmetic color addition and subtraction to
  `Color::GrayScale` and `Color::RGB`. The patch was contributed by Jeremy
  Hinegardner. This patch also provides the ability to return the maximum RGB
  value as a grayscale color.

- Fixed two problems reported by Jean Krohn against color-tools relating to
  RGB-to-HSL and HSL-to-RGB conversion. (Color and color-tools use the same
  formulas, but the ordering of the calculations is slightly different with
  Color and did not suffer from this problem; color-tools was more sensitive to
  floating-point values and precision errors.)

- Fixed an issue with HSL/RGB conversions reported by Adam Johnson.

- Added an Adobe Color swatch (Photoshop) palette reader,
  `Color::Palette::AdobeColor` (for `.aco` files only).

## Color 0.1.0 / 2006-08-05

- Added HSL (degree, percent, percent) interface.

- Removed RGB instance variable; color is managed internally as HSL floating
  point.

- Tests!

## color-tools 1.3.0

- Added new metallic colors suggested by Jim Freeze. These are in the namespace
  `Color::Metallic`.

- Colours that were defined in the Color namespace (e.g., `Color::Red`,
  `Color::AliceBlue`) are now defined in Color::RGB (e.g., `Color::RGB::Red`,
  `Color::RGB::AliceBlue`). They are added back to the Color namespace on the
  first use of the old colors and a warning is printed. In version 1.4, this
  warning will be printed on every use of the old colors. In version 1.5, the
  backwards compatible support for colors like Color::Red will be removed
  completely.

- Added the `Color::CSS` module that provides a name lookup of
  `Color::RGB`-namespace constants with `Color::CSS[name]`. Most of these colors
  (which are mirrored from the `Color::RGB` default colors) are only
  "officially" recognised under the CSS3 color module or SVG.

- Added the `Color::HSL` color space and some helper utilities to `Color::RGB`
  for color manipulation using the HSL value.

- Controlled internal value replacement to be between 0 and 1 for all colors.

- Updated `Color::Palette::Gimp` to more meaningfully deal with duplicate named
  colors. Named colors now return an array of colors.

- Indicated the plans for some methods and constants out to color-tools 2.0.

- Added unit tests and fixed a number of hidden bugs because of them.

## color-tools 1.2.0

- Changed installer from a custom-written install.rb to setup.rb 3.3.1-modified.

- Added `Color::GreyScale` (or `Color::GrayScale`).

- Added `Color::YIQ`. This color definition is incomplete; it does not have
  conversions from YIQ to other color spaces.

## color-tools 1.1.0

- Added `color/palette/gimp` to support the reading and use of GIMP color
  palettes.

## color-tools 1.0.0

- Initial release.

[color-1.8]: https://github.com/halostatue/color/tree/v1.8
[css-color]: https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color
[css-device-cmyk]: https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/device-cmyk
[issue-10]: https://github.com/halostatue/color/issues/10
[issue-30]: https://github.com/halostatue/color/issues/30
[issue-45]: https://github.com/halostatue/color/issues/45
[pr-11]: https://github.com/halostatue/color/pull/11
[pr-36]: https://github.com/halostatue/color/pull/36
[pr-46]: https://github.com/halostatue/pull/46
[pr-8]: https://github.com/halostatue/color/pulls/8
[wp-std-illuminant]: https://en.wikipedia.org/wiki/Standard_illuminant#White_points_of_standard_illuminants
