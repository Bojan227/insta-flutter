import 'package:flutter/material.dart';

import '../theme/custom_theme.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({super.key, required this.label, required this.info});

  final String label;
  final int info;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      children: [
        Text(
          '$info',
          style: const TextStyle().copyWith(color: customTheme.onSecondary),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: const TextStyle().copyWith(color: customTheme.onSecondary),
        )
      ],
    );
  }
}
