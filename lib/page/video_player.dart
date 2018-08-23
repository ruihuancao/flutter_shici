import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shici/data/model/movie.dart';
import 'package:flutter_shici/data/movie_api.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';

class VideoDetailPage extends StatefulWidget {
  final Movie movie;

  VideoDetailPage({Key key, @required this.movie}) : super(key: key);

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetailPage> {
  List<String> sources = [];
  int current = 0;

  @override
  void initState() {
    super.initState();
    _initPage();
  }

  _initPage() async {
    Map<String, List<String>> detail = await getMovieDetail(widget.movie.link);
    print(detail);
    if (detail.containsKey("ckm3u8")) {
      setState(() {
        sources = detail["ckm3u8"];
      });
    } else if (detail.containsKey("kuyun")) {
      setState(() {
        sources = detail["kuyun"];
      });
    }
  }

  Widget _body() {
    if (sources.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return VideoFullPage(_getLink(sources[current]));
    }
  }

  String _getLink(String source) {
    return source.split("\$")[1];
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}

class VideoPlayWidget extends StatefulWidget {
  final String source;

  VideoPlayWidget({Key key, @required this.source}) : super(key: key);

  @override
  _VideoPlayWidgetState createState() => _VideoPlayWidgetState();
}

class _VideoPlayWidgetState extends State<VideoPlayWidget> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.source,
    )
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Videos'),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _controller.value.isPlaying ? _controller.pause : _controller.play,
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
