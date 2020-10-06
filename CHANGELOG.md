## [1.0.4] - 6 Oct 2020

- Fixed an issue where if there no mention data present markupText would through an error.

## [1.0.3] - 5 Oct 2020

- `onSuggestionVisibleChanged` added - Triggers when the suggestion list visibility changed.
- `controller.showSuggestion` value notifier added.

## [1.0.2] - 5 Oct 2020

- Updated depencies.
- Fixed an issue where markup was not updated if the suggestion was pressed.

## [1.0.1] - 30 Sep 2020

- `hideSuggestionList` property added.
- Provided a funtion to manually add mentions.

## [1.0.0] - 28 Sep 2020

- `markupBuilder` added to allow users to add custom markups for mentions.
- `onSearchChange` property added.
- Mentions are now updated if mentions dependency is updated.
- `leading` & `trailing` widgets property added.
- Fixed an issue where if no mentions was found the list container would still be visible without any mentions.
- Readme updated with FAQs.

## [0.1.3] - 9 Sep 2020

- Fixed an issue were mentions list was not triggered at position 0 closes issue [#9](https://github.com/fayeed/flutter_mentions/issues/9).

## [0.1.2] - 9 Sep 2020

- Fixed an issue on android after selecting the mention from the list the cursor would go back to the start, fixed in PR [#8](https://github.com/fayeed/flutter_mentions/pull/8) by [@krishnakumarcn](https://github.com/krishnakumarcn)
- Added a `defaultText` property to provide default value to th textfield, in PR [#3](https://github.com/fayeed/flutter_mentions/pull/3) by [@imhafeez](https://github.com/imhafeez)

## [0.1.1] - 8 Aug 2020

- Static Analysis added.

## [0.1.0] - 8 Aug 2020

- Initial package released.
