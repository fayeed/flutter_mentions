part of flutter_mentions;

/// Position for the suggestion list relative to the input field.
enum SuggestionPosition { top, bottom }

/// Helper class to track word positions in the text.
class LengthMap {
  LengthMap({
    required this.start,
    required this.end,
    required this.str,
  });

  final String str;
  final int start;
  final int end;
}

/// Configuration for a mention trigger.
///
/// Each [Mention] defines a trigger character and its associated data
/// for suggestions.
class Mention {
  Mention({
    required this.trigger,
    this.data = const [],
    this.style,
    this.matchAll = false,
    this.suggestionBuilder,
    this.disableMarkup = false,
    this.markupBuilder,
  }) : assert(trigger.length == 1, 'Trigger must be a single character');

  /// A single character that will be used to trigger the suggestions.
  final String trigger;

  /// List of Map to represent the suggestions shown to the user.
  ///
  /// You need to provide two properties `id` & `display` both are [String].
  /// You can also have any custom properties as you like to build custom suggestion
  /// widget.
  final List<Map<String, dynamic>> data;

  /// Style for the mention item in Input.
  final TextStyle? style;

  /// Should every non-suggestion with the trigger character be matched.
  final bool matchAll;

  /// Should the markup generation be disabled for this Mention Item.
  final bool disableMarkup;

  /// Build Custom suggestion widget using this builder.
  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  /// Allows to set custom markup for the mentioned item.
  final String Function(String trigger, String mention, String value)?
      markupBuilder;
}

/// Internal class to store annotation metadata for matched mentions.
class Annotation {
  Annotation({
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
