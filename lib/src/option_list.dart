part of flutter_mentions;

/// Widget that displays a list of suggestion options.
class OptionList extends StatelessWidget {
  const OptionList({
    super.key,
    required this.data,
    required this.onTap,
    required this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
  });

  /// Custom builder for suggestion items.
  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  /// List of suggestion data to display.
  final List<Map<String, dynamic>> data;

  /// Callback when a suggestion is tapped.
  final Function(Map<String, dynamic>) onTap;

  /// Maximum height for the suggestion list.
  final double suggestionListHeight;

  /// Decoration for the suggestion list container.
  final BoxDecoration? suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration:
          suggestionListDecoration ?? const BoxDecoration(color: Colors.white),
      constraints: BoxConstraints(
        maxHeight: suggestionListHeight,
        minHeight: 0,
      ),
      child: ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = data[index];
          final displayText = item['display']?.toString() ?? '';

          return Semantics(
            button: true,
            label: 'Select $displayText',
            child: GestureDetector(
              onTap: () => onTap(item),
              child: suggestionBuilder != null
                  ? suggestionBuilder!(item)
                  : Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        displayText,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
