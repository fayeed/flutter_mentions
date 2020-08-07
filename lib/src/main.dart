part of flutter_mentions;

enum SuggestionPosition { Top, Bottom }

class FlutterMentions extends StatefulWidget {
  FlutterMentions({
    this.mentions,
    this.suggestionPosition = SuggestionPosition.Top,
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
  OverlayEntry overlayEntry;
  GlobalKey key = GlobalKey();
  GlobalKey listKey = GlobalKey();

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
        print(_controller.value.text[cursorPos]);

        if (_controller.value.text[cursorPos] == widget.mentions.trigger) {
          showOverlay();
        } else {
          hideOverlay();
        }
      }
    });

    super.initState();
  }

  void showOverlay() {
    RenderBox renderBox = key.currentContext.findRenderObject();

    final size = renderBox.size;

    final list = OptionList(
      listKey: listKey,
      suggestionListHeight: widget.suggestionListHeight,
      data: widget.mentions.data,
      onTap: (value) {
        _controller.text += value;

        if (overlayEntry != null) {
          overlayEntry.remove();
          overlayEntry = null;
        }
      },
    );

    RenderBox listRenderBox = listKey.currentContext?.findRenderObject();

    final suggestionListHeight =
        listRenderBox != null ? listRenderBox.size.height : 0;

    // print(list.listKey.currentContext.findRenderObject());

    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return Positioned(
            bottom: 0.0,
            left: 0.0,
            child: CompositedTransformFollower(
              showWhenUnlinked: false,
              link: layerLink,
              offset: Offset(
                0,
                widget.suggestionPosition == SuggestionPosition.Top
                    ? -(size.height + ((size.height / 1.2) + size.height))
                    : (size.height + 5.0),
              ),
              child: list,
            ),
          );
        },
      );

      Overlay.of(context).insert(overlayEntry);
    }
  }

  void hideOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CompositedTransformTarget(
              link: layerLink,
              child: TextField(
                key: key,
                controller: _controller,
              ))
        ],
      ),
    );
  }
}
