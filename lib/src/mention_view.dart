part of flutter_mentions;

/// A text input widget that supports @mentions and other trigger-based suggestions.
///
/// This widget provides an input field that can trigger suggestion lists when
/// the user types specific trigger characters (like @ or #).
///
/// Example usage:
/// ```dart
/// FlutterMentions(
///   mentions: [
///     Mention(
///       trigger: '@',
///       data: [
///         {'id': '1', 'display': 'john'},
///         {'id': '2', 'display': 'jane'},
///       ],
///     ),
///   ],
/// )
/// ```
class FlutterMentions extends StatefulWidget {
  FlutterMentions({
    required this.mentions,
    super.key,
    this.defaultText,
    this.suggestionPosition = SuggestionPosition.bottom,
    this.suggestionListHeight = 300.0,
    this.onMarkupChanged,
    this.onMentionAdd,
    this.onSearchChanged,
    this.leading = const [],
    this.trailing = const [],
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
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
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
    this.appendSpaceOnAdd = true,
    this.hideSuggestionList = false,
    this.onSuggestionVisibleChanged,
  }) : assert(mentions.isNotEmpty, 'mentions list cannot be empty');

  /// Whether to hide the suggestion list even when suggestions are available.
  final bool hideSuggestionList;

  /// Default text for the Mention Input.
  final String? defaultText;

  /// Triggers when the suggestion list visibility changed.
  final Function(bool)? onSuggestionVisibleChanged;

  /// List of [Mention] configurations that define trigger characters and their data.
  ///
  /// Each mention must have a unique single-character trigger.
  final List<Mention> mentions;

  /// Leading widgets to show before the input box.
  ///
  /// These help preserve the size for the Portal widget positioning.
  final List<Widget> leading;

  /// Trailing widgets to show after the input box.
  ///
  /// These help preserve the size for the Portal widget positioning.
  final List<Widget> trailing;

  /// Position of the suggestion list relative to the input field.
  ///
  /// Defaults to [SuggestionPosition.bottom].
  final SuggestionPosition suggestionPosition;

  /// Called when a suggestion is added by tapping on it.
  final Function(Map<String, dynamic>)? onMentionAdd;

  /// Maximum height for the suggestion list.
  ///
  /// Defaults to `300.0`.
  final double suggestionListHeight;

  /// Called whenever the input changes with the markup text.
  ///
  /// The markup text includes the formatted mentions with their IDs.
  final ValueChanged<String>? onMarkupChanged;

  /// Called when the search text changes while typing a mention.
  ///
  /// Provides the trigger character and the current search value.
  final void Function(String trigger, String value)? onSearchChanged;

  /// Decoration for the suggestion list container.
  final BoxDecoration? suggestionListDecoration;

  /// Focus node for controlling the focus of the input.
  final FocusNode? focusNode;

  /// Whether selecting a suggestion should add a space after it.
  ///
  /// Defaults to `true`.
  final bool appendSpaceOnAdd;

  /// The decoration to show around the text field.
  final InputDecoration decoration;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.services.textInput.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// If [maxLength] is set to this value, only the "current input length"
  /// part of the character counter is shown.
  static const int noMaxLength = -1;

  /// The maximum number of characters (Unicode scalar values) to allow in the
  /// text field.
  final int? maxLength;

  /// If true, prevents the field from allowing more than [maxLength]
  /// characters.
  ///
  /// If [maxLength] is set, [maxLengthEnforcement] indicates whether or not to
  /// enforce the limit, or merely provide a character counter and warning when
  /// [maxLength] is exceeded.
  final MaxLengthEnforcement maxLengthEnforcement;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool? enabled;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;

  /// The color to use when painting the cursor.
  ///
  /// Defaults to [ThemeData.cursorColor] or [CupertinoTheme.primaryColor]
  /// depending on [ThemeData.platform].
  final Color? cursorColor;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
  final Brightness? keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.rendering.editable.selectionEnabled}
  bool get selectionEnabled => enableInteractiveSelection;

  /// {@template flutter.material.textfield.onTap}
  /// Called for each distinct tap except for every second tap of a double tap.
  final GestureTapCallback? onTap;

  /// Callback that generates a custom [InputDecorator.counter] widget.
  ///
  /// See [InputCounterWidgetBuilder] for an explanation of the passed in
  /// arguments.  The returned widget will be placed below the line in place of
  /// the default widget built when [counterText] is specified.
  ///
  /// The returned widget will be wrapped in a [Semantics] widget for
  /// accessibility, but it also needs to be accessible itself.  For example,
  /// if returning a Text widget, set the [semanticsLabel] property.
  final InputCounterWidgetBuilder? buildCounter;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.autofill.autofillHints}
  final Iterable<String>? autofillHints;

  @override
  FlutterMentionsState createState() => FlutterMentionsState();
}

/// State for the [FlutterMentions] widget.
///
/// Provides access to the [controller] for programmatic text manipulation
/// and the [markupText] for retrieving the formatted output.
class FlutterMentionsState extends State<FlutterMentions> {
  /// The text editing controller that handles mention formatting.
  AnnotationEditingController? controller;

  /// Notifier for suggestion list visibility.
  ValueNotifier<bool> showSuggestions = ValueNotifier(false);

  LengthMap? _selectedMention;
  late String _pattern;
  int _selectedSuggestionIndex = 0;
  List<Map<String, dynamic>> _filteredSuggestions = [];
  late FocusNode _internalFocusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = FocusNode();
    _updatePattern();
    final data = mapToAnnotation();

    controller = AnnotationEditingController(data);

    if (widget.defaultText != null) {
      controller!.text = widget.defaultText!;
    }

    // Setup listeners for suggestion and input handling
    controller!.addListener(_suggestionListener);
    controller!.addListener(_inputListeners);
  }

  void _updatePattern() {
    _pattern = widget.mentions.map((e) => RegExp.escape(e.trigger)).join('|');
  }

  /// Converts the widget's mention configuration to annotation mapping.
  Map<String, Annotation> mapToAnnotation() {
    final data = <String, Annotation>{};

    for (final element in widget.mentions) {
      // If matchAll is set to true, add a general regex pattern
      if (element.matchAll) {
        data['${element.trigger}([A-Za-z0-9])*'] = Annotation(
          style: element.style,
          id: null,
          display: null,
          trigger: element.trigger,
          disableMarkup: element.disableMarkup,
          markupBuilder: element.markupBuilder,
        );
      }

      for (final e in element.data) {
        final display = e['display'];
        if (display == null) continue;

        data['${element.trigger}$display'] = e['style'] != null
            ? Annotation(
                style: e['style'] as TextStyle?,
                id: e['id']?.toString(),
                display: display.toString(),
                trigger: element.trigger,
                disableMarkup: element.disableMarkup,
                markupBuilder: element.markupBuilder,
              )
            : Annotation(
                style: element.style,
                id: e['id']?.toString(),
                display: display.toString(),
                trigger: element.trigger,
                disableMarkup: element.disableMarkup,
                markupBuilder: element.markupBuilder,
              );
      }
    }

    return data;
  }

  /// Adds a mention to the text at the current cursor position.
  void addMention(Map<String, dynamic> value, [Mention? list]) {
    final selectedMention = _selectedMention;
    if (selectedMention == null) return;

    setState(() {
      _selectedMention = null;
      _selectedSuggestionIndex = 0;
    });

    final matchingMention = widget.mentions.where(
      (element) => selectedMention.str.contains(element.trigger),
    );

    if (matchingMention.isEmpty) return;

    final mentionConfig = matchingMention.first;
    final displayValue = value['display']?.toString() ?? '';

    // Replace the text range with the new mention
    controller!.text = controller!.value.text.replaceRange(
      selectedMention.start,
      selectedMention.end,
      '${mentionConfig.trigger}$displayValue${widget.appendSpaceOnAdd ? ' ' : ''}',
    );

    if (widget.onMentionAdd != null) widget.onMentionAdd!(value);

    // Move cursor to after the inserted mention
    var nextCursorPosition = selectedMention.start + 1 + displayValue.length;
    if (widget.appendSpaceOnAdd) nextCursorPosition++;
    controller!.selection =
        TextSelection.fromPosition(TextPosition(offset: nextCursorPosition));
  }

  void _suggestionListener() {
    final cursorPos = controller!.selection.baseOffset;

    if (cursorPos >= 0) {
      var pos = 0;
      final lengthMap = <LengthMap>[];

      // Split text into words with their positions
      for (final element in controller!.value.text.split(RegExp(r'(\s)'))) {
        lengthMap.add(
          LengthMap(str: element, start: pos, end: pos + element.length),
        );
        pos = pos + element.length + 1;
      }

      final val = lengthMap.indexWhere((element) {
        return element.end == cursorPos &&
            element.str.toLowerCase().contains(RegExp(_pattern));
      });

      final shouldShow = val != -1;

      if (showSuggestions.value != shouldShow) {
        showSuggestions.value = shouldShow;
        if (shouldShow) {
          _selectedSuggestionIndex = 0;
        }
      }

      if (widget.onSuggestionVisibleChanged != null) {
        widget.onSuggestionVisibleChanged!(shouldShow);
      }

      setState(() {
        _selectedMention = val == -1 ? null : lengthMap[val];
        if (val != -1) {
          _updateFilteredSuggestions();
        }
      });
    }
  }

  void _updateFilteredSuggestions() {
    final mentionConfig = _getSelectedMentionConfig();
    if (mentionConfig == null || _selectedMention == null) {
      _filteredSuggestions = [];
      return;
    }

    final searchStr = _selectedMention!.str
        .toLowerCase()
        .replaceAll(RegExp(_pattern), '');

    _filteredSuggestions = mentionConfig.data.where((element) {
      final ele = element['display']?.toString().toLowerCase() ?? '';
      return ele != searchStr && ele.contains(searchStr);
    }).toList();

    // Reset index if out of bounds
    if (_selectedSuggestionIndex >= _filteredSuggestions.length) {
      _selectedSuggestionIndex = 0;
    }
  }

  void _inputListeners() {
    if (widget.onChanged != null) {
      widget.onChanged!(controller!.text);
    }

    if (widget.onMarkupChanged != null) {
      widget.onMarkupChanged!(controller!.markupText);
    }

    if (widget.onSearchChanged != null && _selectedMention?.str != null) {
      final str = _selectedMention!.str.toLowerCase();
      widget.onSearchChanged!(str[0], str.substring(1));
    }
  }

  /// Handles keyboard events for suggestion navigation.
  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!showSuggestions.value || _filteredSuggestions.isEmpty) {
      return KeyEventResult.ignored;
    }

    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;

    // Arrow Down - move selection down
    if (key == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _selectedSuggestionIndex =
            (_selectedSuggestionIndex + 1) % _filteredSuggestions.length;
      });
      return KeyEventResult.handled;
    }

    // Arrow Up - move selection up
    if (key == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _selectedSuggestionIndex =
            (_selectedSuggestionIndex - 1 + _filteredSuggestions.length) %
                _filteredSuggestions.length;
      });
      return KeyEventResult.handled;
    }

    // Enter or Tab - select current suggestion
    if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.tab) {
      if (_filteredSuggestions.isNotEmpty) {
        addMention(_filteredSuggestions[_selectedSuggestionIndex]);
        showSuggestions.value = false;
        return KeyEventResult.handled;
      }
    }

    // Escape - close suggestions
    if (key == LogicalKeyboardKey.escape) {
      showSuggestions.value = false;
      setState(() {
        _selectedMention = null;
      });
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    controller!.removeListener(_suggestionListener);
    controller!.removeListener(_inputListeners);
    controller!.dispose();
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(FlutterMentions oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updatePattern();
    controller!.mapping = mapToAnnotation();
  }

  Mention? _getSelectedMentionConfig() {
    if (_selectedMention == null) return null;

    final matching = widget.mentions.where(
      (element) => _selectedMention!.str.contains(element.trigger),
    );

    return matching.isNotEmpty ? matching.first : null;
  }

  @override
  Widget build(BuildContext context) {
    final list = _getSelectedMentionConfig() ?? widget.mentions.first;

    return Focus(
      onKeyEvent: _handleKeyEvent,
      child: PortalTarget(
        anchor: Aligned(
          follower: widget.suggestionPosition == SuggestionPosition.bottom
              ? Alignment.topCenter
              : Alignment.bottomCenter,
          target: widget.suggestionPosition == SuggestionPosition.bottom
              ? Alignment.bottomCenter
              : Alignment.topCenter,
        ),
        portalFollower: ValueListenableBuilder(
          valueListenable: showSuggestions,
          builder: (BuildContext context, bool show, Widget? child) {
            if (!show || widget.hideSuggestionList) {
              return const SizedBox.shrink();
            }

            // Use memoized filtered suggestions
            if (_selectedMention != null) {
              _updateFilteredSuggestions();
            }

            return OptionList(
              suggestionListHeight: widget.suggestionListHeight,
              suggestionBuilder: list.suggestionBuilder,
              suggestionListDecoration: widget.suggestionListDecoration,
              data: _filteredSuggestions,
              selectedIndex: _selectedSuggestionIndex,
              onTap: (value) {
                addMention(value, list);
                showSuggestions.value = false;
              },
            );
          },
        ),
        child: Row(
          children: [
            ...widget.leading,
            Expanded(
              child: TextField(
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                maxLength: widget.maxLength,
                focusNode: _effectiveFocusNode,
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
                maxLengthEnforcement: widget.maxLengthEnforcement,
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
                controller: controller,
              ),
            ),
            ...widget.trailing,
          ],
        ),
      ),
    );
  }
}
