part of flutter_mentions;

class AnnotationEditingController extends TextEditingController {
  final Map<String, TextStyle> mapping;
  final String pattern;
  final TextStyle style;

  AnnotationEditingController(this.mapping, this.style)
      : pattern = "(${mapping.keys.map((key) => key).join('|')})";

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    List<InlineSpan> children = [];

    text.splitMapJoin(
      RegExp("$pattern"),
      onMatch: (Match match) {
        final style = mapping[match[0]] != null
            ? mapping[match[0]]
            : mapping[mapping.keys.firstWhere((element) {
                final reg = new RegExp(element);

                print("regex matches: ${match[0]} ${reg.hasMatch(match[0])}");

                return reg.hasMatch(match[0]);
              })];

        children.add(
          TextSpan(
            text: match[0],
            style: style.merge(style),
          ),
        );
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
