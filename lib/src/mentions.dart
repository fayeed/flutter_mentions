part of flutter_mentions;

class MentionItem {
  MentionItem({this.id, this.display});

  final String id;
  final String display;
}

class Mention {
  Mention({
    this.data,
    this.style,
    this.trigger,
    this.matchAll = false,
  });

  final String trigger;
  final List<MentionItem> data;
  final TextStyle style;
  final bool matchAll;
}
