import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tada_beta/ui/views/tasks/tasks_viewmodel.dart';

import '../../app/core/models/task.dart';
import '../common/app_colors.dart';

import 'package:shimmer/shimmer.dart'; // Import du package Shimmer

Widget card_shimmer(
    BuildContext context, Task? task, TasksViewModel viewModel, bool loading) {
  return Container(
    decoration: BoxDecoration(
      color: kcMediumGrey,
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.all(10),
    width: 200,
    child: Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[700]!,
                child: Image.asset(
                  'lib/ui/assets/tada-logo-carre.png',
                  width: 75,
                  height: 75,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[700]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: kcBlueGrey,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            task != null ? task.format : '',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 140,
                            decoration: BoxDecoration(
                                color: kcBlueGrey,
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.only(
                                left: 9, right: 9, top: 6, bottom: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.mic,
                                  color: kcVeryLightGrey,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  task != null
                                      ? task.type + ' ' + task.category
                                      : '',
                                  style: TextStyle(
                                    color: kcVeryLightGrey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )),
                        ClipOval(
                          child: Image.asset(
                            'lib/ui/assets/flagfr.png',
                            width: 25,
                            height: 25,
                            fit: BoxFit
                                .cover, // Pour s'assurer que l'image couvre tout l'espace disponible
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[700]!,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: kcDarkGreyColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.flash_on,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      task != null ? task.energy.toString() : '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 24, // Ajustez cette valeur pour la hauteur souhaitée
                  color: kcBlueGrey, // Couleur du séparateur
                  margin: EdgeInsets.symmetric(
                      horizontal: 8), // Espace autour du séparateur
                ),
                Row(
                  children: [
                    Text(
                      task != null ? task.experience.toString() : '',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Image.asset(
                      'lib/ui/assets/xp.png',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 24, // Ajustez cette valeur pour la hauteur souhaitée
                  color: kcBlueGrey, // Couleur du séparateur
                  margin: EdgeInsets.symmetric(
                      horizontal: 8), // Espace autour du séparateur
                ),
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      task != null ? task.caution.toString() : '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
