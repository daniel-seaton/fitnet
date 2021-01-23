import 'dart:math';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final double completionPercentage;
  final Color completeColor;
  final Color incompleteColor;
  final double strokeWidth;
  final double size;
  final Widget child;

  ProgressCircle(
      {@required this.completionPercentage,
      @required this.completeColor,
      @required this.incompleteColor,
      @required this.strokeWidth,
      @required this.size,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: CustomColors.darkGrey, blurRadius: 4, offset: Offset(1, 3))
      ], color: CustomColors.white, shape: BoxShape.circle),
      child: CustomPaint(
        painter: ProgressCirclePainter(
            completionPercentage: completionPercentage,
            completeColor: completeColor,
            incompleteColor: incompleteColor,
            width: strokeWidth),
        child: Center(
          child: child != null ? child : Container(height: 0.0, width: 0.0),
        ),
      ),
    );
  }
}

class ProgressCirclePainter extends CustomPainter {
  final double completionPercentage;
  final Color completeColor;
  final Color incompleteColor;
  final double width;

  const ProgressCirclePainter({
    @required this.completionPercentage,
    @required this.completeColor,
    @required this.incompleteColor,
    @required this.width,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final completePaint = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final incompletePaint = new Paint()
      ..color = incompleteColor
      ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (width / 2);
    final startAngle = -pi / 2;
    final completeSweepAngle = 2 * pi * (completionPercentage / 100);
    final incompleteSweepAngle = 2 * pi * ((100 - completionPercentage) / 100);

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, completeSweepAngle, false, completePaint);
    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        startAngle + completeSweepAngle,
        incompleteSweepAngle,
        false,
        incompletePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
