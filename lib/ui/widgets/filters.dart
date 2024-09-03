import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import '../views/tasks/tasks_viewmodel.dart';

class FilterView extends StatefulWidget {
  final TasksViewModel viewModel;

  const FilterView({Key? key, required this.viewModel}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcDarkGreyColor,
      height: screenHeight(context) * 0.6,
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 70,
            height: 7,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Add your filters content here
          Expanded(
            child: Container(
              width: screenWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filtres',
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Langue',
                          style: TextStyle(color: Colors.white, fontSize: 22)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.viewModel.toggleSelection('Fr');
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Fr - Français',
                              style: TextStyle(
                                  color: widget.viewModel.isSelected('Fr')
                                      ? kcPrimaryColor
                                      : Colors.white,
                                  fontSize: 16)),
                          Icon(
                            Icons.check,
                            color: widget.viewModel.isSelected('Fr')
                                ? kcPrimaryColor
                                : Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    height: 1,
                    color: kcGrey,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.viewModel.toggleSelection('Ro');
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ro - Roumain',
                              style: TextStyle(
                                  color: widget.viewModel.isSelected('Ro')
                                      ? kcPrimaryColor
                                      : Colors.white,
                                  fontSize: 16)),
                          Icon(
                            Icons.check,
                            color: widget.viewModel.isSelected('Ro')
                                ? kcPrimaryColor
                                : Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Type d\'audio',
                          style: TextStyle(color: Colors.white, fontSize: 22)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.viewModel.toggleSelection('Production');
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Production',
                              style: TextStyle(
                                  color:
                                      widget.viewModel.isSelected('Production')
                                          ? kcPrimaryColor
                                          : Colors.white,
                                  fontSize: 16)),
                          Icon(
                            Icons.check,
                            color: widget.viewModel.isSelected('Production')
                                ? kcPrimaryColor
                                : Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    height: 1,
                    color: kcGrey,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.viewModel.toggleSelection('Verification');
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Vérification',
                              style: TextStyle(
                                  color: widget.viewModel
                                          .isSelected('Verification')
                                      ? kcPrimaryColor
                                      : Colors.white,
                                  fontSize: 16)),
                          Icon(
                            Icons.check,
                            color: widget.viewModel.isSelected('Verification')
                                ? kcPrimaryColor
                                : Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.viewModel.resetSelections();
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.only(top: 16, bottom: 16),
                                child: Text('Réinitialiser',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16))),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: kcGrey, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              widget.viewModel.applyFilters();
                              Navigator.pop(context);
                            },
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 16, bottom: 16),
                                child: Text('Appliquer',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kcPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
