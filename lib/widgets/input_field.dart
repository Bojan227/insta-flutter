import 'package:flutter/material.dart';

import '../theme/custom_theme.dart';

class InputField extends StatelessWidget {
  InputField(
      {super.key,
      this.defaultValue,
      required this.handleInput,
      required this.obscureText,
      required this.label});

  final void Function(String value) handleInput;
  final bool obscureText;
  final String label;
  String? defaultValue;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return TextFormField(
      style: TextStyle(color: customTheme.onSecondary),
      initialValue: defaultValue,
      obscureText: obscureText,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: customTheme.onSecondary, width: 1)),
          fillColor: customTheme.onSecondary,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          hintText: label,
          hintStyle: TextStyle(color: customTheme.onSecondary)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (newValue) => handleInput(newValue!),
    );
  }
}
