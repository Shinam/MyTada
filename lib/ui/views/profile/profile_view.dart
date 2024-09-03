import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../widgets/AppBar.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar:
            true, // Allow the body to extend behind the AppBar
        appBar: buildCustomAppBar(context, viewModel),
        body: ProfileViewBody(viewModel: viewModel));
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}

class ProfileViewBody extends StatefulWidget {
  final ProfileViewModel viewModel;

  const ProfileViewBody({super.key, required this.viewModel});

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileViewBody> {
  late ScrollController _scrollController;
  double _topOffset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (mounted) {
      setState(() {
        _topOffset = _scrollController.offset *
            -0.3; // Adjust the factor to control the scroll effect
        widget.viewModel.appBarOpacity =
            ((_scrollController.offset - 100) / 100).clamp(0, 0.95);
      });
    }
  }

  Widget buildBoostContainer(int index) {
    bool isBoosted = index < 20;
    bool isNextBoosted = index >= 20 && index < 30;
    return Container(
      width: 6,
      height: 30,
      decoration: BoxDecoration(
          color: isBoosted ? kcGreen : (isNextBoosted ? Colors.blue : kcGrey),
          borderRadius: BorderRadius.circular(50)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top / 2;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: _topOffset + topPadding,
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: kcGrey,
                    width: 5.0,
                  ),
                  color: Colors.black,
                ),
                child: Container(),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                '@Shinam',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: kcMediumGrey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    if (widget.viewModel.user != null)
                      Text(
                        widget.viewModel.user!.xp.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    SizedBox(width: 8),
                    Image.asset(
                      'lib/ui/assets/xp.png',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(height: 300),
              Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: [
                            kcMediumGrey.withRed(0).withGreen(150).withBlue(90),
                            kcMediumGrey,
                          ],
                          stops: [0, 0.3],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Energie',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.flash_on,
                                        color: kcGreen,
                                      ),
                                      Text(
                                        '150%',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Temps restant',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  CountdownTimer()
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Recharge',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '+5',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        '+20',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                30, (index) => buildBoostContainer(index)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: kcDarkGreyColor,
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  kcDarkGreyColor,
                                  kcDarkGreyColor.withOpacity(.4),
                                  Colors.pinkAccent.withOpacity(.2),
                                  Colors.pinkAccent,
                                ],
                                stops: [0.0, .4, .6, 1.0],
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(16, 8, 8, 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Code Parrain',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Icon(
                                                Icons.folder_copy,
                                                color: Colors.white,
                                                size: 16,
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'b06a11590b',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Partager mon code',
                                            style: TextStyle(
                                                color: kcPrimaryColor),
                                          ),
                                          Icon(
                                            Icons.share,
                                            color: kcPrimaryColor,
                                            size: 12,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 20,
                                  top: 0,
                                  bottom: 0,
                                  child: Image.asset(
                                    'lib/ui/assets/tadzzz.png',
                                    width: 180, // Adjust the width as needed
                                    height: 180, // Adjust the height as needed
                                  ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => widget.viewModel.updateOnglet(0),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2,
                                        color: widget.viewModel.onglet == 0
                                            ? Colors.white
                                            : kcGrey)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Centrer le contenu
                                children: [
                                  Icon(Icons.wallet,
                                      color: widget.viewModel.onglet == 0
                                          ? kcPrimaryColor
                                          : Colors.white),
                                  SizedBox(width: 8),
                                  Text('Portefeuille',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => widget.viewModel.updateOnglet(1),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2,
                                        color: widget.viewModel.onglet == 1
                                            ? Colors.white
                                            : kcGrey)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Centrer le contenu
                                children: [
                                  Icon(Icons.stacked_line_chart,
                                      color: widget.viewModel.onglet == 1
                                          ? kcPrimaryColor
                                          : Colors.white),
                                  SizedBox(width: 8),
                                  Text('Staking',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: kcDarkGreyColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(15)),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            kcBlueGrey,
                                            Colors.white
                                                .withBlue(100)
                                                .withGreen(70)
                                                .withRed(70),
                                            Colors.white
                                                .withBlue(200)
                                                .withGreen(80)
                                                .withRed(200),
                                          ],
                                          stops: [0, 0.4, 1.0],
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Portefeuille tada',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '4200000.0000',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Image.asset(
                                                    'lib/ui/assets/tada-logo.png',
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '≈ \$32700.00',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: -20,
                                      top: 10,
                                      bottom: -20,
                                      child: Image.asset(
                                        'lib/ui/assets/tadatoken.png',
                                        width:
                                            150, // Adjust the width as needed
                                        height:
                                            150, // Adjust the height as needed
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: kcMediumGrey,
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(15)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        kcBlueGrey.withOpacity(0.5),
                                        Colors.white
                                            .withBlue(100)
                                            .withGreen(70)
                                            .withRed(70)
                                            .withOpacity(0.5),
                                        Colors.white
                                            .withBlue(200)
                                            .withGreen(80)
                                            .withRed(200)
                                            .withOpacity(0.5),
                                      ],
                                      stops: [0, 0.4, 1.0],
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                color: kcDarkGreyColor,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    width: 1,
                                                    color: kcBlueGrey)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Stake',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: kcDarkGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                width: 2, color: kcBlueGrey)),
                                        child: Transform.rotate(
                                            angle: -45 *
                                                (3.1415926535897932 / 180),
                                            child: Icon(
                                              Icons.send_rounded,
                                              color: Colors.white,
                                              size: 30,
                                            ))),
                                    Container(
                                      width: 1,
                                      color: kcBlueGrey,
                                      height: 40,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: kcDarkGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                width: 2, color: kcBlueGrey)),
                                        child: Icon(
                                          Icons.download_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                    Container(
                                      width: 1,
                                      color: kcBlueGrey,
                                      height: 40,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: kcPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                width: 2, color: kcBlueGrey)),
                                        child: Icon(
                                          Icons.swap_vert,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String getTimeRemaining() {
    DateTime now = DateTime.now();
    int minutes = now.minute;
    int seconds = now.second;

    int minutesUntilNextTenth = 10 - (minutes % 10);
    int secondsUntilNextTenth = (minutesUntilNextTenth * 60) - seconds;

    int displayMinutes = secondsUntilNextTenth ~/ 60;
    int displaySeconds = secondsUntilNextTenth % 60;

    return '${displayMinutes.toString().padLeft(2, '0')}:${displaySeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getTimeRemaining(),
      style: TextStyle(color: Colors.white, fontSize: 18),
    );
  }
}
