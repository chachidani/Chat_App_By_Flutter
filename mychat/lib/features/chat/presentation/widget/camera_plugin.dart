import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mychat/features/chat/presentation/pages/camera_view_screen.dart';
import 'package:mychat/features/chat/presentation/pages/video_view_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras = [];

class CameraPlugin extends StatefulWidget {
  const CameraPlugin({super.key});

  @override
  State<CameraPlugin> createState() => _CameraPluginState();
}

class _CameraPluginState extends State<CameraPlugin> {
  CameraController? controller;
  Future<void>? cameraValue;
  bool isRecording = false;
  String videoPath = '';
  bool flash = false;
  bool cameraFront = false;
  double transform = 0; 

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[1], ResolutionPreset.high);
    cameraValue = controller?.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FutureBuilder<void>(
          future: cameraValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                controller != null) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(controller!));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        flash ? Icons.flash_on : Icons.flash_off,
                        size: 28,
                      ),
                      onPressed: () {
                        setState(() {
                          flash = !flash;
                        });
                        flash
                            ? controller?.setFlashMode(FlashMode.torch)
                            : controller?.setFlashMode(FlashMode.off);
                      },
                      color: Colors.white,
                    ),
                    GestureDetector(
                      onLongPress: () async {
                        final path = join((await getTemporaryDirectory()).path,
                            '${DateTime.now()}.mp4');

                        await controller?.startVideoRecording();
                        setState(() {
                          isRecording = true;
                          videoPath = path;
                        });
                      },
                      onLongPressUp: () async {
                        if (controller == null && isRecording) {
                          XFile? videoFile =
                              await controller?.stopVideoRecording();
                          if (videoFile != null) {
                            await videoFile.saveTo(videoPath);
                            setState(() {
                              isRecording = false;
                            });
                          }
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VideoViewScreen(path: videoPath)));
                      },
                      onTap: () {
                        if (!isRecording) {
                          takePicture(context);
                        }
                      },
                      child: isRecording
                          ? const Icon(
                              Icons.radio_button_on,
                              color: Colors.red,
                              size: 80,
                            )
                          : const Icon(
                              Icons.panorama_fish_eye,
                              size: 70,
                              color: Colors.white,
                            ),
                    ),
                    IconButton(
                      icon: Transform.rotate(
                        angle: transform,
                        child: const Icon(
                          Icons.flip_camera_ios,
                          size: 28,
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          cameraFront = !cameraFront;
                          transform = transform +pi ;
                        });
                        int cameraPos =  cameraFront ? 1 : 0;
                        cameras = await availableCameras();

                        controller =
                            CameraController(
                              cameras[cameraPos], ResolutionPreset.high);
                        cameraValue = controller?.initialize();

                      },
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Hold for video, tap for photo',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void takePicture(BuildContext context) async {
    final path =
        join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
    final XFile? picture = await controller?.takePicture();
    if (picture != null) {
      await picture.saveTo(path);
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CameraViewScreen(path: path)));
  }
}
