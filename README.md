<p align="center">
  <img src="https://i.imgur.com/JVM530f.png" width="240" />
  <h1 align="center" style="font-size: 48px;">📛 Flutter Mentions</h1>
  <h5 align="center">A simple flutter input widget to add <code>@</code> mentions functionality to your app</h5>
</p>

## Install 📦

To use this package, add `flutter_mentions` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

You will need to add `flutter_mentions` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_mentions: ^0.0.1
```

Then, run `flutter packages get` in your terminal.

## Usage 💻

To use this package you must first wrap your top most widget with `Portal` as this package uses `flutter_portal` to show the suggestions list.

> [Portal], is the equivalent of [Overlay].
>
>  This widget will need to be inserted above the widget that needs to render
>  _under_ your overlays.
>
>  If you want to display your overlays on the top of _everything_, a good place
>  to insert that [Portal] is above `MaterialApp`:
>
>  ```dart
>  Portal(
>    child: MaterialApp(
>      ...
>    )
>  );
>  ```
>
>  (works for `CupertinoApp` too)
>
>  This way [Portal] will render above everything. But you could place it
>  somewhere else to change the clip behavior.

### Widgets:

**FlutterMention :**

- `mentions: List<Mention>` - List of Mention that the user is allowed to triggered.
- `suggestionPosition: SuggestionPosition` - Suggestion modal position, can be alligned to [Top] or [Bottom].
- `onMentionAdd: Function(Map<String, dynamic>)` - Triggers when the suggestion was added by tapping on suggestion.
- `suggestionListHeight: double` - Max height for the suggestion list. Defaults for 300.0.
- `onMarkupChanged: Function(String)` - A Functioned which is triggered when ever the input changes but with the markup of the selected mentions.
- `suggestionListDecoration: BoxDecoration` - Decoration for the Suggestion list.
- Supports all the other properties that `TextField` supports.

**Mention**

- `trigger: String` - A single character that will be used to trigger the suggestions.
- `data: List<Map<String, dynamic>>` - List of Map to represent the suggestions shown to the user. You need to provide two **Required** properties `id` & `display` both are [String] You can also have any custom properties as you like to build custom suggestion widget.
- `style: TextStyle` - Style for the mention item in Input.
- `matchAll: bool` - Should every non-suggestion with the trigger character be matched.
- `disableMarkup: bool` - Should the markup generation be disabled for this Mention Item.
- `suggestionBuilder: Widget Function(Map<String, dynamic>)` - Build Custom suggestion widget using this builder.

> example, Mention instance

```dart
Mention(
  trigger: "#",
  disableMarkup: true,
  style: TextStyle(
    color: Colors.blue,
  ),
  data: [
    {"id": "reactjs", "display": "reactjs"},
    {"id": "javascript", "display": "javascript"},
  ],
  matchAll: true,
)
```

### Example

```dart
FlutterMentions(
  key: key,
  suggestionPosition: SuggestionPosition.Top,
  maxLines: 5,
  minLines: 1,
  mentions: [
    Mention(
      trigger: "@",
      style: TextStyle(color: Colors.purple),
      data: [
        {
          "id": "61as61fsa",
          "display": "fayeedP",
          "photo": "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg"
        },
        {
          "id": "61asasgasgsag6a",
          "display": "khaled",
          "photo": "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
          style: TextStyle(color: Colors.green),
        },
      ],
    )
  ],
),       
```

You can find detailed example in [example folder](https://github.com/fayeed/flutter_mentions/blob/master/example/lib/main.dart)

## Credits 👨🏻‍💻

- flutter_portal - [Remi Rousselet](https://github.com/rrousselGit/flutter_portal)

## Found this project useful? ❤️

If you found this project useful, then please consider giving it a ⭐️ on Github and sharing it with your friends via social media.

## License ⚖️

- [MIT](https://github.com/fayeed/flutter_mentions/blob/master/LICENSE)

## API details 📝

See the [flutter_mentions.dart](https://github.com/fayeed/flutter_mentions/blob/master/lib/flutter_mentions.dart) for more API details

## Issues and feedback 💭

If you have any suggestion for including a feature or if something doesn't work, feel free to open a Github [issue](https://github.com/fayeed/flutter_mentions/issues) for us to have a discussion on it.
