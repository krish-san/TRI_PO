import 'dart:ui' hide TextStyle, PathMetrics, PathMetric;
import 'dart:ui' as ui show PathMetrics, PathMetric;
import 'package:flutter/material.dart';

class DashedBorder extends Border {
  final List<double> dashPattern;

  const DashedBorder({
    BorderSide top = BorderSide.none,
    BorderSide right = BorderSide.none,
    BorderSide bottom = BorderSide.none,
    BorderSide left = BorderSide.none,
    this.dashPattern = const [3, 1],
  }) : super(top: top, right: right, bottom: bottom, left: left);

  static DashedBorder all({
    Color color = const Color(0xFF000000),
    double width = 1.0,
    List<double> dashPattern = const [3, 1],
  }) {
    final BorderSide side = BorderSide(
      color: color,
      width: width,
    );
    return DashedBorder(
      top: side,
      right: side,
      bottom: side,
      left: side,
      dashPattern: dashPattern,
    );
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    Paint paint = Paint()
      ..color = top.color
      ..strokeWidth = top.width
      ..style = PaintingStyle.stroke;

    if (shape == BoxShape.rectangle) {
      if (borderRadius != null) {
        // Draw rounded rectangle with dashed border
        Path roundedPath = Path()
          ..addRRect(RRect.fromRectAndCorners(
            rect,
            topLeft: borderRadius.topLeft,
            topRight: borderRadius.topRight,
            bottomLeft: borderRadius.bottomLeft,
            bottomRight: borderRadius.bottomRight,
          ));
        
        _drawDashedPathOutline(canvas, paint, roundedPath, dashPattern);
      } else {
        // Draw straight lines for rectangle
        _drawDashedLine(canvas, paint, 
          Offset(rect.left, rect.top), 
          Offset(rect.right, rect.top), 
          dashPattern
        );
        
        _drawDashedLine(canvas, paint, 
          Offset(rect.right, rect.top), 
          Offset(rect.right, rect.bottom), 
          dashPattern
        );
        
        _drawDashedLine(canvas, paint, 
          Offset(rect.right, rect.bottom), 
          Offset(rect.left, rect.bottom), 
          dashPattern
        );
        
        _drawDashedLine(canvas, paint, 
          Offset(rect.left, rect.bottom), 
          Offset(rect.left, rect.top), 
          dashPattern
        );
      }
    } else if (shape == BoxShape.circle) {
      // Draw circle with dashed border
      Path circlePath = Path()
        ..addOval(rect);
      
      _drawDashedPathOutline(canvas, paint, circlePath, dashPattern);
    }
  }

  void _drawDashedLine(Canvas canvas, Paint paint, 
    Offset start, Offset end, List<double> dashPattern) {
    Path path = Path();
    path.moveTo(start.dx, start.dy);
    path.lineTo(end.dx, end.dy);

    double dashLength = dashPattern[0];
    double gapLength = dashPattern[1];
    double distance = (end - start).distance;
    Path dashPath = Path();

    for (double i = 0; i < distance; i += dashLength + gapLength) {
      double startFraction = i / distance;
      double endFraction = (i + dashLength) / distance;
      if (endFraction > 1.0) endFraction = 1.0;

      dashPath.moveTo(
        _lerp(start.dx, end.dx, startFraction),
        _lerp(start.dy, end.dy, startFraction),
      );
      dashPath.lineTo(
        _lerp(start.dx, end.dx, endFraction),
        _lerp(start.dy, end.dy, endFraction),
      );
    }
    canvas.drawPath(dashPath, paint);
  }

  void _drawDashedPathOutline(Canvas canvas, Paint paint, Path path, List<double> dashPattern) {
    final ui.PathMetrics pathMetrics = path.computeMetrics();
    double dashLength = dashPattern[0];
    double gapLength = dashPattern[1];

    for (final ui.PathMetric pathMetric in pathMetrics) {
      double distance = pathMetric.length;
      bool draw = true;
      double currentDistance = 0;

      while (currentDistance < distance) {
        final double remainingDistance = distance - currentDistance;
        final double nextLength = draw ? dashLength : gapLength;
        
        if (nextLength >= remainingDistance) {
          if (draw) {
            canvas.drawPath(
              pathMetric.extractPath(currentDistance, distance),
              paint,
            );
          }
          break;
        } else {
          if (draw) {
            canvas.drawPath(
              pathMetric.extractPath(
                currentDistance,
                currentDistance + nextLength,
              ),
              paint,
            );
          }
          currentDistance += nextLength;
          draw = !draw;
        }
      }
    }
  }

  double _lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }
}
