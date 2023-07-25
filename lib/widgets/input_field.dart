import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      required this.handleInput,
      required this.obscureText,
      required this.label});

  final void Function(String value, String label) handleInput;
  final bool obscureText;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.all(10),
        label: Text(label),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (newValue) => handleInput(newValue!, label),
    );
  }
}
