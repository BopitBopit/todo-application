import 'package:flutter/material.dart';

class HeaderClipper extends ShapeBorder {
  
   @override
  Path getOuterPath(Rect size, {TextDirection? textDirection}) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.93);

    final start = Offset(size.width * 0.03, size.height);
    final end = Offset(size.width * 0.05 + 20, size.height);

    path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);
    path.lineTo(size.width * 0.95 - 20, size.height);
    final start2 = Offset(size.width * 0.97, size.height);
    final end2 = Offset(size.width, size.height * 0.93);
    path.quadraticBezierTo(start2.dx, start2.dy, end2.dx, end2.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only(bottom: 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  
}
