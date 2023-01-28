import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app-colors.dart';
import 'package:payflow/shared/themes/app-images.dart';
import 'package:payflow/shared/themes/app-textstyle.dart';

class BoletoInfoWidget extends StatelessWidget {
  final int size;

  const BoletoInfoWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              AppImages.logoMini,
              color: AppColors.background,
              width: 56,
              height: 34,
            ),
            Container(
              width: 1,
              height: 32,
              color: AppColors.background,
            ),
            Text.rich(
              TextSpan(
                text: "Você tem ",
                style: AppTextStyles.captionBackground,
                children: <TextSpan>[
                  TextSpan(
                    text: "$size boletos\n",
                    style: AppTextStyles.captionBoldBackground,
                  ),
                  TextSpan(
                    text: "cadastrados para pagar",
                    style: AppTextStyles.captionBackground,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
