import 'package:flutter/material.dart';
import 'package:payflow/shared/widgets/boleto-list/boleto-list-controller.dart';

import '../../shared/themes/app-colors.dart';
import '../../shared/themes/app-textstyle.dart';
import '../../shared/widgets/boleto-list/boleto-list-widget.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({Key? key}) : super(key: key);

  @override
  State<ExtractPage> createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
            child: Row(
              children: [
                Text(
                  "Meus Extratos",
                  style: AppTextStyles.titleBoldHeading,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24),
            child: Divider(
              thickness: 1,
              height: 1,
              color: AppColors.stroke,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BoletoListWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
