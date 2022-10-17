import 'package:ecommerce_app/view/control_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../helper/local_storage_data.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // video controller
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      'assets/videos/smileFace.mp4',
    )
      ..initialize().then((_) {
        if (mounted) {
          setState(() => {});
        }
      })
      ..setVolume(0.0);

    _playVideo();
  }

  void _playVideo() async {
    final onBoarding = Get.put(LocalStorageData());
    // playing video
    _controller.play();

    //add delay till video is complete
    await Future.delayed(const Duration(seconds: 4));

    // navigating to Control View
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>  onBoarding.isUseForApp.value? const OnBoardingPage() : const ControlView() ,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio:_controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              )
            : Container(),
      ),
    );
  }
}
