import 'package:flutter/cupertino.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();

  String? validateName(String? value) {
    return value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  }

  String? validateVencimento(String? value) {
    return value?.isEmpty ?? true ? "A data do vencimento não pode ser vazio" : null;
  }

  String? validateValor(double? value) {
    return value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  }

  String? validateCodigo(String? value) {
    return value?.isEmpty ?? true ? "O Código do boleto não pode ser vazio" : null;
  }

  void onChange({String? name, String? dueDate, double? value, String? barCode}) {}

  void cadastrarBoleto() {
    // * apenas com textformfield
    final form = formKey.currentState;

    if (form!.validate()) {}
  }
}
