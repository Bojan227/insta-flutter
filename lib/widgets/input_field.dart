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
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSecondary, width: 2.0),
        ),
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
      onSaved: (newValue) => handleInput(newValue!),
    );
  }
}
