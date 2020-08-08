part of flutter_mentions;

class AnnotationEditingController extends TextEditingController {
  final Map<String, Annotation> mapping;
  final String pattern;

  AnnotationEditingController(this.mapping)
      : pattern = "(${mapping.keys.map((key) => key).join('|')})";

  get markupText {
    final someVal = text.splitMapJoin(
      RegExp("$pattern"),
      onMatch: (Match match) {
        final mention = mapping[match[0]] != null
            ? mapping[match[0]]
            : mapping[mapping.keys.firstWhere((element) {
                final reg = new RegExp(element);

                return reg.hasMatch(match[0]);
              })];

        if (!mention.disableMarkup)
          return "${mention.trigger}[__${mention.id}__](__${mention.display}__)";
        else
          return match[0];
      },
      onNonMatch: (String text) {
        return text;
      },
    );

    return someVal;
  }

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    List<InlineSpan> children = [];

    text.splitMapJoin(
      RegExp("$pattern"),
      onMatch: (Match match) {
        final mention = mapping[match[0]] != null
            ? mapping[match[0]]
            : mapping[mapping.keys.firstWhere((element) {
                final reg = new RegExp(element);

                return reg.hasMatch(match[0]);
              })];

        children.add(
          TextSpan(
            text: match[0],
            style: style.merge(mention.style),
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
