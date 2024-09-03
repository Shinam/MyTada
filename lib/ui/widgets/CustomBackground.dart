import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient from left (blue) to right (red)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Colors.deepPurpleAccent,
                Colors.deepPurpleAccent.withOpacity(.4),
                Colors.pinkAccent.withOpacity(.4),
                Colors.pinkAccent,
              ],
              stops: [0.0, .4, .6, 1.0],
            ),
          ),
        ),
        // Gradient from top (transparent) to bottom (black)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.black,
                Colors.black,
                Colors.black,
              ],
              stops: [0.0, 0.4, 0.5, 1.0],
            ),
          ),
        ),
        // The child widget that will be placed on top of the background
        child,
      ],
    );
  }
}
