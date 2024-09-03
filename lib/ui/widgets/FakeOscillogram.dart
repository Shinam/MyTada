import 'package:flutter/material.dart';
import 'dart:math';

class FakeOscillogram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Adjust width as needed
      height: 50, // Adjust height as needed
      child: CustomPaint(
        painter: OscillogramPainter(),
      ),
    );
  }
}

class OscillogramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.5
      ..style = PaintingStyle.fill;

    final int numBars = 40;
    final double spacing = 2; // Adjust spacing as needed
    final double barWidth = (size.width - (numBars - 1) * spacing) / numBars;
    final Random random = Random();

    for (int i = 0; i < numBars; i++) {
      double x = i * (barWidth + spacing);
      double barHeight = size.height * (0.3 + random.nextDouble() * 0.7);
      double y = (size.height - barHeight) / 2;

      canvas.drawRect(Rect.fromLTWH(x, y, barWidth, barHeight), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
