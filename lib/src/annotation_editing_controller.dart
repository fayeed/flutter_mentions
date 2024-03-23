part of flutter_mentions;

/// A custom implementation of [TextEditingController] to support @ mention or other
/// trigger based mentions.
class AnnotationEditingController extends TextEditingController {
  Map<String, Annotation> _mapping;
  RegExp _patternRegexp;

  // Generate the Regex pattern for matching all the suggestions in one.
  AnnotationEditingController(this._mapping)
      : _patternRegexp = RegExp(_mappingToPattern(_mapping));

  static String _mappingToPattern(Map<String, Annotation> mapping) {
    return "(${mapping.keys.map(RegExp.escape).join('|')})";
  }

  /// Can be used to get the markup from the controller directly.
  String get markupText {
    final someVal = _mapping.isEmpty
        ? text
        : text.splitMapJoin(
            _patternRegexp,
            onMatch: (Match match) {
              final mention = _mapping[match[0]!] ??
                  _mapping[_mapping.keys.firstWhere((element) {
                    final reg = RegExp(element);

                    return reg.hasMatch(match[0]!);
                  })]!;

              // Default markup format for mentions
              if (!mention.disableMarkup) {
                return mention.markupBuilder != null
                    ? mention.markupBuilder!(
                        mention.trigger, mention.id!, mention.display!)
                    : '${mention.trigger}[__${mention.id}__](__${mention.display}__)';
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

    final pattern = _mappingToPattern(_mapping);
    if (pattern != _patternRegexp.pattern) {
      _patternRegexp = RegExp(pattern);
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
        _patternRegexp,
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
