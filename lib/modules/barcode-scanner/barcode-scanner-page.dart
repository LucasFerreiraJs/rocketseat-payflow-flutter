import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode-scanner/barcode-scanner-controller.dart';
import 'package:payflow/modules/barcode-scanner/barcode-scanner-status.dart';
import 'package:payflow/shared/themes/app-colors.dart';
import 'package:payflow/shared/themes/app-text-style.dart';
import 'package:payflow/shared/widgets/bottom-sheet/bottm-sheet-widget.dart';

import 'package:payflow/shared/widgets/set-label-buttons/set-label-buttons-widget.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = new BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCamerara();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, "/insert-boleto");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose;
  }

  @override
  Widget build(BuildContext context) {
    // return BottomSheetWidget(
    //   primaryLabel: "Inserir código do boleto",
    //   primaryOnPressed: () {},
    //   secondaryLabel: "Adicionar da galeria",
    //   secondaryOnPressed: () {},
    //   title: "Não foi possível identificar um código de barras.",
    //   subTitle: "Tente escanear novamente ou digite o código do seu boleto.",
    // );

    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  child: status.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  "Escaneie o código de barras do boleto",
                  style: AppTextStyles.buttonBackground,
                ),
                centerTitle: true,
                leading: BackButton(
                  color: AppColors.background,
                ),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SetLabelButtonsWidget(
                primaryLabel: "Inserir código do boleto",
                primaryOnPressed: () {},
                secondaryLabel: "Adicionar da galeria",
                secondaryOnPressed: () {},
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return Container(
                  child: BottomSheetWidget(
                    primaryLabel: "Inserir código do boleto",
                    primaryOnPressed: () {
                      controller.getAvailableCamerara();
                    },
                    secondaryLabel: "Adicionar da galeria",
                    secondaryOnPressed: () {},
                    title: "Não foi possível identificar um código de barras.",
                    subTitle: "Tente escanear novamente ou digite o código do seu boleto.",
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
