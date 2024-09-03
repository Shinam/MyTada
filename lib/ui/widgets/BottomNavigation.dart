import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../views/home/home_view.dart';

Widget buildBottom(BuildContext context, viewModel) {
  return Container(
    height: kBottomNavigationBarHeight * 1.8,
    color: kcDarkGreyColor,
    child: TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      indicator:
          CustomTabIndicator(), // Utilisation de notre indicateur personnalisé
      onTap: (index) => viewModel.changeIndex(index),
      tabs: [
        Tab(
          icon: Icon(
            Icons.event_note_outlined,
            color: viewModel.currentIndex == 0 ? kcPrimaryColor : Colors.white,
          ),
          text: 'Tâches',
        ),
        Tab(
          icon: Icon(
            Icons.generating_tokens_outlined,
            color: viewModel.currentIndex == 1 ? kcPrimaryColor : Colors.white,
          ),
          text: 'Prize Pool',
        ),
        Tab(
          icon: Icon(
            Icons.person_2_outlined,
            color: viewModel.currentIndex == 2 ? kcPrimaryColor : Colors.white,
          ),
          text: 'Profile',
        ),
      ],
    ),
  );
}
