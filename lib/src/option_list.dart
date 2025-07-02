part of flutter_mentions;

class OptionList extends StatelessWidget {
  OptionList({
    required this.data,
    required this.onTap,
    required this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
    this.suggestionListWidth,
    this.suggestionContainerBuilder,
  });

  final Widget Function(Map<String, dynamic> mentionData,
      Function(Map<String, dynamic>) onTap)? suggestionBuilder;
  final Widget Function(Widget child, BoxConstraints boxConstraints)?
      suggestionContainerBuilder;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;

  final double suggestionListHeight;
  final double? suggestionListWidth;

  final BoxDecoration? suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    final boxConstraints = BoxConstraints(
      maxHeight: suggestionListHeight,
      minHeight: 0,
      maxWidth: suggestionListWidth ?? double.infinity,
    );
    final child = ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return suggestionBuilder != null
            ? suggestionBuilder!(data[index], onTap)
            : GestureDetector(
                onTap: () => onTap(data[index]),
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    data[index]['display'],
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              );
      },
    );
    return data.isNotEmpty
        ? suggestionContainerBuilder != null
            ? suggestionContainerBuilder!(child, boxConstraints)
            : Container(
                decoration: suggestionListDecoration ??
                    BoxDecoration(color: Colors.white),
                constraints: boxConstraints,
                child: child,
              )
        : Container();
  }
}
