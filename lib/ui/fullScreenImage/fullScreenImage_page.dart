import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FullScreenImagePage extends ConsumerWidget {
  final String thisImageTag;
  final thisImage;
  const FullScreenImagePage({
    super.key,
    required this.thisImageTag,
    required this.thisImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFile = thisImage.runtimeType != String;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Hero(
        tag: thisImageTag,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: InteractiveViewer(
            child: isFile
                ? Image.file(thisImage)
                : CachedNetworkImage(
                    imageUrl: thisImage,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
