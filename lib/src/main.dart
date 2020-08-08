part of flutter_mentions;

enum SuggestionPosition { Top, Bottom }

class LengthMap {
  LengthMap({this.start, this.end, this.str});

  String str;
  int start;
  int end;
}

class Annotation {
  Annotation({
    this.style,
    this.id,
    this.display,
    this.trigger,
    this.disableMarkup,
  });

  TextStyle style;
  String id;
  String display;
  String trigger;
  bool disableMarkup;
}

class FlutterMentions extends StatefulWidget {
  FlutterMentions({
    this.mentions,
    this.suggestionPosition = SuggestionPosition.Bottom,
    this.suggestionListHeight = 300.0,
    this.onMarkupChanged,
    this.suggestionListDecoration,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.onTap,
    this.buildCounter,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
  });

  final List<Mention> mentions;
  final SuggestionPosition suggestionPosition;
  final double suggestionListHeight;
  final Function(String) onMarkupChanged;
  final BoxDecoration suggestionListDecoration;
  final FocusNode focusNode;

  /// The decoration to show around the text field.
  final InputDecoration decoration;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection textDirection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.services.textInput.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  final int minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool showCursor;

  /// If [maxLength] is set to this value, only the "current input length"
  /// part of the character counter is shown.
  static const int noMaxLength = -1;

  /// The maximum number of characters (Unicode scalar values) to allow in the
  /// text field.
  final int maxLength;

  /// If true, prevents the field from allowing more than [maxLength]
  /// characters.
  ///
  /// If [maxLength] is set, [maxLengthEnforced] indicates whether or not to
  /// enforce the limit, or merely provide a character counter and warning when
  /// [maxLength] is exceeded.
  final bool maxLengthEnforced;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String> onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String> onSubmitted;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius cursorRadius;

  /// The color to use when painting the cursor.
  ///
  /// Defaults to [ThemeData.cursorColor] or [CupertinoTheme.primaryColor]
  /// depending on [ThemeData.platform] .
  final Color cursorColor;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
  final Brightness keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.rendering.editable.selectionEnabled}
  bool get selectionEnabled => enableInteractiveSelection;

  /// {@template flutter.material.textfield.onTap}
  /// Called for each distinct tap except for every second tap of a double tap.
  final GestureTapCallback onTap;

  /// Callback that generates a custom [InputDecorator.counter] widget.
  ///
  /// See [InputCounterWidgetBuilder] for an explanation of the passed in
  /// arguments.  The returned widget will be placed below the line in place of
  /// the default widget built when [counterText] is specified.
  ///
  /// The returned widget will be wrapped in a [Semantics] widget for
  /// accessibility, but it also needs to be accessible itself.  For example,
  /// if returning a Text widget, set the [semanticsLabel] property.
  final InputCounterWidgetBuilder buildCounter;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics scrollPhysics;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController scrollController;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.autofill.autofillHints}
  final Iterable<String> autofillHints;

  @override
  _FlutterMentionsState createState() => _FlutterMentionsState();
}

class _FlutterMentionsState extends State<FlutterMentions> {
  AnnotationEditingController _controller;
  final LayerLink layerLink = LayerLink();
  bool showSuggestions = false;
  LengthMap selectedMention;
  String pattern = "";

  @override
  void initState() {
    final Map<String, Annotation> data = Map<String, Annotation>();

    widget.mentions.forEach((element) {
      if (element.matchAll)
        data["${element.trigger}([A-Za-z0-9])*"] = Annotation(
          style: element.style,
          id: null,
          display: null,
          trigger: element.trigger,
          disableMarkup: element.disableMarkup,
        );

      element.data?.forEach(
        (e) => data["${element.trigger}${e['display']}"] = e["style"] != null
            ? Annotation(
                style: e["style"],
                id: e["id"],
                display: e["display"],
                trigger: element.trigger,
                disableMarkup: element.disableMarkup,
              )
            : Annotation(
                style: element.style,
                id: e["id"],
                display: e["display"],
                trigger: element.trigger,
                disableMarkup: element.disableMarkup,
              ),
      );
    });

    _controller = AnnotationEditingController(data);

    _controller.addListener(() {
      final cursorPos = _controller.selection.baseOffset - 1;
      if (cursorPos > 0) {
        int _pos = 0;

        final lengthMap = List<LengthMap>();

        _controller.value.text.split(" ").forEach((element) {
          lengthMap.add(
              LengthMap(str: element, start: _pos, end: _pos + element.length));

          _pos = _pos + element.length + 1;
        });

        final val = lengthMap.indexWhere((element) {
          final newPos = _controller.selection.baseOffset;
          pattern = widget.mentions.map((e) => e.trigger).join("|");

          return element.end == newPos &&
              element.str.toLowerCase().contains(RegExp(pattern));
        });

        setState(() {
          showSuggestions = val != -1;
          selectedMention = val == -1 ? null : lengthMap[val];
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = selectedMention != null
        ? widget.mentions.firstWhere(
            (element) => selectedMention.str.contains(element.trigger))
        : widget.mentions[0];
    return Container(
      child: PortalEntry(
        portalAnchor: widget.suggestionPosition == SuggestionPosition.Bottom
            ? Alignment.topCenter
            : Alignment.bottomCenter,
        childAnchor: widget.suggestionPosition == SuggestionPosition.Bottom
            ? Alignment.bottomCenter
            : Alignment.topCenter,
        portal: showSuggestions
            ? OptionList(
                suggestionListHeight: widget.suggestionListHeight,
                suggestionBuilder: list.suggestionBuilder,
                suggestionListDecoration: widget.suggestionListDecoration,
                data: list.data.where((element) {
                  final ele = element["display"].toLowerCase();
                  final str = selectedMention.str
                      .toLowerCase()
                      .replaceAll(RegExp(pattern), "");

                  return ele == str ? false : ele.contains(str);
                }).toList(),
                onTap: (value) {
                  _controller.text = _controller.value.text.replaceRange(
                    selectedMention.start,
                    selectedMention.end,
                    "${list.trigger}${value['display']}",
                  );

                  setState(() {
                    showSuggestions = false;
                  });
                },
              )
            : Container(),
        child: TextField(
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          keyboardAppearance: widget.keyboardAppearance,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          style: widget.style,
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          readOnly: widget.readOnly,
          showCursor: widget.showCursor,
          autofocus: widget.autofocus,
          autocorrect: widget.autocorrect,
          maxLengthEnforced: widget.maxLengthEnforced,
          cursorColor: widget.cursorColor,
          cursorRadius: widget.cursorRadius,
          cursorWidth: widget.cursorWidth,
          buildCounter: widget.buildCounter,
          autofillHints: widget.autofillHints,
          decoration: widget.decoration,
          expands: widget.expands,
          onEditingComplete: widget.onEditingComplete,
          onTap: widget.onTap,
          onSubmitted: widget.onSubmitted,
          enabled: widget.enabled,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          enableSuggestions: widget.enableSuggestions,
          scrollController: widget.scrollController,
          scrollPadding: widget.scrollPadding,
          scrollPhysics: widget.scrollPhysics,
          controller: _controller,
          onChanged: (text) {
            if (widget.onChanged != null) widget.onChanged(text);
            if (widget.onMarkupChanged != null)
              widget.onMarkupChanged(_controller.markupText);
          },
        ),
      ),
    );
  }
}
