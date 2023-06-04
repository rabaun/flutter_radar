import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

import 'direction_arc.dart';
import 'marker_display.dart';

class RadarDisplay extends StatefulWidget {
  const RadarDisplay({
    super.key,
  });

  @override
  State<RadarDisplay> createState() => _RadarDisplayState();
}

class _RadarDisplayState extends State<RadarDisplay> {
  final int _animationDuration = 200;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmoothCompass(
        compassBuilder: (context, compassData, compassAsset) {
          final double animationTurns =
              compassData == null || compassData.data == null
                  ? 0
                  : compassData.data!.turns * -1;
          const double size = 400; // Размер радара
          return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(255, 26, 34, 37),
                  Colors.lightBlue
                ])),
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: size,
                    width: size,
                    child: Stack(
                      children: [
                        AnimatedRotation(
                          turns: compassData == null || compassData.data == null
                              ? 0
                              : compassData.data!.turns * -1,
                          duration: const Duration(milliseconds: 200),
                          child: ShaderMask(
                            shaderCallback: (bounds) => const RadialGradient(
                                    radius: 0.75,
                                    stops: [0.3, 0.7],
                                    colors: [Colors.white, Colors.transparent])
                                .createShader(bounds),
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      scale: 3,
                                      opacity: 0.5,
                                      image: AssetImage(
                                          "assets/images/grid_tile.png"),
                                      repeat: ImageRepeat.repeat)),
                            ),
                          ),
                        ),
                        Center(
                            child:
                                Image.asset("assets/images/radar_lines.png")),
                        const Center(
                            child: DirectionaArc(
                                size: 100,
                                color: Color.fromARGB(255, 76, 144, 201))),// Отрисовывает направление человека
                        AnimatedRotation(
                          turns: animationTurns,
                          duration: Duration(milliseconds: _animationDuration),
                          child:
                              const MarkerDisplay(size: size, zoomLevel: 2),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.all(30),
                    child: AnimatedRotation(
                      turns: animationTurns,
                      duration: Duration(milliseconds: _animationDuration),
                      child: Image.asset(
                        "assets/images/compass.png",
                        scale: 2,
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}


