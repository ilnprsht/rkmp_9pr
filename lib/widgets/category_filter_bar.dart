import 'package:flutter/material.dart';

class CategoryFilterBar extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;

  const CategoryFilterBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['Все', 'Уходовая', 'Парфюмерия', 'Декоративная'];

    return Wrap(
      spacing: 8,
      children: categories.map((cat) {
        final isSelected =
            (cat == 'Все' && selected == null) || selected == cat;
        return ChoiceChip(
          label: Text(cat),
          selected: isSelected,
          onSelected: (_) {
            onChanged(cat == 'Все' ? null : cat);
          },
        );
      }).toList(),
    );
  }
}
