import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:flutter/material.dart';

class MultiTouchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multitouch Demo'),
        ),
        body: DrawArea(),
      ),
    );
  }
}

class DrawArea extends StatefulWidget {
  @override
  _DrawAreaState createState() => _DrawAreaState();
}

class _DrawAreaState extends State<DrawArea> {
  List<Offset> points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox object = context.findRenderObject() as RenderBox;
          Offset _localPosition = object.globalToLocal(details.globalPosition);
          points = List.from(points)..add(_localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) {},
      child: CustomPaint(
        painter: TouchPainter(points),
        size: Size.infinite,
      ),
    );
  }
}

class TouchPainter extends CustomPainter {
  final List<Offset> points;

  TouchPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawCircle(points[i], 50.0, paint);
    }
  }

  @override
  bool shouldRepaint(TouchPainter oldDelegate) => oldDelegate.points != points;
}
