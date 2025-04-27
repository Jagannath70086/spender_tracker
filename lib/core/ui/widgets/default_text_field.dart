import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final int? maxLines;
  final ValueChanged<String> onChanged;
  final IconData icon;
  final bool enabled;

  const DefaultTextField({
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.maxLines = 1,
    required this.icon,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: initialValue),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      maxLines: maxLines,
      onChanged: onChanged,
      enabled: enabled,
    );
  }
}
