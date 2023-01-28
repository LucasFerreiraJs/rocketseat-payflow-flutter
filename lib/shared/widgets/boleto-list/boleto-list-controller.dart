import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boleto-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoListController {
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  // List<BoletoModel> boletos = <BoletoModel>[];
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  BoletoListController() {
    getBoletos();
  }

  Future<void> getBoletos() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("boletos") ?? <String>[];

      boletos = response.map((item) => BoletoModel.fromJson(item)).toList();
    } catch (err) {
      boletos = <BoletoModel>[];
    }
  }
}
