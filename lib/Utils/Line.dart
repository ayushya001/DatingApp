
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineWithTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double lineHeight = 2.0;
    final double textPadding = 8.0;

    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = lineHeight;

    double lineStartX = 0;
    double lineEndX = size.width;
    double lineY = size.height / 2;

    // Draw the line
    canvas.drawLine(Offset(lineStartX, lineY), Offset(lineEndX, lineY), linePaint);

    // Draw the text in the middle of the line
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: 'or sign up with',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    double textX = (size.width - textPainter.width) / 2;
    double textY = lineY - textPainter.height / 2;

    textPainter.paint(canvas, Offset(textX, textY + textPadding));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}