// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CameraOverlayWidget extends StatefulWidget {
  final ValueChanged<XFile> onImageCaptured;

  const CameraOverlayWidget({
    super.key,
    required this.onImageCaptured,
  });

  @override
  State<CameraOverlayWidget> createState() => _CameraOverlayWidgetState();
}

class _CameraOverlayWidgetState extends State<CameraOverlayWidget> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;
  XFile? capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) {
        throw Exception("No cameras found");
      }

      final backCamera = cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );

      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.veryHigh,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint("Error initializing camera: $e");
    }
  }

  Future<void> _captureImage() async {
    if (!_cameraController!.value.isInitialized) return;

    try {
      final XFile imageFile = await _cameraController!.takePicture();
      setState(() {
        capturedImage = imageFile;
      });
      widget.onImageCaptured(imageFile); //Send back to callback
      if (capturedImage != null) {
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 242.h,
                  width: 1.sw,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _isCameraInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width:
                                  _cameraController!.value.previewSize!.height,
                              height:
                                  _cameraController!.value.previewSize!.width,
                              child: CameraPreview(_cameraController!),
                            ),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
                SizedBox(
                  height: 250.h,
                  width: 1.sw,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              20.verticalSpace,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: FaIcon(FontAwesomeIcons.idCard,
                                    size: 30.sp),
                              ),
                              Text(
                                "Front of ID",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: _captureImage,
              icon: const Icon(Icons.camera),
              label: const Text("Capture"),
            ),
          ],
        ),
      ),
    );
  }
}
