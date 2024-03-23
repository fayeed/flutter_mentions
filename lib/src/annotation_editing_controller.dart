part of flutter_mentions;

/// A custom implementation of [TextEditingController] to support @ mention or other
/// trigger based mentions.
class AnnotationEditingController extends TextEditingController {
  Map<String, Annotation> _mapping;
  RegExp _regExp;

  // Generate the Regex pattern for matching all the suggestions in one.
  AnnotationEditingController(this._mapping)
      : _regExp = RegExp(_mappingToPattern(_mapping));

  static String _mappingToPattern(Map<String, Annotation> mapping) {
    return "(${mapping.entries.map((e) => e.value.matchAll ? e.key : RegExp.escape(e.key)).join('|')})";
  }

  /// Can be used to get the markup from the controller directly.
  String get markupText {
    final someVal = _mapping.isEmpty
        ? text
        : text.splitMapJoin(
            _regExp,
            onMatch: (Match match) {
              final val = match[0]!;

              final mention = _mapping[val] ??
                  _mapping[_mapping.keys.firstWhere((element) {
                    final reg = RegExp(element);

                    return reg.hasMatch(val);
                  })]!;

              // Default markup format for mentions
              if (!mention.disableMarkup) {
                return mention.markupBuilder != null
                    ? mention.markupBuilder!(
                        mention.trigger,
                        mention.id ?? val,
                        mention.display ?? val,
                      )
                    : '${mention.trigger}[__${mention.id ?? val}__](__${mention.display ?? val}__)';
              } else {
                return val;
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

    final pattern = _mappingToPattern(_mapping);
    if (pattern != _regExp.pattern) {
      _regExp = RegExp(pattern);
    }
  }

  @override
  TextSpan buildTextSpan(
      {BuildContext? context, TextStyle? style, bool? withComposing}) {
    var children = <InlineSpan>[];

    if (mapping.isEmpty) {
      children.add(TextSpan(text: text, style: style));
    } else {
      text.splitMapJoin(
        _regExp,
        onMatch: (Match match) {
          if (_mapping.isNotEmpty) {
            final val = match[0]!;

            final mention = _mapping[val] ??
                _mapping[_mapping.keys.firstWhere((element) {
                  final reg = RegExp(element);

                  return reg.hasMatch(val);
                })]!;

            children.add(
              TextSpan(
                text: val,
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
