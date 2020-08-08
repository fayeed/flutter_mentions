part of flutter_mentions;

class OptionList extends StatelessWidget {
  OptionList({
    this.data,
    this.onTap,
    this.suggestionListHeight,
    this.suggestionBuilder,
  });

  final Widget Function(Map<String, dynamic>) suggestionBuilder;

  final List<Map<String, dynamic>> data;

  final Function(String) onTap;

  final double suggestionListHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      constraints: BoxConstraints(
        maxHeight: this.suggestionListHeight,
      ),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onTap(data[index]["display"]);
            },
            child: suggestionBuilder != null
                ? suggestionBuilder(data[index])
                : Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      data[index]["display"],
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
