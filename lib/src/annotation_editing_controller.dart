part of flutter_mentions;

/// A custom implementation of [TextEditingController] to support @ mention or other
/// trigger based mentions.
class AnnotationEditingController extends TextEditingController {
  late Map<String, Annotation> _mapping;
  String? _pattern;

  // Generate the Regex pattern for matching all the suggestions in one.
  AnnotationEditingController();

  void initMapping(Map<String, Annotation> mapping) {
    _mapping = mapping;
    _pattern = _mapping.keys.isNotEmpty
        ? "(${_mapping.keys.map((key) => RegExp.escape(key)).join('|')})"
        : null;
  }

  /// Can be used to get the markup from the controller directly.
  String get markupText {
    final someVal = _mapping.isEmpty
        ? text
        : text.splitMapJoin(
            RegExp('$_pattern'),
            onMatch: (Match match) {
              final mention = _mapping[match[0]!] ??
                  _mapping[_mapping.keys.firstWhere((element) {
                    final reg = RegExp(element);

                    return reg.hasMatch(match[0]!);
                  })]!;
//"[@michael:51515151]
              // Default markup format for mentions
              if (!mention.disableMarkup) {
                return mention.markupBuilder != null
                    ? mention.markupBuilder!(
                        mention.trigger,
                        mention.id!,
                        mention.display!,
                      )
                    : '[${mention.trigger}${mention.display}:${mention.id}]';
              } else {
                return match[0]!;
              }
            },
            onNonMatch: (String text) {
              return text;
            },
          );

    return someVal;
  }

  Map<String, Annotation> get mapping {
    return _mapping;
  }

  set mapping(Map<String, Annotation> _mapping) {
    this._mapping = _mapping;

    _pattern = "(${_mapping.keys.map((key) => RegExp.escape(key)).join('|')})";
  }

  @override
  TextSpan buildTextSpan(
      {BuildContext? context, TextStyle? style, bool? withComposing}) {
    var children = <InlineSpan>[];

    if (_pattern == null || _pattern == '()') {
      children.add(TextSpan(text: text, style: style));
    } else {
      text.splitMapJoin(
        RegExp('$_pattern'),
        onMatch: (Match match) {
          if (_mapping.isNotEmpty) {
            final mention = _mapping[match[0]!] ??
                _mapping[_mapping.keys.firstWhere((element) {
                  final reg = RegExp(element);

                  return reg.hasMatch(match[0]!);
                })]!;

            children.add(
              TextSpan(
                text: match[0],
                style: style!.merge(mention.style),
              ),
            );
          }

          return '';
        },
        onNonMatch: (String text) {
          children.add(TextSpan(text: text, style: style));
          return '';
        },
      );
    }

    return TextSpan(style: style, children: children);
  }
}
