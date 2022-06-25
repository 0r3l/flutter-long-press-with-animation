import 'dart:math';
import 'package:flutter/material.dart';

class CircularProgres extends StatelessWidget {
  final double? value;
  CircularProgres({this.value});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircularBar(
          offset: Offset(15, 15), endAngle: (pi * 2 * value!), radius: 20),
    );
  }
}

class CircularBar extends CustomPainter {
  Offset? offset = Offset(0, 0);
  double? radius = 20.0;
  double? endAngle = (pi * 2 * 0.5);

  CircularBar({this.offset, this.radius, this.endAngle});
  @override
  void paint(Canvas canvas, Size size) {
    var p = Paint()
      ..color = Colors.red[900]!
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(Rect.fromCircle(center: offset!, radius: radius!), -pi / 2,
        endAngle!, false, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
