## [6.0.0] - 2023-05-15

- Update to `linkify` v5
- Make sure it works with latest Flutter
- Merge Add LinkifySpan ([#108](https://github.com/Cretezy/flutter_linkify/pull/108))
- Merge Fix unit tests ([#111](https://github.com/Cretezy/flutter_linkify/pull/111))
- Merge Use bodyText2 only if there's no style passed in parameters ([#96](https://github.com/Cretezy/flutter_linkify/pull/96))
  - Now uses `bodyMedium`

## [5.0.2] - 2021-04-12

- Fix SelectableText only supports TextSpan exception for Flutter 2 ([#80](https://github.com/Cretezy/flutter_linkify/pull/80), thanks [MohamedEL-Torky](https://github.com/MohamedEL-Torky)!)

## [5.0.1] - 2021-04-12

- Fix for `maxLines` ([#80](https://github.com/Cretezy/flutter_linkify/pull/85), thanks [ChristianGaertner](https://github.com/ChristianGaertner)!)

## [5.0.0] - 2021-03-04

- Add null-safety support. Now required Dart >=2.12

## [4.1.0] - 2020-02-26

- Make mouse hover a pointer ([#70](https://github.com/Cretezy/flutter_linkify/pull/70), thanks [gsvano](https://github.com/gsvano)!)
- Expose `minLines` ([#74](https://github.com/Cretezy/flutter_linkify/pull/74), thanks [Chralu](https://github.com/Chralu)!)

## [4.0.2] - 2020-11-05

- Added unit tests

## [4.0.1] - 2020-11-05

- Release of 4.0.0, forgot to bump version in README

## [4.0.0] - 2020-11-05

- Change from `RichText` to `Text.rich` ([#53](https://github.com/Cretezy/flutter_linkify/pull/53), thanks [@Sorunome](https://github.com/Sorunome)!)
- Added minimum Flutter version of 1.13.8 ([#44](https://github.com/Cretezy/flutter_linkify/issues/44), thanks [@jamesderlin](https://github.com/jamesderlin)!)

**Major version has been bumped**:

- `linkify` (the underlying parsing library) has been upgrade to v3
  - Expand parsing to `www.` URLs ([#21](https://github.com/Cretezy/linkify/pull/21), thanks [@SpencerLindemuth](https://github.com/SpencerLindemuth)!)
  - Add `\r` parsing, requires Dart >=2.4 ([#26](https://github.com/Cretezy/linkify/pull/26), thanks [@hpoul](https://github.com/hpoul)!)
  - Update loose URL regex to make it more reliable (thanks for [the suggestion](https://github.com/Cretezy/linkify/issues/19#issuecomment-640587130) [@olestole](https://github.com/olestole)!)
- Minimum version of Flutter has been upgrade

## [3.1.3] - 2020-05-07

- Update `body1` to `bodyText2`

## [3.1.2] - 2020-04-24

- Forgot to bump README version

## [3.1.1] - 2020-04-24

- Update to `linkify` v2.1.0

## [3.1.0] - 2020-01-10

- Add `SelectableLinkify`, for selectable linkified text
- Add all props for RichText

## [3.0.0] - 2019-12-27

- Update to `linkify` v2.0.0
- Change `humanize` to `options` for `linkify`
- Change `linkTypes` to `linkifiers` for `linkify`

## [2.1.0] - 2019-03-23

- Split to [`linkify`](https://github.com/Cretezy/linkify) package.
  - This _might_ break if you were using the internal `linkify` method.
- Add text alignment ([#11](https://github.com/Cretezy/flutter_linkify/issues/11)).

## [2.0.0] - 2019-03-17

- Add email address linking (thanks [PieterAelse](https://github.com/PieterAelse)! [#8](https://github.com/Cretezy/flutter_linkify/pull/8)).
- Breaking: Change API to pass a `LinkableElement` to the `onOpen` callback:
  - Accessing the URL can be done by using `link.url`.
  - You can check using `is` if it is a `LinkElement` or `EmailElement` for custom handling.
- Added `linkTypes` option to enable/disable parsing URLs/emails.
- More line break fixes (should be the last! [#9](https://github.com/Cretezy/flutter_linkify/issues/9)).

## [1.1.1] - 2019-03-03

- Fix `humanize` option on multi-link text (not being passed down).

## [1.1.0] - 2019-02-19

- Add `humanize` option to remove protocol.

## [1.0.4] - 2019-02-19

- Fix bug with newlines ([#1](https://github.com/Cretezy/flutter_linkify/issues/1))

## [1.0.3] - 2018-11-06

- Fix another bug with whitespace ([#1](https://github.com/Cretezy/flutter_linkify/issues/1))

## [1.0.2] - 2018-11-05

- Fix bug with whitespace ([#1](https://github.com/Cretezy/flutter_linkify/issues/1))

## [1.0.1] - 2018-09-15

- Add more documentation.

## [1.0.0+1] - 2018-09-15

- Update description.

## [1.0.0] - 2018-09-15

- Initial release.
