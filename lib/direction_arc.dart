import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radar_flutter/radar_display.dart';

import 'my_painter.dart';

class DirectionaArc extends StatelessWidget {
  final double size;
  final Color color;

  const DirectionaArc({super.key, this.size = 200, required this.color});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
          radius: 0.75,
          stops: [0.3, 0.7],
          colors: [Colors.white, Colors.transparent]).createShader(bounds),
      child: CustomPaint(
        painter: MyPainter(color: color),
        size: const Size(200, 200),
      ),
    );
  }
}