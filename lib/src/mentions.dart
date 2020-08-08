part of flutter_mentions;

class Mention {
  Mention({
    this.data,
    this.style,
    this.trigger,
    this.matchAll = false,
    this.suggestionBuilder,
  });

  final String trigger;
  final List<Map<String, dynamic>> data;
  final TextStyle style;
  final bool matchAll;
  final Widget Function(Map<String, dynamic>) suggestionBuilder;
}
