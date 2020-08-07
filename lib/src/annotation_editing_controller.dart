part of flutter_mentions;

class AnnotationEditingController extends TextEditingController {
  final Map<String, TextStyle> mapping;
  final Pattern pattern;
  final bool matchAll;
  final TextStyle style;

  AnnotationEditingController(this.mapping, this.matchAll, this.style)
      : pattern =
            RegExp(mapping.keys.map((key) => RegExp.escape(key)).join('|'));

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    List<InlineSpan> children = [];
    // splitMapJoin is a bit tricky here but i found it very handy for populating children list
    text.splitMapJoin(
      matchAll ? RegExp(r"@([A-Za-z0-9])*") : pattern,
      onMatch: (Match match) {
        print(match[0]);
        children.add(TextSpan(
            text: match[0],
            style: matchAll ? this.style : style.merge(mapping[match[0]])));
        return "";
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return "";
      },
    );
    return TextSpan(style: style, children: children);
  }
}
