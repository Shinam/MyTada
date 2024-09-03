import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tada_beta/ui/views/profile/profile_view.dart';
import 'package:tada_beta/ui/views/tasks/tasks_view.dart';
import 'package:tada_beta/ui/widgets/BottomNavigation.dart';

import '../../common/app_colors.dart';
import '../../widgets/AppBar.dart';
import '../prize_pools/prize_pools_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      animationDuration: Duration(seconds: 0),
      length: 3,
      child: Stack(
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
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: const TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        TasksView(),
                        PrizePoolsView(),
                        ProfileView(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: buildBottom(context, viewModel),
          ),
        ],
      ),
    );
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.fetchUser();
    super.onViewModelReady(viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

// Classe pour dessiner un indicateur de tabulation personnalisé
class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter();
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final rect = offset & cfg.size!;
    final paint = Paint()
      ..color = kcPrimaryColor // Couleur de l'indicateur
      ..style = PaintingStyle.fill;
    final radius = 10.0; // Rayon des coins arrondis
    final indicatorWidth =
        rect.width * 1.3; // Modifier la largeur de l'indicateur

    // Dessiner l'indicateur en utilisant un rectangle avec des coins arrondis
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTRB(
          rect.left +
              (rect.width - indicatorWidth) /
                  2, // Centre l'indicateur horizontalement
          rect.top,
          rect.right -
              (rect.width - indicatorWidth) /
                  2, // Centre l'indicateur horizontalement
          7, // Hauteur de l'indicateur
        ),
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
      paint,
    );
  }
}
