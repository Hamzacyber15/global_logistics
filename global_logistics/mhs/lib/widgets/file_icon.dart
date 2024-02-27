import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/loading_widget.dart';
import 'package:mhs/models/attachment_model.dart';
import 'package:mhs/widgets/document_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class FileIcon extends StatefulWidget {
  final AttachmentModel attachment;
  final Size? size;
  const FileIcon(this.attachment,
      {this.size = const Size(100, 100), super.key});

  @override
  State<FileIcon> createState() => _FileIconState();
}

class _FileIconState extends State<FileIcon> {
  bool loading = false;
  String url = "";
  String contentType = "";
  bool isLocal = true;

  @override
  void initState() {
    contentType = widget.attachment.attachmentType;
    if (widget.attachment.file == null && widget.attachment.url.isNotEmpty) {
      isLocal = false;
      loading = false;
      url = widget.attachment.url;
    } else {
      isLocal = true;
      loading = false;
      if (widget.attachment.file != null) {
        url = widget.attachment.file!.path;
      }
    }
    super.initState();
  }

  void tapped() {
    if (!isLocal) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return DocumentViewer(
          contentType,
          url,
        );
      }));
    }
  }

  void openFile() async {
    final Uri toLaunch = Uri.parse(url);

    final bool nativeAppLaunchSucceeded = await launchUrl(
      toLaunch,
      mode: LaunchMode.externalApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        toLaunch,
        mode: LaunchMode.inAppWebView,
      );
    } else {
      if (mounted) {
        Constants.showMessage(context, "Cannot open file");
      }
    }
  }

  void showMessage() {
    Constants.showMessage(context, "Cannot open file");
  }

  Widget getWidget() {
    if (isLocal) {
      if (contentType == 'memo') {
        return Icon(
          Icons.multitrack_audio_rounded,
          size: widget.size!.height,
        );
      } else if (contentType == 'media' ||
          contentType == 'image' ||
          contentType == 'jpg' ||
          contentType == 'jpeg' ||
          contentType == 'png' ||
          contentType == 'webp') {
        if (widget.attachment.file != null) {
          try {
            return Image.file(
              File(widget.attachment.url),
              fit: BoxFit.cover,
              height: widget.size!.height,
              width: widget.size!.width,
            );
          } catch (e) {
            return Icon(
              Icons.perm_media_rounded,
              size: widget.size!.height,
            );
          }
        } else {
          if (widget.attachment.bytes != null) {
            return Image.memory(
              widget.attachment.bytes!,
              fit: BoxFit.cover,
              height: widget.size!.height,
              width: widget.size!.width,
            );
          } else {
            return Icon(
              Icons.perm_media_rounded,
              size: widget.size!.height,
            );
          }
        }
      } else if (contentType == 'mp4') {
        return Icon(
          Icons.play_arrow_rounded,
          size: widget.size!.height,
        );
      }
      return Icon(
        Icons.attach_file_rounded,
        size: widget.size!.height,
      );
    } else {
      if (contentType.contains('png') ||
          contentType.contains('jpg') ||
          contentType.contains('jpeg') ||
          contentType.contains('webp')) {
        return GestureDetector(
          onTap: tapped,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              width: widget.size!.width,
              height: widget.size!.height,
              child: CachedNetworkImage(
                width: widget.size!.width,
                height: widget.size!.height,
                imageUrl: url,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const LoadingWidget(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        );
      } else if (contentType.contains('mp4')) {
        return GestureDetector(
          onTap: tapped,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
              width: 100,
              height: 200,
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill_rounded,
                  size: 50,
                ),
              ),
            ),
          ),
        );
      } else if (contentType.contains('memo')) {
        return GestureDetector(
          onTap: tapped,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
              width: 100,
              height: 200,
              child: const Center(
                child: Icon(
                  Icons.multitrack_audio_rounded,
                  size: 50,
                ),
              ),
            ),
          ),
        );
      }
      /*
      else if (contentType.contains('pdf')) {
        return GestureDetector(
          onTap: tapped,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
              width: 100,
              height: 200,
              child: const Center(
                child: Text("PDF"),
              ),
            ),
          ),
        );
      } */
      else {
        return GestureDetector(
          onTap: openFile,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
              width: 100,
              height: 200,
              child: const Center(
                child: Icon(
                  Icons.attach_file_rounded,
                  size: 50,
                ),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: loading ? const LoadingWidget() : getWidget(),
    );
  }
}
