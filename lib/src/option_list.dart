part of flutter_mentions;

class OptionList extends StatelessWidget {
  OptionList({
    this.listKey,
    this.data,
    this.onTap,
    this.suggestionListHeight,
  });

  final GlobalKey listKey;

  final List<MentionItem> data;

  final Function(String) onTap;

  final double suggestionListHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: listKey,
      color: Colors.green,
      constraints: BoxConstraints(maxHeight: this.suggestionListHeight),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onTap(data[index].id);
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  data[index].display,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            );
          }),
    );
  }
}
