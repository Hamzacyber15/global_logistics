import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mhs/models/attachment_model.dart';
import 'package:mhs/widgets/file_icon.dart';

class AddAttachment extends StatefulWidget {
  final List<AttachmentModel> attachments;
  final bool captionAllowed;
  const AddAttachment(
      {required this.attachments, required this.captionAllowed, super.key});

  @override
  State<AddAttachment> createState() => _AddAttachmentState();
}

class _AddAttachmentState extends State<AddAttachment> {
  List<AttachmentModel> attachments = [];
  PageController pageController = PageController(initialPage: 0);
  TextEditingController captionController = TextEditingController();
  int currentPage = 0;

  @override
  void initState() {
    attachments = widget.attachments;
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (attachments.isNotEmpty) {
          pageController.jumpToPage(attachments.length - 1);
          captionController.text = attachments.last.caption;
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    captionController.dispose();
    super.dispose();
  }

  void showPicker() {
    Navigator.of(context).pop((attachments, true));
  }

  void saveCaption() {
    FocusScope.of(context).unfocus();
    attachments[currentPage].caption = captionController.text;
  }

  void delete() {
    int index = currentPage;
    if (index > 0) {
      pageController.jumpToPage(index - 1);
      setState(() {
        attachments.removeAt(index);
      });
    } else if (index == 0) {
      if (attachments.length > 1) {
        pageController.jumpToPage(index + 1);
        setState(() {
          attachments.removeAt(index);
        });
      } else {
        setState(() {
          attachments.removeAt(index);
        });
      }
    }
  }

  void done() {
    Navigator.of(context).pop((attachments, false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: done,
          icon: const Icon(
            Icons.close_rounded,
          ),
        ),
        title: const Text("Add attachment"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              pageSnapping: true,
              onPageChanged: (value) {
                captionController.text = attachments[value].caption;
                currentPage = value;
              },
              itemCount: attachments.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 3.0,
                  child: FileIcon(
                    attachments[index],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 70,
            child: ListView.builder(
              itemCount: attachments.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => pageController.jumpToPage(index),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(100, 0, 0, 0),
                        ),
                        child: FileIcon(
                          attachments[index],
                          size: const Size(50, 50),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (widget.captionAllowed)
            Column(
              children: [
                TextField(
                  controller: captionController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: "Caption",
                    hintText: "Enter caption",
                  ),
                  onChanged: (value) {
                    attachments[currentPage].caption = value;
                  },
                  onEditingComplete: saveCaption,
                ),
                const Divider(),
              ],
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: showPicker,
              icon: const Icon(
                Icons.add_circle_rounded,
              ),
            ),
            IconButton(
              onPressed: delete,
              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: done,
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
