import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app-text-style.dart';
import 'package:payflow/shared/widgets/divider/divider-widget.dart';

import '../label-button/label-button-widget.dart';

class SetLabelButtonsWidget extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;
  final bool enablePrimaryColor;

  const SetLabelButtonsWidget({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
    this.enablePrimaryColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: LabelButtonWidget(
              label: primaryLabel,
              style: enablePrimaryColor ? AppTextStyles.buttonPrimary : null,
              onPressedFunction: () {
                print("clicado");
              },
            ),
          ),
          DividerWidget(),
          Expanded(
            child: LabelButtonWidget(
              label: secondaryLabel,
              onPressedFunction: () {
                print("clicado");
              },
            ),
          ),
        ],
      ),
    );
  }
}
