part of flutter_mentions;

class OptionList extends StatelessWidget {
  OptionList({
    required this.suggestions,
    required this.onSuggestionAdd,
    required this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
  });

  final SuggestionBuilder? suggestionBuilder;

  final List<Suggestion> suggestions;

  final OnSuggestionAdd onSuggestionAdd;

  final double suggestionListHeight;

  final BoxDecoration? suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    return suggestions.isNotEmpty
        ? Container(
            decoration:
                suggestionListDecoration ?? BoxDecoration(color: Colors.white),
            constraints: BoxConstraints(
              maxHeight: suggestionListHeight,
              minHeight: 0,
            ),
            child: ListView.builder(
              itemCount: suggestions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final currentData = suggestions[index];

                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    onSuggestionAdd(currentData);
                  },
                  child: suggestionBuilder != null
                      ? suggestionBuilder!(currentData)
                      : Container(
                          color: Colors.blue,
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            currentData.display,
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
