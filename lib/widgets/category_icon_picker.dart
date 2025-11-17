import 'package:flutter/material.dart';

class CategoryIconPicker extends StatefulWidget {
  const CategoryIconPicker({super.key, this.initial});
  final IconData? initial;

  @override
  State<CategoryIconPicker> createState() => _CategoryIconPickerState();
}

class _CategoryIconPickerState extends State<CategoryIconPicker> {
  static const _icons = <IconData>[
    Icons.fastfood,
    Icons.local_grocery_store,
    Icons.directions_car,
    Icons.house,
    Icons.sports_esports,
    Icons.shopping_bag,
    Icons.medical_services,
    Icons.payments,
    Icons.movie,
    Icons.school,
  ];

  IconData? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial ?? _icons.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          final icon = _icons[index];
          final selected = icon == _selected;
          return IconButton(
            onPressed: () => setState(() => _selected = icon),
            icon: CircleAvatar(
              backgroundColor: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
              child: Icon(icon, color: selected ? Colors.white : Theme.of(context).iconTheme.color),
            ),
          );
        },
      ),
    );
  }
}
