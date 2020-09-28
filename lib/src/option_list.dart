part of flutter_mentions;

class OptionList extends StatelessWidget {
  OptionList({
    this.data,
    this.onTap,
    this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
  });

  final Widget Function(Map<String, dynamic>) suggestionBuilder;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;

  final double suggestionListHeight;

  final BoxDecoration suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Container(
            decoration:
                suggestionListDecoration ?? BoxDecoration(color: Colors.white),
            constraints: BoxConstraints(
              maxHeight: suggestionListHeight,
              minHeight: 0,
            ),
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onTap(data[index]);
                  },
                  child: suggestionBuilder != null
                      ? suggestionBuilder(data[index])
                      : Container(
                          color: Colors.blue,
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            data[index]['display'],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                );
              },
            ),
          )
        : Container();
  }
}
