import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'dart:ui' as ui;

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomPaint(
        painter: SweepGradientPainter(),
        child: Container(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: MediaQuery.of(context).size.height / 2 - 90,
                    child: Image.asset(
                      'lib/ui/assets/tada-logo.png',
                      width: 150,
                      height: 150,
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height / 2,
                    left: MediaQuery.of(context).size.width / 3,
                    child: Image.asset(
                      'lib/ui/assets/tada-nom.png',
                      width: 150,
                      height: 150,
                    )),
                Positioned(
                  bottom: 60, // Adjust this value to move the text up or down
                  child: Text(
                    'V2.0.0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16, // Adjust the font size as needed
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}

class SweepGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = ui.Gradient.sweep(
        Offset(size.width / 2, size.height / 2 - 30),
        [
          Colors.black,
          Colors.purple.withOpacity(0.6),
          Colors.pink.withOpacity(0.3),
          Colors.black,
        ],
        [
          0.0,
          0.22,
          0.38,
          0.5,
        ],
        TileMode.clamp,
        0,
        3.14 * 2,
      );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
