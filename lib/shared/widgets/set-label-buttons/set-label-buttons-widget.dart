import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app-colors.dart';
import 'package:payflow/shared/themes/app-textstyle.dart';
import 'package:payflow/shared/widgets/divider/divider-widget.dart';

import '../label-button/label-button-widget.dart';

class SetLabelButtonsWidget extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;
  final bool enablePrimaryColor;
  final bool enableSecondaryColor;

  const SetLabelButtonsWidget({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
    this.enablePrimaryColor = false,
    this.enableSecondaryColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      height: 57,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.stroke,
          ),
          Container(
            height: 56,
            child: Row(
              children: [
                Expanded(
                  child: LabelButtonWidget(
                    label: primaryLabel,
                    style: enablePrimaryColor ? AppTextStyles.buttonPrimary : null,
                    onPressedFunction: () {
                      primaryOnPressed();
                    },
                  ),
                ),
                DividerWidget(),
                Expanded(
                  child: LabelButtonWidget(
                    style: enableSecondaryColor ? AppTextStyles.buttonPrimary : null,
                    label: secondaryLabel,
                    onPressedFunction: () {
                      secondaryOnPressed();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
