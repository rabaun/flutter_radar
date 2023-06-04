import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radar_flutter/radar_display.dart';

import 'marker.dart';

class MarkerDisplay extends StatefulWidget {
  final double size;
  final double zoomLevel;

  const MarkerDisplay({super.key, required this.size, required this.zoomLevel});

  @override
  State<MarkerDisplay> createState() => _MarkerDisplayState();
}

class _MarkerDisplayState extends State<MarkerDisplay>
    with SingleTickerProviderStateMixin {
  final List<Marker> _marker = [];
  final Marker _myLocation = Marker(latitude: 30, longitude: 70);

  AnimationController? _animationController;

  Animation<double>? _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.add(_myLocation);
    for (var i = 0; i < 10; i++) {
      _marker.add(Marker(
          latitude: _myLocation.latitude + Random().nextDouble() - 0.5,
          longitude: _myLocation.longitude + Random().nextDouble() - 0.5));
    }
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationController?.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 10.0).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  _getMarkers() {
    return List<Widget>.from(_marker.map((marker) {
      final diffLat = marker.latitude - _myLocation.latitude;
      final diffLng = marker.longitude - _myLocation.longitude;
      final ratio = widget.size / widget.zoomLevel;
      final top = diffLat * ratio + widget.size / 2;
      final left = diffLng * ratio + widget.size;
      return Positioned(
        left: left,
        top: top,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: _animation?.value ?? 0,
                  spreadRadius: _animation?.value ?? 0,
                )
              ]),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _getMarkers(),
    );
  }
}