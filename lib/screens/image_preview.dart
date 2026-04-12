import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final File image;
  const ImagePreview({super.key,required this.image});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Stack(children:[ Image.file(widget.image),
      IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
      ]),),
    );
  }
}