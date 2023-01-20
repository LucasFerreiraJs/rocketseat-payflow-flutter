import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/modules/barcode-scanner/barcode-scanner-status.dart';

class BarcodeScannerController {
  final statusNotifier = ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());

  BarcodeScannerStatus get status => statusNotifier.value;
  set status(BarcodeScannerStatus status) => statusNotifier.value;

  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  void getAvailableCamerara() async {
    try {
      final response = await availableCameras();

      // * pegar camera traseira
      final camera = response.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
      );

      final cameraController = new CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      cameraController.initialize();

      status = BarcodeScannerStatus.available(cameraController);
      scanWithCamera();
    } catch (err) {
      status = BarcodeScannerStatus.error(err.toString());
    }
  }

  // * listener processos da camera, reconhecer barcode

  void scanWithCamera() {
    Future.delayed(Duration(seconds: 10)).then((value) {
      if (status.cameraController != null) {
        if (status.cameraController!.value.isStreamingImages) {
          status.cameraController!.stopImageStream();
        }
      }

      status = BarcodeScannerStatus.error("Timeout de leitura");
    });

    listenCamera();
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      if (status.cameraController != null) {
        if (status.cameraController!.value.isStreamingImages) {
          status.cameraController!.stopImageStream();
        }
      }

      final barcodes = await barcodeScanner.processImage(inputImage);
      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);
        if (status.cameraController != null) status.cameraController!.dispose();
      } else {
        getAvailableCamerara();
      }
    } catch (err) {
      print("Erro de leitura");
    }
  }

  void scanWithImagePicker() async {
    await status.cameraController!.stopImageStream();
    final response = await ImagePicker().getImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarCode(inputImage);
  }

  void listenCamera() {
    if (status.cameraController != null) if (status.cameraController!.value.isStreamingImages == false) {
      status.cameraController!.startImageStream((cameraImage) async {
        try {
          final WriteBuffer allBytes = WriteBuffer();

          for (Plane plane in cameraImage.planes) {
            allBytes.putUint8List(plane.bytes);
          }

          final bytes = allBytes.done().buffer.asUint8List();
          final Size imageSize = Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());
          final InputImageRotation imageRotation = InputImageRotation.Rotation_0deg;
          final InputImageFormat inputImageFormat = InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ?? InputImageFormat.NV21;

          final planeData = cameraImage.planes.map(
            (Plane plane) {
              return InputImagePlaneMetadata(
                bytesPerRow: plane.bytesPerRow,
                height: plane.height,
                width: plane.width,
              );
            },
          ).toList();

          final inputImageData = InputImageData(
            size: imageSize,
            imageRotation: imageRotation,
            inputImageFormat: inputImageFormat,
            planeData: planeData,
          );

          final inputImageCamera = InputImage.fromBytes(
            bytes: bytes,
            inputImageData: inputImageData,
          );

          await Future.delayed(Duration(seconds: 3));
          await scannerBarCode(inputImageCamera);
        } catch (err) {
          print(err);
        }
      });
    }
  }

  // * fechar
  void dispose() {
    statusNotifier.dispose();
    barcodeScanner.close();

    if (status.showCamera) {
      status.cameraController!.dispose();
    }
  }
}
