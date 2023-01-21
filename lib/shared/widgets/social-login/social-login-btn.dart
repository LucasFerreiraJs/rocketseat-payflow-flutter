import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app-colors.dart';
import 'package:payflow/shared/themes/app-images.dart';
import 'package:payflow/shared/themes/app-textstyle.dart';

class SocialLoginBtnWidget extends StatelessWidget {
  final String iconeUrl;
  final String title;
  final VoidCallback onTap;

  const SocialLoginBtnWidget({
    Key? key,
    required String this.iconeUrl,
    required String this.title,
    required VoidCallback this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            color: AppColors.shape,
            borderRadius: BorderRadius.circular(5),
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.stroke),
            )),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(iconeUrl),
                  SizedBox(width: 16),
                  Container(
                    height: 56,
                    width: 1,
                    color: AppColors.stroke,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: AppTextStyles.buttonGray),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
