import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  final bool cameraAllowed;
  final bool videoAllowed;
  const CameraView({
    required this.cameraAllowed,
    required this.videoAllowed,
    super.key,
  });
  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            bottom: 10,
            child: SizedBox(
                width: size.width,
                child:
                    // recordingStatus.isEmpty
                    //     ?
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {}, //onVideoRecordButtonPressed,
                      icon: const Icon(
                        Icons.videocam_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {}, // onTakePictureButtonPressed,
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},

                      /// switchCamera,
                      icon: const Icon(
                        Icons.switch_camera_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
