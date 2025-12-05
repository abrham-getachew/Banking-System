import 'dart:typed_data';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class PageEleven extends StatefulWidget {
  const PageEleven({super.key});

  @override
  State<PageEleven> createState() => _PageElevenState();
}

class _PageElevenState extends State<PageEleven> {
  CameraController? _controller;
  late FaceDetector _faceDetector;
  bool _isDetecting = false;
  bool _captured = false;

  String _statusMessage = "Position your face fully within the frame";

  @override
  void initState() {
    super.initState();
    _initCamera();
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        enableClassification: true,
      ),
    );
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
          (cam) => cam.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    await _controller!.initialize();

    await _controller!.startImageStream((image) async {
      if (_isDetecting || _captured) return;
      _isDetecting = true;

      // ✅ Check if format is supported
      if (image.format.raw != 35) { // 35 = YUV_420_888
        debugPrint("Unsupported image format: ${image.format.raw}");
        setState(() => _statusMessage = "Camera format not supported for detection");
        _isDetecting = false;
        return;
      }

      final faces = await _detectFaces(image);

      if (faces.isEmpty) {
        debugPrint("No face detected in this frame");
        setState(() => _statusMessage = "No face detected");
      } else {
        debugPrint("Detected ${faces.length} face(s)");
        final face = faces.first;
        debugPrint(
            "Face bounding box: width=${face.boundingBox.width}, height=${face.boundingBox.height}");

        if (face.boundingBox.width > 100 && face.boundingBox.height > 100) {
          debugPrint("Face is large enough — capturing...");
          setState(() => _statusMessage = "Capturing...");
          _captured = true;
          await _takePicture();
        } else {
          debugPrint("Face too small — move closer");
          setState(() => _statusMessage = "Move closer to the camera");
        }
      }

      _isDetecting = false;
    });

    if (mounted) setState(() {});
  }

  Future<List<Face>> _detectFaces(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

    final camera = _controller!.description;
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.rotation0deg;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;

    final metadata = InputImageMetadata(
      size: imageSize,
      rotation: imageRotation,
      format: inputImageFormat,
      bytesPerRow: image.planes[0].bytesPerRow,
    );

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: metadata,
    );

    return await _faceDetector.processImage(inputImage);
  }

  Future<void> _takePicture() async {
    try {
      final file = await _controller!.takePicture();
      if (mounted) {
        setState(() => _statusMessage = "Face captured!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Face captured: ${file.path}")),
        );
        // TODO: Navigate or upload the image
      }
    } catch (e) {
      debugPrint("Error taking picture: $e");
      setState(() => _statusMessage = "Error capturing photo");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CameraPreview(_controller!),
          // Oval overlay
          Center(
            child: Container(
              width: 250,
              height: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          // Live status text
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Text(
              _statusMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
