## [3.1.0] - 2020-01-10

- Add `SelectableLinkify`, for selectable linkified text
- Add all props for RichText

## [3.0.0] - 2019-12-27

- Update to `linkify` v2.0.0.
- Change `humanize` to `options` for `linkify`
- Change `linkTypes` to `linkifiers` for `linkify`

## [2.1.0] - 2019-03-23

- Split to [`linkify`](https://github.com/Cretezy/linkify) package.
  - This *might* break if you were using the internal `linkify` method.
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
