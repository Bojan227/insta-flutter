import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  const TextArea({super.key, required this.handleInput});

  final void Function(String value) handleInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).colorScheme.onSecondary,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondary, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondary, width: 2),
          ),
          hintText: 'Write your caption here....'),
      minLines:
          6, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
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
