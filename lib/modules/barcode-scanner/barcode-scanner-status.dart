import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  final bool isCameraAvailable;
  final String error;
  final String barcode;

  CameraController? cameraController;

  BarcodeScannerStatus({
    this.isCameraAvailable = false,
    this.cameraController,
    this.error = "",
    this.barcode = "",
  });

  // * pra quando a camera estiver ativa
  factory BarcodeScannerStatus.available(CameraController controller) => BarcodeScannerStatus(
        isCameraAvailable: true,
        cameraController: controller,
      );

  // * quando houver um erro
  factory BarcodeScannerStatus.error(String message) => BarcodeScannerStatus(error: message);

  // * quando estiver lendo o barcode
  factory BarcodeScannerStatus.barcode(String barcode) => BarcodeScannerStatus(barcode: barcode);

  // * exibe se não tiver erro e estiver disponível
  bool get showCamera => isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarcode => barcode.isNotEmpty;
}
