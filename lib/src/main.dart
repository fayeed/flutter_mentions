part of flutter_mentions;

enum SuggestionPosition { Top, Bottom }

class FlutterMentions extends StatefulWidget {
  FlutterMentions({
    this.mentions,
    this.suggestionPosition = SuggestionPosition.Bottom,
    this.suggestionListHeight = 300.0,
  });

  final Mention mentions;
  final SuggestionPosition suggestionPosition;
  final double suggestionListHeight;

  @override
  _FlutterMentionsState createState() => _FlutterMentionsState();
}

class _FlutterMentionsState extends State<FlutterMentions> {
  AnnotationEditingController _controller;
  final LayerLink layerLink = LayerLink();
  bool showSuggestions = false;

  @override
  void initState() {
    final Map<String, TextStyle> data = Map<String, TextStyle>();

    widget.mentions.data.forEach(
      (e) => data["@${e.id}"] = widget.mentions.style,
    );

    _controller = AnnotationEditingController(
        data, widget.mentions.matchAll, widget.mentions.style);

    _controller.addListener(() {
      final cursorPos = _controller.selection.baseOffset - 1;
      if (cursorPos > 0) {
        setState(() {
          showSuggestions =
              _controller.value.text[cursorPos] == widget.mentions.trigger;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: Container(
        child: Column(
          children: [
            PortalEntry(
              portalAnchor:
                  widget.suggestionPosition == SuggestionPosition.Bottom
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
              childAnchor:
                  widget.suggestionPosition == SuggestionPosition.Bottom
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
              portal: showSuggestions
                  ? OptionList(
                      suggestionListHeight: widget.suggestionListHeight,
                      data: widget.mentions.data,
                      onTap: (value) {
                        _controller.text += value;

                        setState(() {
                          showSuggestions = false;
                        });
                      },
                    )
                  : Container(),
              child: TextField(
                controller: _controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
