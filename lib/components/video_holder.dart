import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoHolder extends StatefulWidget {
  final String source;
  final bool looping;
  final bool showControls;

  VideoHolder(
      {@required this.source,
      @required this.looping,
      @required this.showControls,
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
    _videoPlayerController = VideoPlayerController.network(widget.source);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: widget.looping,
      // Try playing around with some of these other options:

      showControls: widget.showControls,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return Center(
            child: Text(errorMessage, style: TextStyle(color: Colors.red)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
