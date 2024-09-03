import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tada_beta/ui/common/app_colors.dart';
import 'package:tada_beta/ui/widgets/CustomBackground.dart';

import '../../widgets/AppBar.dart';
import 'task_details_viewmodel.dart';

class TaskDetailsView extends StackedView<TaskDetailsViewModel> {
  const TaskDetailsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TaskDetailsViewModel viewModel,
    Widget? child,
  ) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar:
            true, // Allow the body to extend behind the AppBar
        appBar: buildCustomAppBar(context, viewModel),
        body: TaskDetailsViewBody(viewModel: viewModel),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          color: kcDarkGreyColor,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vous allez dépenser",
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(children: [
                    Text(
                      "5.00",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(
                      Icons.flash_on,
                      color: Colors.white,
                      size: 20,
                    ),
                  ]),
                ],
              ),
              GestureDetector(
                onTap: () => viewModel.UserTouchCommencer(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  decoration: BoxDecoration(
                    color: kcPrimaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Commencer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  TaskDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TaskDetailsViewModel();
}

class TaskDetailsViewBody extends StatefulWidget {
  final TaskDetailsViewModel viewModel;

  const TaskDetailsViewBody({super.key, required this.viewModel});

  @override
  _TaskDetailBodyState createState() => _TaskDetailBodyState();
}

class _TaskDetailBodyState extends State<TaskDetailsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Stack();
  }
}
