part of flutter_mentions;

enum SuggestionPosition { Top, Bottom }

@immutable
class LengthMap {
  const LengthMap({
    required this.start,
    required this.end,
    required this.str,
  });

  final String str;
  final int start;
  final int end;
}

@immutable
class MentionData {
  const MentionData({
    required this.id,
    required this.display,
    this.style,
  });

  final String id;
  final String display;
  final TextStyle? style;
}

typedef SuggestionsBuilder<T extends MentionData> = Widget Function(T data);

@immutable
class Mention<T extends MentionData> {
  const Mention({
    required this.trigger,
    this.data = const [],
    this.style,
    this.matchAll = false,
    Widget Function(T)? suggestionBuilder,
    this.disableMarkup = false,
    this.markupBuilder,
  }) : _suggestionBuilder = suggestionBuilder;

  /// A single character that will be used to trigger the suggestions.
  final String trigger;

  /// List of [MentionData] or it's subclass to represent the suggestions shown
  /// to the user
  final List<T> data;

  /// Style for the mention item in Input.
  final TextStyle? style;

  /// Should every non-suggestion with the trigger character be matched
  final bool matchAll;

  /// Should the markup generation be disabled for this Mention Item.
  final bool disableMarkup;

  /// Build Custom suggestion widget using this builder.
  final Widget Function(T)? _suggestionBuilder;

  bool get hasSuggestionBuilder => _suggestionBuilder != null;

  // https://github.com/dart-lang/sdk/issues/55286
  Widget suggestionBuilder(MentionData value) {
    assert(hasSuggestionBuilder);
    return _suggestionBuilder!(value as T);
  }

  /// Allows to set custom markup for the mentioned item.
  final String Function(String trigger, String mention, String value)?
      markupBuilder;
}

@immutable
class Annotation {
  const Annotation({
    required this.trigger,
    this.style,
    this.id,
    this.display,
    this.disableMarkup = false,
    this.markupBuilder,
  });

  final TextStyle? style;
  final String? id;
  final String? display;
  final String trigger;
  final bool disableMarkup;
  final String Function(String trigger, String mention, String value)?
      markupBuilder;
}
