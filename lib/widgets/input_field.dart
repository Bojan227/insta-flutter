import 'package:flutter/material.dart';

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
    return TextFormField(
      initialValue: defaultValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondary, width: 1)),
        fillColor: Colors.grey[100],
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        hintText: label,
      ),
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
