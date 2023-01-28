import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boleto-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();
  BoletoModel boletoModel = new BoletoModel();

  String? validateName(String? value) {
    return value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  }

  String? validateVencimento(String? value) {
    return value?.isEmpty ?? true ? "A data do vencimento não pode ser vazio" : null;
  }

  String? validateValor(double? value) {
    print("validate valor $value");
    return value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  }

  String? validateCodigo(String? value) {
    return value?.isEmpty ?? true ? "O Código do boleto não pode ser vazio" : null;
  }

  void onChange({
    String? name,
    String? dueDate,
    double? value,
    String? barCode,
  }) {
    // *  se o param que vc passou for nulo, ele mantém o que estava salvo

    boletoModel = boletoModel.copyWith(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barCode,
    );
  }

  Future<void> saveBoleto() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final boletos = instance.getStringList("boletos") ?? <String>[];

      boletos.add(boletoModel.toJson());

      await instance.setStringList("boletos", boletos);
      return;
    } catch (e) {
      print(e);
    }
  }

  Future<void> cadastrarBoleto() async {
    // * apenas com textformfield
    final form = formKey.currentState;

    if (form!.validate()) {
      return saveBoleto();
    }
  }
}
