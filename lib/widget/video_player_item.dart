import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui_kosmos_v4/cta/cta.dart';
import 'package:ui_kosmos_v4/micro_element/micro_element.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerMedia extends StatefulWidget {
  final String url;
  const VideoPlayerMedia({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPlayerMediaState createState() => _VideoPlayerMediaState();
}

class _VideoPlayerMediaState extends State<VideoPlayerMedia> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  final int _ratioWidth = 9;
  final int _ratioHeight = 6;
  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  _initVideo() async {
    _videoPlayerController = VideoPlayerController.network(widget.url);
    await _videoPlayerController!.initialize();

    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        showOptions: false,
        autoInitialize: true,
        showControlsOnInitialize: true,
        customControls: const CupertinoControls(
          backgroundColor: Colors.black,
          iconColor: Colors.white,
        ),
        fullScreenByDefault: false,
      );
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    _chewieController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoPlayerController != null) {
      final _aspectRatio = _ratioWidth / _ratioHeight;
      // ignore: unused_local_variable
      var scale;
      if (_videoPlayerController!.value.size.width > _videoPlayerController!.value.size.height) {
        scale =
            (1 / _aspectRatio) * (_videoPlayerController!.value.size.width / _videoPlayerController!.value.size.height);
      } else {
        scale =
            (1 / _aspectRatio) * (_videoPlayerController!.value.size.height / _videoPlayerController!.value.size.width);
      }

      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              _isLoading
                  ? Center(
                      child: LoaderClassique(
                      activeColor: Colors.white.withOpacity(0.5),
                    ))
                  : SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Chewie(
                          controller: _chewieController!,
                        ),
                      ),
                    ),
              Positioned(
                top: 80.h,
                left: 10.w,
                child: CTA.back(
                  iconColor: Colors.white,
                  width: 50.w,
                  height: 50.w,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
            child: LoaderClassique(
          activeColor: Colors.white.withOpacity(0.5),
        )),
      );
    }
  }
}
