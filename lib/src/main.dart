part of flutter_mentions;

enum SuggestionPosition { Top, Bottom }

class LengthMap {
  LengthMap({this.start, this.end, this.str});

  String str;
  int start;
  int end;
}

class FlutterMentions extends StatefulWidget {
  FlutterMentions({
    this.mentions,
    this.suggestionPosition = SuggestionPosition.Bottom,
    this.suggestionListHeight = 300.0,
  });

  final List<Mention> mentions;
  final SuggestionPosition suggestionPosition;
  final double suggestionListHeight;

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
    final Map<String, TextStyle> data = Map<String, TextStyle>();

    widget.mentions.forEach((element) {
      if (element.matchAll)
        data["${element.trigger}([A-Za-z0-9])*"] = element.style;

      element.data?.forEach(
        (e) => data["${element.trigger}${e.id}"] = element.style,
      );
    });

    _controller = AnnotationEditingController(data, null);

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

          return element.end == newPos && element.str.contains(RegExp(pattern));
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
                data: list.data
                    .where((element) => element.id.toLowerCase().contains(
                        selectedMention.str.replaceAll(RegExp(pattern), "")))
                    .toList(),
                onTap: (value) {
                  _controller.text = _controller.value.text.replaceRange(
                    selectedMention.start,
                    selectedMention.end,
                    "${list.trigger}$value",
                  );

                  setState(() {
                    showSuggestions = false;
                  });
                },
              )
            : Container(),
        child: TextField(
          maxLines: 5,
          minLines: 1,
          controller: _controller,
        ),
      ),
    );
  }
}
