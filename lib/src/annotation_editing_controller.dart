part of flutter_mentions;

/// A custom implementation of [TextEditingController] to support @ mention or other
/// trigger based mentions.
class AnnotationEditingController extends TextEditingController {
  Map<String, Annotation> _mapping;
  String? _pattern;

  /// Generate the Regex pattern for matching all the suggestions in one.
  AnnotationEditingController(this._mapping)
      : _pattern = _mapping.keys.isNotEmpty
            ? "(${_mapping.keys.map((key) => RegExp.escape(key)).join('|')})"
            : null;

  /// Finds the annotation for a given match string.
  /// Returns null if no matching annotation is found.
  Annotation? _findAnnotation(String matchText) {
    // First try direct lookup
    final directMatch = _mapping[matchText];
    if (directMatch != null) return directMatch;

    // Then try regex matching
    for (final key in _mapping.keys) {
      final reg = RegExp(key);
      if (reg.hasMatch(matchText)) {
        return _mapping[key];
      }
    }

    return null;
  }

  /// Can be used to get the markup from the controller directly.
  String get markupText {
    if (_mapping.isEmpty || _pattern == null || _pattern == '()') {
      return text;
    }

    return text.splitMapJoin(
      RegExp('$_pattern'),
      onMatch: (Match match) {
        final matchText = match[0]!;
        final mention = _findAnnotation(matchText);

        if (mention == null) return matchText;

        // Default markup format for mentions
        if (!mention.disableMarkup) {
          return mention.markupBuilder != null
              ? mention.markupBuilder!(
                  mention.trigger, mention.id ?? '', mention.display ?? '')
              : '${mention.trigger}[__${mention.id}__](__${mention.display}__)';
        } else {
          return matchText;
        }
      },
      onNonMatch: (String text) => text,
    );
  }

  /// Returns the current mapping of patterns to annotations.
  Map<String, Annotation> get mapping => _mapping;

  /// Updates the mapping and regenerates the pattern.
  set mapping(Map<String, Annotation> newMapping) {
    _mapping = newMapping;
    _pattern = _mapping.keys.isNotEmpty
        ? "(${_mapping.keys.map((key) => RegExp.escape(key)).join('|')})"
        : null;
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final children = <InlineSpan>[];

    if (_pattern == null || _pattern == '()' || _mapping.isEmpty) {
      children.add(TextSpan(text: text, style: style));
    } else {
      text.splitMapJoin(
        RegExp('$_pattern'),
        onMatch: (Match match) {
          final matchText = match[0]!;
          final mention = _findAnnotation(matchText);

          if (mention != null) {
            children.add(
              TextSpan(
                text: matchText,
                style: style?.merge(mention.style) ?? mention.style,
              ),
            );
          } else {
            // Fallback if no mention found - just use regular style
            children.add(TextSpan(text: matchText, style: style));
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
