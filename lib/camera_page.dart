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
      _cameraController.initialize().then((_)
