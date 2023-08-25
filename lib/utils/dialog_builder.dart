import 'package:flutter/material.dart';

import '../theme/custom_theme.dart';

Future<void> dialogBuilder(BuildContext context, String errorMessage) {
  final customTheme = Theme.of(context).extension<CustomTheme>();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: customTheme?.background,
        content: Text(
          errorMessage,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
