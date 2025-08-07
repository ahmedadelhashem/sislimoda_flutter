import 'package:flutter/material.dart';

class AnimatedLoaderWithImage extends StatefulWidget {
  const AnimatedLoaderWithImage({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  State<AnimatedLoaderWithImage> createState() => _AnimatedLoaderWithImageState();
}

class _AnimatedLoaderWithImageState extends State<AnimatedLoaderWithImage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
