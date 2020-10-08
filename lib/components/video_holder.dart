import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:video_player/video_player.dart';

class VideoHolder extends StatefulWidget {
  final String source;
  final bool looping;
  final bool showControls;
  final bool styleIsMaterial;

  VideoHolder(
      {@required this.source,
      @required this.looping,
      @required this.showControls,
      @required this.styleIsMaterial,
      Key key})
      : super(key: key);

  @override
  _VideoHolderState createState() => _VideoHolderState();
}

class _VideoHolderState extends State<VideoHolder> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = Uri.parse(widget.source).isAbsolute
        ? VideoPlayerController.network(widget.source)
        : VideoPlayerController.asset(widget.source);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: widget.looping,
      // Try playing around with some of these other options:

      showControls: widget.showControls,

      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return Center(
            child: Text(
          "réessayez plus tard, il y a eu un problème de connexion :(",
          style: TextStyle(color: kColorPrimary),
          textAlign: TextAlign.center,
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.light().copyWith(
            platform: widget.styleIsMaterial
                ? TargetPlatform.android
                : TargetPlatform.iOS),
        child: Chewie(controller: _chewieController));
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
