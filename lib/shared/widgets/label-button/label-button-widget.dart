// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app-text-style.dart';

class LabelButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressedFunction;
  final TextStyle? style;

  const LabelButtonWidget({
    Key? key,
    required this.label,
    required this.onPressedFunction,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: TextButton(
        onPressed: () {
          onPressedFunction();
        },
        child: Text(
          label,
          style: style ?? AppTextStyles.buttonHeading,
        ),
      ),
    );
  }
}
