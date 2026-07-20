import 'package:flutter/material.dart';

/// Custom clipper for fill effect (bottom to top)
class FillClipper extends CustomClipper<Rect> {

  FillClipper({required this.fillProgress});
  final double fillProgress;

  @override
  Rect getClip(Size size) {
    final top = size.height * (1 - fillProgress);
    return Rect.fromLTRB(0, top, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant FillClipper oldClipper) {
    return oldClipper.fillProgress != fillProgress;
  }
}
