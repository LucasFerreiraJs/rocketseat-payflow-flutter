import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert-boleto/insert-boleto-controller.dart';
import 'package:payflow/shared/themes/app-colors.dart';
import 'package:payflow/shared/themes/app-textstyle.dart';
import 'package:payflow/shared/widgets/input-text/input-text-widget.dart';
import 'package:payflow/shared/widgets/set-label-buttons/set-label-buttons-widget.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;

  const InsertBoletoPage({
    Key? key,
    this.barcode,
  }) : super(key: key);

  @override
  State<InsertBoletoPage> createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    initialValue: 0,
    decimalSeparator: ",",
  );

  final dueDateInputTextController = MaskedTextController(
    mask: "00/00/0000",
  );

  final barcodeInputTextController = TextEditingController();

  // * informação vinda do leitor
  @override
  void initState() {
    if (widget.barcode != null) {
      print("barcode recebido ${widget.barcode}");
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 93),
                child: Text(
                  "Preencha os dados do boleto",
                  style: AppTextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: <Widget>[
                    InputTextWidget(
                      label: "Nome do boleto",
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        controller.onChange(name: value);
                      },
                      validator: controller.validateName,
                    ),
                    InputTextWidget(
                      controller: dueDateInputTextController,
                      label: "Vencimento",
                      validator: controller.validateVencimento,
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        controller.onChange(dueDate: value);
                      },
                    ),
                    InputTextWidget(
                      controller: moneyInputTextController,
                      label: "Valor",
                      validator: (_) => controller.validateValor(moneyInputTextController.numberValue),
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (value) {
                        print("on change value $value e ${moneyInputTextController.numberValue}");
                        controller.onChange(value: moneyInputTextController.numberValue);
                      },
                    ),
                    InputTextWidget(
                      controller: barcodeInputTextController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      validator: controller.validateCodigo,
                      onChanged: (value) {
                        controller.onChange(barcode: value);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtonsWidget(
        primaryLabel: "Cancelar",
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: "Cadastrar",
        enableSecondaryColor: true,
        secondaryOnPressed: () async {
          print(widget.barcode);

          await controller.cadastrarBoleto();
          Navigator.pop(context);
        },
      ),
    );
  }
}
