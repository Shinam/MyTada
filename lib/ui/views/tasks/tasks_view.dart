import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tada_beta/ui/common/app_colors.dart';
import 'package:tada_beta/ui/widgets/task_shimmer.dart';
import '../../../app/core/models/task.dart';
import '../../widgets/AppBar.dart';
import '../../widgets/filters.dart';
import '../../widgets/task_builder.dart';
import 'tasks_viewmodel.dart';

class TasksView extends StackedView<TasksViewModel> {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TasksViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: buildCustomAppBar(context, viewModel),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height: 80,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      viewModel.changeIndex(0);
                    },
                    style: ButtonStyle(
                      backgroundColor: viewModel.insideIndex == 0
                          ? WidgetStateProperty.all<Color>(kcPrimaryColor)
                          : WidgetStateProperty.all<Color>(kcMediumGrey),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.window,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Tous', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.changeIndex(1);
                    },
                    style: ButtonStyle(
                      backgroundColor: viewModel.insideIndex == 1
                          ? WidgetStateProperty.all<Color>(kcPrimaryColor)
                          : WidgetStateProperty.all<Color>(kcMediumGrey),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Audio', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.changeIndex(2);
                    },
                    style: ButtonStyle(
                      backgroundColor: viewModel.insideIndex == 2
                          ? WidgetStateProperty.all<Color>(kcPrimaryColor)
                          : WidgetStateProperty.all<Color>(kcMediumGrey),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Classification d\'images',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.changeIndex(3);
                    },
                    style: ButtonStyle(
                      backgroundColor: viewModel.insideIndex == 3
                          ? WidgetStateProperty.all<Color>(kcPrimaryColor)
                          : WidgetStateProperty.all<Color>(kcMediumGrey),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.video_camera_front_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Vidéo Production',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 16), // Réduire padding vertical
              child: buildListView(context, viewModel),
            ),
          ),
        ],
      ),
      floatingActionButton: (viewModel.insideIndex == 0 ||
              viewModel.insideIndex == 1)
          ? SizedBox(
              height: 50,
              child: FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return FilterView(viewModel: viewModel);
                    },
                  );
                },
                icon: Icon(Icons.filter_list, color: Colors.white),
                label: Text('Filtres',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                backgroundColor: kcDarkGreyColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Changer l'arrondi
                  side: BorderSide(
                      color: kcBlueGrey,
                      width: 1), // Ajouter un contour de couleur
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  @override
  TasksViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TasksViewModel();

  Widget buildListView(BuildContext context, TasksViewModel viewModel) {
    if (viewModel.tasks.isEmpty) {
      return ListView.separated(
        itemCount: 6,
        itemBuilder: (context, index) =>
            card_shimmer(context, null, viewModel, false),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 16);
        },
      );
    } else {
      return ListView.separated(
        itemCount: viewModel.filteredTasks.length,
        itemBuilder: (context, index) {
          Task task = viewModel.filteredTasks[index];
          return GestureDetector(
              onTap: () => viewModel.UserTouchTask(),
              child: Container(child: card(context, task, viewModel, true)));
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 16);
        },
      );
    }
  }
}
