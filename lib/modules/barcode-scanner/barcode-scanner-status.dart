import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  final bool isCameraAvailable;
  final String error;
  final String barcode;

  final bool stopScanner;

  BarcodeScannerStatus({
    this.isCameraAvailable = false,
    this.error = "",
    this.barcode = "",
    this.stopScanner = false,
  });

  // * pra quando a camera estiver ativa
  factory BarcodeScannerStatus.available() => BarcodeScannerStatus(
        isCameraAvailable: true,
        stopScanner: false,
      );

  // * quando houver um erro
  factory BarcodeScannerStatus.error(String message) => BarcodeScannerStatus(error: message, stopScanner: true);

  // * quando estiver lendo o barcode
  factory BarcodeScannerStatus.barcode(String barcode) => BarcodeScannerStatus(barcode: barcode, stopScanner: true);

  // * exibe se não tiver erro e estiver disponível
  bool get showCamera => isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarcode => barcode.isNotEmpty;
}
