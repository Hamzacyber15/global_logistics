import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mhs/models/attachment_model.dart';
import 'package:mhs/widgets/add_attachement.dart';
import 'camera_view.dart';

class PickerWidget extends StatefulWidget {
  final bool cameraAllowed;
  final bool galleryAllowed;
  final bool videoAllowed;
  final bool filesAllowed;
  final bool multipleAllowed;
  final bool memoAllowed;
  final List<AttachmentModel> attachments;
  final Widget child;
  final Function onFilesPicked;
  final bool captionAllowed;
  final List<String> allowedExtensions;
  const PickerWidget({
    required this.cameraAllowed,
    required this.galleryAllowed,
    required this.videoAllowed,
    required this.filesAllowed,
    required this.multipleAllowed,
    required this.memoAllowed,
    required this.attachments,
    required this.child,
    required this.onFilesPicked,
    required this.captionAllowed,
    this.allowedExtensions = const [],
    super.key,
  });

  @override
  State<PickerWidget> createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget> {
  List<AttachmentModel> attachments = [];
  bool loading = false;
  String url = '';
  @override
  void initState() {
    attachments = widget.attachments;
    super.initState();
  }

  void showCamera() async {
    Navigator.of(context).pop();
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    XFile? file =
        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CameraView(
        cameraAllowed: widget.cameraAllowed,
        videoAllowed: widget.videoAllowed,
      );
    }));
    if (file != null) {
      String path = '';
      File? attchFile;
      Uint8List? bytes;
      // ignore: unnecessary_null_comparison
      if (!kIsWeb && file.path != null) {
        path = file.path;
        attchFile = File(path);
      }
      String ext = file.name.split('.').last;
      if (kIsWeb) {
        bytes = await file.readAsBytes();
      }
      attachments.add(
        AttachmentModel(
          "",
          "",
          "",
          ext,
          file.name,
          "",
          path,
          "",
          0,
          DateTime.now(),
          file: attchFile,
          bytes: bytes,
        ),
      );
    }
    processFiles();
  }

  void addFile(FileType ft) async {
    Navigator.of(context).pop();
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.multipleAllowed,
      type: FileType.custom,
      allowedExtensions: [
        "docx",
        "pdf",
        "png",
        "jpg",
        "jpeg",
        "webp",
        "xlsx",
        "csv"
      ],
    );
    if (result != null) {
      for (PlatformFile file in result.files) {
        String path = '';
        File? attchFile;
        Uint8List? bytes;
        if (!kIsWeb && file.path != null) {
          path = file.path!;
          attchFile = File(path);
        }
        String ext = '';
        if (!kIsWeb && file.extension != null) {
          ext = file.extension!;
        }
        if (ext.isEmpty) {
          ext = file.name.split('.').last;
        }
        if (kIsWeb) {
          bytes = file.bytes;
        }
        attachments.add(
          AttachmentModel(
            "",
            "",
            "",
            ext,
            file.name,
            "",
            user.uid,
            path,
            0,
            DateTime.now(),
            file: attchFile,
            bytes: bytes,
          ),
        );
      }
    }
    processFiles();
  }

  void processFiles() async {
    if (widget.captionAllowed) {
      if (attachments.isNotEmpty) {
        var (attch, addMore) =
            await Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) {
            return AddAttachment(
                attachments: attachments,
                captionAllowed: widget.captionAllowed);
          },
        ));
        if (attch != null) {
          attachments = attch;
        }
        if (addMore != null && addMore) {
          showPicker();
        } else {
          widget.onFilesPicked(attachments);
        }
      }
    } else {
      widget.onFilesPicked(attachments);
    }
  }

  void showAttachments() async {
    Navigator.of(context).pop();
    var (attch, addMore) = await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) {
        return AddAttachment(
            attachments: attachments, captionAllowed: widget.captionAllowed);
      },
    ));
    if (attch != null) {
      attachments = attch;
    }
    if (addMore != null && addMore) {
      showPicker();
    } else {
      widget.onFilesPicked(attachments);
    }
  }

  void showPicker() async {
    await showModalBottomSheet(
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                if (!kIsWeb && widget.cameraAllowed)
                  Column(
                    children: [
                      ListTile(
                        tileColor: Colors.transparent,
                        onTap: showCamera,
                        leading: const Icon(
                          Icons.camera_alt_outlined,
                        ),
                        title: const Text("Camera"),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                      const Divider()
                    ],
                  ),
                if (widget.galleryAllowed && widget.videoAllowed)
                  Column(
                    children: [
                      ListTile(
                        tileColor: Colors.transparent,
                        onTap: () => addFile(FileType.media),
                        leading: const Icon(
                          Icons.browse_gallery_outlined,
                        ),
                        title: const Text("Photo & Video Library"),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                      const Divider()
                    ],
                  ),
                if (widget.galleryAllowed && !widget.videoAllowed)
                  Column(
                    children: [
                      ListTile(
                        tileColor: Colors.transparent,
                        onTap: () => addFile(FileType.image),
                        leading: const Icon(
                          Icons.photo_album_outlined,
                        ),
                        title: const Text("Photo Library"),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                      const Divider()
                    ],
                  ),
                if (!widget.galleryAllowed && widget.videoAllowed)
                  Column(
                    children: [
                      ListTile(
                        tileColor: Colors.transparent,
                        onTap: () => addFile(FileType.video),
                        leading: const Icon(
                          Icons.video_collection_outlined,
                        ),
                        title: const Text("Video Library"),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                      const Divider()
                    ],
                  ),
                if (widget.filesAllowed)
                  Column(
                    children: [
                      ListTile(
                        tileColor: Colors.transparent,
                        onTap: () => addFile(FileType.custom),
                        leading: const Icon(
                          Icons.file_present_outlined,
                        ),
                        title: const Text("Document"),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                      const Divider()
                    ],
                  ),
                // if (widget.memoAllowed)
                //   Column(
                //     children: [
                //       ListTile(
                //         tileColor: Colors.transparent,
                //         onTap: addMemo,
                //         leading: const Icon(
                //           Icons.audiotrack_outlined,
                //         ),
                //         title: const Text("Record Memo"),
                //         trailing: const Icon(Icons.chevron_right_rounded),
                //       ),
                //       const Divider()
                //     ],
                //   ),
                if (widget.attachments.isNotEmpty && widget.multipleAllowed)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: showAttachments,
                          child: const Text("Show All"),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showPicker,
      child: widget.child,
    );
  }
}
