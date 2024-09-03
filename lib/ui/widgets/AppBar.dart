import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';

AppBar buildCustomAppBar(BuildContext context, viewModel) {
  return AppBar(
    backgroundColor: kcMediumGrey.withOpacity(viewModel.appBarOp),
    elevation: 0,
    leading: viewModel.currentIndex == 4
        ? GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back, // Change this to any icon you like
              color: Colors.white, // Customize the color
            ),
          )
        : /*TextButton(
      onPressed: () => throw Exception(),
      child: const Text("Throw Test Exception"),
    )*/null,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        viewModel.currentIndex == 0 || viewModel.currentIndex == 1
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child:
                    viewModel.currentIndex == 0 || viewModel.currentIndex == 2
                        ? Row(
                            children: [
                              if (viewModel.user != null)
                                Text(
                                  viewModel.user!.xp.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              SizedBox(width: 8),
                              Image.asset(
                                'lib/ui/assets/xp.png',
                                width: 24,
                                height: 24,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              if (viewModel.user != null &&
                                  viewModel.currentIndex == 1)
                                Text(
                                  "500",
                                  style: TextStyle(color: Colors.white),
                                ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.group,
                                color: kcPrimaryColor,
                              ),
                            ],
                          ),
              )
            : SizedBox(
                width: 100,
              ),
        if (viewModel.appBarOp > 0.9 && viewModel.currentIndex == 1)
          Text(
            "Prize Pool #1",
            style: TextStyle(color: Colors.white),
          ),
        if (viewModel.appBarOp > 0.9 && viewModel.currentIndex == 2)
          Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(
          width: 16,
        ),
        viewModel.currentIndex != 4
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: viewModel.currentIndex == 0
                    ? Row(
                        children: [
                          Icon(
                            Icons.flash_on,
                            color: kcGreen,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          if (viewModel.user != null)
                            Text(
                              viewModel.user!.energyMax.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                        ],
                      )
                    : Row(
                        children: [
                          Icon(
                            viewModel.currentIndex == 2
                                ? Icons.settings
                                : Icons.analytics_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
              )
            : Container(),
      ],
    ),
  );
}
