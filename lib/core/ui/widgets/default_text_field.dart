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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        enabled: enabled,
        style: TextStyle(
          color: enabled ? Colors.grey.shade700 : Colors.grey.shade400,
        ),
        controller: TextEditingController(text: initialValue),
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
          fillColor: enabled ? Colors.grey.shade50 : Colors.grey.shade500,
        ),
        maxLines: maxLines,
      ),
    );
  }
}
