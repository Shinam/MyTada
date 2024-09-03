import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tada_beta/ui/views/tasks/tasks_viewmodel.dart';

import '../../app/core/models/task.dart';
import '../common/app_colors.dart';

Widget card(
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
              child: Image.asset(
                getLogo(task != null ? task.brand : ''),
                width: 75,
                height: 75,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mission',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: kcBlueGrey,
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.only(
                              left: 9, right: 9, top: 6, bottom: 6),
                          child: Row(
                            children: [
                              Icon(
                                getCategoryIcon(task != null ? task.type : '',
                                    task != null ? task.category : ''),
                                color: kcVeryLightGrey,
                                size: 20,
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
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kcGrey,
                            width: task != null &&
                                    getFlagImagePath(task.language).isNotEmpty
                                ? 2.0
                                : 0.0,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: task != null &&
                                  getFlagImagePath(task.language).isNotEmpty
                              ? Image.asset(
                                  getFlagImagePath(task.language),
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit
                                      .cover, // Pour s'assurer que l'image couvre tout l'espace disponible
                                )
                              : SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: kcDarkGreyColor, borderRadius: BorderRadius.circular(10)),
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
      ],
    ),
  );
}

String getFlagImagePath(String language) {
  switch (language) {
    case 'Fr':
      return 'lib/ui/assets/flagfr.png';
    case 'Ro':
      return 'lib/ui/assets/flagro.png';
    // Ajoutez d'autres langues ici
    default:
      return ''; // Un drapeau par défaut si la langue n'est pas reconnue
  }
}

IconData getCategoryIcon(String type, String category) {
  switch (type) {
    case 'Audio':
      switch (category) {
        case 'Production':
          return Icons.mic;
        case 'Verification':
          return Icons.verified;
        default:
          return Icons.cancel;
      }
    case 'Classification':
      switch (category) {
        case 'Image':
          return Icons.image;
        default:
          Icons.hide_image;
      }
    case 'Video':
      return Icons.video_camera_front_outlined;
    default:
      return Icons.ac_unit;
  }
  return Icons.ac_unit;
}

String getLogo(String brand) {
  switch (brand) {
    case 'Tada':
      return 'lib/ui/assets/tada-logo-carre.png';
    case 'Identt':
      return 'lib/ui/assets/Identt-logo.png';
    // Ajoutez d'autres langues ici
    default:
      return ''; // Un drapeau par défaut si la langue n'est pas reconnue
  }
}
