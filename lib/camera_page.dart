import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'results_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _ready = false;
  double _z = 0;
  bool _photoTaken = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cams) {
      _cameraController = CameraController(cams.first, ResolutionPreset.medium);
      _cameraController.initialize().then((_) {
        _cameraController.startImageStream((_) {});
        setState(() => _ready = true);
      });
    });
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      gyroscopeEvents.listen((e) => setState(() => _z = e.z));
      if (!_photoTaken && _z.abs() < 0.1) {
        _photoTaken = true;
        _cameraController.takePicture().then((file) {
          _cameraController.dispose();
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (_) => ResultsPage(imagePath: file.path)));
        });
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(body: CameraPreview(_cameraController));
  }
}
