import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto-model.dart';
import 'package:payflow/shared/themes/app-textstyle.dart';

class BoletoTileWidget extends StatelessWidget {
  final BoletoModel boletoModel;

  const BoletoTileWidget({Key? key, required this.boletoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          boletoModel.name!,
          style: AppTextStyles.titleListTile,
        ),
        subtitle: Text(
          "Vence em ${boletoModel.dueDate}",
          style: AppTextStyles.captionBody,
        ),
        trailing: Text.rich(
          TextSpan(
            text: "R\$",
            style: AppTextStyles.trailingRegular,
            children: <TextSpan>[
              TextSpan(
                text: "${boletoModel.value!.toStringAsFixed(2)}",
                style: AppTextStyles.trailingBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
