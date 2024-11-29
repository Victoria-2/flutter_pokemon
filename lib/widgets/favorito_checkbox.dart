import 'package:flutter/material.dart';

class FavoriteCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const FavoriteCheckbox({
    super.key,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<FavoriteCheckbox> createState() => _FavoriteCheckboxState();
}

class _FavoriteCheckboxState extends State<FavoriteCheckbox> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Favorito'),
        Checkbox(
          value: isFavorite,
          onChanged: (value) {
            setState(() {
              isFavorite = value ?? false;
            });
            widget.onChanged(isFavorite);
          },
        ),
      ],
    );
  }
}