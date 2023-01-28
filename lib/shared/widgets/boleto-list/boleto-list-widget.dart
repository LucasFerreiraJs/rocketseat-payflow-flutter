import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto-model.dart';
import 'package:payflow/shared/widgets/boleto-list/boleto-list-controller.dart';
import 'package:payflow/shared/widgets/boleto-tile/boleto-tille-widget.dart';

class BoletoListWidget extends StatefulWidget {
  final BoletoListController controller;

  const BoletoListWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<BoletoListWidget> createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: widget.controller.boletosNotifier,
      builder: (_, boletos, __) => Column(
        children: boletos.map((item) => BoletoTileWidget(boletoModel: item)).toList(),
      ),
    );
  }
}
