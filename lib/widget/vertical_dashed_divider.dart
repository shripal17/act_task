import 'package:flutter/material.dart';

/// This widget just paints a custom vertical dashed line
class VerticalDashedDivider extends StatelessWidget {
  final double height;
  final double space;
  final double thickness;

  const VerticalDashedDivider({Key? key, this.height = 1, this.space = 5, this.thickness = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomPaint(painter: _VerticalDashPainter(height, space, thickness));
}

class _VerticalDashPainter extends CustomPainter {
  final double height;
  final double space;
  final double thickness;

  _VerticalDashPainter(this.height, this.space, this.thickness);

  @override
  void paint(Canvas canvas, Size size) {
    double startY = 0;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = thickness;

    final paint2 = Paint()
      ..color = const Color(0xFFC6C6C6)
      ..strokeWidth = thickness;
    while (startY < size.height) {
      canvas.drawRect(Rect.fromLTWH(0, startY, thickness, height), paint);
      canvas.drawRect(Rect.fromLTWH(0, height + startY, thickness, space), paint2);
      startY += height + space;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
