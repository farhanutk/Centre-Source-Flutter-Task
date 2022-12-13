import 'package:flutter/material.dart';

class ImageFullscreen extends StatelessWidget {
  const ImageFullscreen({Key? key, required this.imageUrl, required this.tag})
      : super(key: key);

  final String imageUrl;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          onVerticalDragDown: (details) => Navigator.of(context).pop(),
          child: Center(child: Hero(tag: tag, child: Image.network(imageUrl)))),
    );
  }
}
