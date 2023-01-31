import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode-scanner/barcode-scanner-controller.dart';
import 'package:payflow/modules/barcode-scanner/barcode-scanner-status.dart';
import 'package:payflow/shared/themes/app-colors.dart';
import 'package:payflow/shared/themes/app-textstyle.dart';
import 'package:payflow/shared/widgets/bottom-sheet/bottm-sheet-widget.dart';

import 'package:payflow/shared/widgets/set-label-buttons/set-label-buttons-widget.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(
          context,
          "/insert-boleto",
          arguments: controller.status.barcode,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                  child: controller.cameraController!.buildPreview(),
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
                primaryOnPressed: () {
                  print("navigator /insert-boleto");
                  Navigator.pushReplacementNamed(context, "/insert-boleto");
                },
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
                    primaryLabel: "Escanear novamente",
                    primaryOnPressed: () {
                      controller.scanWithCamera();
                    },
                    secondaryLabel: "Digitar código",
                    secondaryOnPressed: () {
                      Navigator.pushReplacementNamed(context, "/insert-boleto");
                    },
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
