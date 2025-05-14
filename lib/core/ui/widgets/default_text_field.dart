import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int? maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final IconData icon;
  final bool enabled;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const DefaultTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(
          color: enabled ? Colors.grey.shade800 : Colors.grey.shade400,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          labelText: label,
          labelStyle: TextStyle(
            color: enabled ? Colors.grey.shade700 : Colors.grey.shade400,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: enabled ? const Color(0xFF9b87f5) : Colors.grey.shade400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF9b87f5), width: 1.5),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: enabled ? Colors.grey.shade200 : Colors.grey.shade300,
        ),
      ),
    );
  }
}
