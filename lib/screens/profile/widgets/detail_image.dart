import 'package:flutter/material.dart';

class DetailImage extends StatefulWidget {
  final String url;
  final int index;
  const DetailImage({Key? key, required this.url, required this.index})
      : super(key: key);

  @override
  State<DetailImage> createState() => _DetailImageState();
}

class _DetailImageState extends State<DetailImage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.index,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 400,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(0.0)),
          child: Image.asset(
            widget.url,
            fit: BoxFit.contain,
            height: 400.0,
          ),
        ),
      ),
    );
  }
}
