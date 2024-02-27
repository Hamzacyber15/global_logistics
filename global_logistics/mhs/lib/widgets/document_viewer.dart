import 'package:flutter/material.dart';
import 'package:mhs/widgets/pdf_view.dart';

class DocumentViewer extends StatefulWidget {
  final String type;
  final String url;
  final bool? memo;
  const DocumentViewer(this.type, this.url, {this.memo = false, super.key});

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  //late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    // if (widget.type == "mp4") {
    //   videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
    //     ..initialize().then((_) {
    //       setState(() {});
    //     });
    // }
  }

  Widget getBody() {
    if (widget.type.contains("png") ||
        widget.type.contains("jpeg") ||
        widget.type.contains("jpg") ||
        widget.type.contains("gif") ||
        widget.type.contains("webp")) {
      return InteractiveViewer(
        child: Image.network(widget.url),
      );
    }
    // else if (widget.type == "mp4") {
    //   return videoController.value.isInitialized
    //       ? Center(
    //           child: AspectRatio(
    //             aspectRatio: videoController.value.aspectRatio,
    //             child: VideoPlayer(videoController),
    //           ),
    //         )
    //       : Container();
    // }
    // else if (widget.type == "memo") {
    //   return AudioPlayer(
    //     source: widget.url,
    //     onDelete: () {},
    //     showDelete: false,
    //   );
    // }
    else if (widget.type == "pdf") {
      return PdfView(url: widget.url);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.type),
      ),
      body: getBody(),
      // floatingActionButton: (widget.type == "mp4")
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           setState(() {
      //             videoController.value.isPlaying
      //                 ? videoController.pause()
      //                 : videoController.play();
      //           });
      //         },
      //         child: Icon(
      //           videoController.value.isPlaying
      //               ? Icons.pause
      //               : Icons.play_arrow,
      //         ),
      //       )
      //     : null,
    );
  }
}
