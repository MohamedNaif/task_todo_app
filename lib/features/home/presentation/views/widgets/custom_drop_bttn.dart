

import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.onChanged,
    required this.items,
    this.icon,
    this.value,
  });

  final void Function(String?)? onChanged;
  final List<String> items;
  final Widget? icon;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      underline: const SizedBox(),
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      icon: icon,
    );
  }
}
