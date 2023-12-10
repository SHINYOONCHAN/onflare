import 'package:flutter/material.dart';

class CustomUnderlineText extends StatelessWidget {
  final String text;
  final bool isSelected;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomUnderlineText({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: UnderlinePainter(isSelected, fontSize, text),
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize,
            color: isSelected ? Colors.black : Colors.black,
            fontWeight: fontWeight),
      ),
    );
  }
}

class UnderlinePainter extends CustomPainter {
  final bool isSelected;
  final double fontSize;
  final String text;

  UnderlinePainter(this.isSelected, this.fontSize, this.text);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isSelected ? Colors.black : Colors.transparent
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          color: isSelected ? Colors.black : Colors.transparent,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final double textWidth = textPainter.width;
    final double startY = size.height + 7.0;
    final double centerX = (textWidth + 4) / 2;

    final Offset start = Offset(centerX - textWidth / 2, startY);
    final Offset end = Offset(centerX + textWidth / 2, startY);

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
