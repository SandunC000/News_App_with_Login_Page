import 'package:flutter/material.dart';

import '../models/article_model.dart';

class ImageContainer extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? child;

  const ImageContainer(
      {super.key,
      this.height = 125,
      required this.imageUrl,
      this.padding,
      this.margin,
      this.child, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          )
      ),
      child: child,
    );
  }
}
