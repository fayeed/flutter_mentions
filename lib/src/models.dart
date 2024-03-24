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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LengthMap &&
          runtimeType == other.runtimeType &&
          str == other.str &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => Object.hash(str, start, end);
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MentionData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          display == other.display &&
          style == other.style;

  @override
  int get hashCode => Object.hash(id, display, style);
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
  Widget suggestionBuilder(T value) {
    assert(hasSuggestionBuilder);
    return _suggestionBuilder!(value);
  }

  /// Allows to set custom markup for the mentioned item.
  final String Function(String trigger, String mention, String value)?
      markupBuilder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mention &&
          runtimeType == other.runtimeType &&
          trigger == other.trigger &&
          data == other.data &&
          style == other.style &&
          matchAll == other.matchAll &&
          disableMarkup == other.disableMarkup &&
          _suggestionBuilder == other._suggestionBuilder &&
          markupBuilder == other.markupBuilder;

  @override
  int get hashCode => Object.hash(
        trigger,
        data,
        style,
        matchAll,
        disableMarkup,
        _suggestionBuilder,
        markupBuilder,
      );
}

@immutable
class Annotation {
  const Annotation({
    required this.trigger,
    this.style,
    required this.matchAll,
    this.id,
    this.display,
    this.disableMarkup = false,
    this.markupBuilder,
  });

  final TextStyle? style;
  final bool matchAll;
  final String? id;
  final String? display;
  final String trigger;
  final bool disableMarkup;
  final String Function(String trigger, String mention, String value)?
      markupBuilder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Annotation &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          matchAll == other.matchAll &&
          id == other.id &&
          display == other.display &&
          trigger == other.trigger &&
          disableMarkup == other.disableMarkup &&
          markupBuilder == other.markupBuilder;

  @override
  int get hashCode => Object.hash(
        style,
        matchAll,
        id,
        display,
        trigger,
        disableMarkup,
        markupBuilder,
      );
}
