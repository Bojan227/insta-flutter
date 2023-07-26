import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({super.key, required this.label, required this.info});

  final String label;
  final int info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$info'),
        const SizedBox(
          height: 8,
        ),
        Text(label)
      ],
    );
  }
}
