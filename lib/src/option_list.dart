part of flutter_mentions;

/// Widget that displays a list of suggestion options with keyboard navigation.
class OptionList extends StatefulWidget {
  const OptionList({
    super.key,
    required this.data,
    required this.onTap,
    required this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
    this.selectedIndex = 0,
    this.onSelectedIndexChanged,
  });

  /// Custom builder for suggestion items.
  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  /// List of suggestion data to display.
  final List<Map<String, dynamic>> data;

  /// Callback when a suggestion is tapped or selected via keyboard.
  final Function(Map<String, dynamic>) onTap;

  /// Maximum height for the suggestion list.
  final double suggestionListHeight;

  /// Decoration for the suggestion list container.
  final BoxDecoration? suggestionListDecoration;

  /// Currently selected index for keyboard navigation.
  final int selectedIndex;

  /// Callback when selected index changes.
  final ValueChanged<int>? onSelectedIndexChanged;

  @override
  State<OptionList> createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(OptionList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll to keep selected item visible
    if (widget.selectedIndex != oldWidget.selectedIndex && widget.data.isNotEmpty) {
      _scrollToSelected();
    }
  }

  void _scrollToSelected() {
    if (!_scrollController.hasClients) return;

    // Estimate item height (adjust based on your typical item size)
    const estimatedItemHeight = 60.0;
    final targetOffset = widget.selectedIndex * estimatedItemHeight;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final viewportHeight = _scrollController.position.viewportDimension;

    // Only scroll if the item is outside the visible area
    final currentOffset = _scrollController.offset;
    if (targetOffset < currentOffset) {
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    } else if (targetOffset + estimatedItemHeight > currentOffset + viewportHeight) {
      _scrollController.animateTo(
        (targetOffset + estimatedItemHeight - viewportHeight).clamp(0, maxScroll),
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const SizedBox.shrink();
    }

    return Semantics(
      label: 'Suggestions list with ${widget.data.length} items',
      container: true,
      child: Container(
        decoration: widget.suggestionListDecoration ??
            BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
        constraints: BoxConstraints(
          maxHeight: widget.suggestionListHeight,
          minHeight: 0,
        ),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: widget.data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = widget.data[index];
            final displayText = item['display']?.toString() ?? '';
            final isSelected = index == widget.selectedIndex;

            return Semantics(
              button: true,
              selected: isSelected,
              label: 'Select $displayText${isSelected ? ', currently selected' : ''}',
              child: GestureDetector(
                onTap: () => widget.onTap(item),
                child: Container(
                  color: isSelected ? Colors.grey.withOpacity(0.2) : null,
                  child: widget.suggestionBuilder != null
                      ? widget.suggestionBuilder!(item)
                      : Container(
                          color: isSelected ? Colors.blue.shade700 : Colors.blue,
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            displayText,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
