import 'dart:math';

import 'package:flutter/material.dart';

class MyAnimatedCard extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final List<double> stops;
  final double width;
  final double height;
  final int duration;

  MyAnimatedCard(
      {this.child,
      @required this.colors,
      @required this.stops,
      this.width,
      this.height,
      this.duration});

  MyAnimatedCard copyWith({
    Widget child,
    List<Color> colors,
    List<double> stops,
    double width,
    double height,
    double duration,
  }) {
    if ((child == null || identical(child, this.child)) &&
        (colors == null || identical(colors, this.colors)) &&
        (stops == null || identical(stops, this.stops)) &&
        (width == null || identical(width, this.width)) &&
        (height == null || identical(height, this.height)) &&
        (duration == null || identical(duration, this.duration))) {
      return this;
    }

    return new MyAnimatedCard(
      child: child ?? this.child,
      colors: colors ?? this.colors,
      stops: stops ?? this.stops,
      width: width ?? this.width,
      height: height ?? this.height,
      duration: duration ?? this.duration,
    );
  }

  @override
  _MyAnimatedCardState createState() => _MyAnimatedCardState();
}

class _MyAnimatedCardState extends State<MyAnimatedCard> {
  static const int FIX_DURATION = 1000;
  Future animate() async {
    await Future.delayed(
        Duration(milliseconds: widget.duration ?? FIX_DURATION));
    setState(() {
      animate();
    });
  }

  @override
  void initState() {
    animate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.duration ?? FIX_DURATION),
      child: widget.child,
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 10,
                offset: Offset(Random().nextDouble(), Random().nextDouble()))
          ],
          gradient: LinearGradient(
              stops: widget.stops,
              colors: [
                for (final x in widget.colors)
                  widget.colors[Random().nextInt(widget.colors.length)]
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight)),
    );
  }
}
