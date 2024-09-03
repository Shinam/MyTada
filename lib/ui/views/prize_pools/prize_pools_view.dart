import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:tada_beta/app/core/models/pp_user.dart';
import 'package:tada_beta/ui/common/app_colors.dart';
import 'package:tada_beta/ui/widgets/task_details.dart';
import '../../../app/core/models/task_details.dart';
import '../../widgets/AppBar.dart';
import 'prize_pools_viewmodel.dart';
import 'package:shimmer/shimmer.dart';

class PrizePoolsView extends StackedView<PrizePoolsViewModel> {
  const PrizePoolsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PrizePoolsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar:
          true, // Allow the body to extend behind the AppBar
      appBar: buildCustomAppBar(context, viewModel),
      body: PrizePoolsBody(
        viewModel: viewModel,
      ),
    );
  }

  @override
  void onViewModelReady(PrizePoolsViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  PrizePoolsViewModel viewModelBuilder(BuildContext context) =>
      PrizePoolsViewModel();
}

class PrizePoolsBody extends StatefulWidget {
  final PrizePoolsViewModel viewModel;

  const PrizePoolsBody({super.key, required this.viewModel});

  @override
  _PrizePoolsBodyState createState() => _PrizePoolsBodyState();
}

class _PrizePoolsBodyState extends State<PrizePoolsBody> {
  late ScrollController _scrollController;
  double _topOffset = 0;
  late Timer _timer; // Déclarez un Timer
  Duration _timeUntilNextTuesday =
      Duration(); // Variable pour stocker la durée restante

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Initialize the Timer to update the countdown every second
    _updateTimeUntilNextTuesday();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (mounted) {
        // Ensure the widget is still mounted before calling setState
        _updateTimeUntilNextTuesday();
      }
    });
  }

  void _updateTimeUntilNextTuesday() {
    if (mounted) {
      setState(() {
        _timeUntilNextTuesday = widget.viewModel.getTimeUntilNextTuesdayAt4PM();
      });
    }
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

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildBoostContainer(int index) {
    bool isBoosted = index < (widget.viewModel.user?.boost ?? 0);
    bool isNextToBoost = index == (widget.viewModel.user?.boost ?? 0) &&
        (widget.viewModel.user != null &&
            widget.viewModel.user!.lastBoostTime != null &&
            !widget.viewModel.isSameDay(
                DateTime.now(), widget.viewModel.user!.lastBoostTime!));
    return Container(
      width: 44,
      height: 15,
      decoration: BoxDecoration(
        color: isBoosted
            ? kcPrimaryColor
            : (isNextToBoost ? Colors.white : kcGrey),
        borderRadius: BorderRadius.only(
          topLeft: index == 0 ? Radius.circular(10) : Radius.circular(2),
          bottomLeft: index == 0 ? Radius.circular(10) : Radius.circular(2),
          topRight: index == 6 ? Radius.circular(10) : Radius.circular(2),
          bottomRight: index == 6 ? Radius.circular(10) : Radius.circular(2),
        ),
      ),
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
              FloatingImage(),
              Transform.translate(
                offset: Offset(0, -50),
                child: Container(
                  width: MediaQuery.of(context).size.width - 64,
                  height: 120,
                  decoration: BoxDecoration(
                    color: kcPrimaryColorDark.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Prize pool #1",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pot commun",
                                style: TextStyle(color: kcVeryLightGrey),
                              ),
                              if (widget.viewModel.prizepools.isNotEmpty)
                                Text(
                                  widget.viewModel.prizepools[0].pot.toString(),
                                  style: TextStyle(color: Colors.white),
                                )
                              else
                                Text(
                                  "False",
                                  style: TextStyle(color: Colors.white),
                                )
                            ],
                          ),
                          Container(
                            width: 1,
                            height:
                                48, // Ajustez cette valeur pour la hauteur souhaitée
                            color: kcBlueGrey, // Couleur du séparateur
                            margin: EdgeInsets.symmetric(
                                horizontal: 8), // Espace autour du séparateur
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Distribution dans",
                                  style: TextStyle(color: kcVeryLightGrey)),
                              Text(
                                "${_timeUntilNextTuesday.inDays.toString().padLeft(2, '0')} jours ${(_timeUntilNextTuesday.inHours % 24).toString().padLeft(2, '0')} heures",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(height: 300),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.black,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kcDarkGreyColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bonus quotidien",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              if (widget.viewModel.user != null &&
                                  widget.viewModel.user!.boost > 1)
                                Row(
                                  children: [
                                    Text(
                                      "${widget.viewModel.user!.boost} jours consécutifs",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.local_fire_department_rounded,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                7, (index) => buildBoostContainer(index)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            width: MediaQuery.of(context).size.width,
                            height:
                                1, // Ajustez cette valeur pour la hauteur souhaitée
                            color: kcGrey, // Couleur du séparateur
                          ),
                          if (widget.viewModel.user != null &&
                              widget.viewModel.user!.lastBoostTime != null &&
                              !widget.viewModel.isSameDay(DateTime.now(),
                                  widget.viewModel.user!.lastBoostTime!))
                            GestureDetector(
                              onTap: () async {
                                widget.viewModel.incrementBoost();
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: kcPrimaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Récupérer",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Prochain boost dans",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    Text(
                                      "${widget.viewModel.getTimeUntilMidnight().inHours.toString().padLeft(2, '0')} heures ${(widget.viewModel.getTimeUntilMidnight().inMinutes % 60).toString().padLeft(2, '0')} minutes",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(30),
                                    border:
                                        Border.all(width: 1, color: kcBlueGrey),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        color: kcGreen,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Récupéré",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kcDarkGreyColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.personal_injury,
                                color: Colors.white,
                                size: 32,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Ma participation à la pool",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            width: MediaQuery.of(context).size.width,
                            height:
                                1, // Ajustez cette valeur pour la hauteur souhaitée
                            color: kcGrey, // Couleur du séparateur
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tâches terminées",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    widget.viewModel.ppUsers.length.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Container(
                                width: 1,
                                height:
                                    48, // Ajustez cette valeur pour la hauteur souhaitée
                                color: kcBlueGrey, // Couleur du séparateur
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        8), // Espace autour du séparateur
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Taux de réussite",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    ((widget.viewModel.ppUsers
                                                        .where((user) =>
                                                            user.status ==
                                                            'Approuvé')
                                                        .length /
                                                    widget.viewModel.ppUsers
                                                        .length) *
                                                100)
                                            .toStringAsFixed(2) +
                                        '%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          buildTaskIndicators(
                              sortTasksForGraph(widget.viewModel.ppUsers))
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kcDarkGreyColor,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                      ),
                      child: buildListView(context, widget.viewModel),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PpUser> sortTasksForGraph(List<PpUser> ppUsers) {
    List<PpUser> retval = List.from(ppUsers);
    retval.sort((a, b) {
      int priorityA = getPriorityForGraph(a.status);
      int priorityB = getPriorityForGraph(b.status);
      return priorityA.compareTo(priorityB);
    });
    return retval;
  }

  int getPriorityForGraph(String status) {
    switch (status) {
      case 'Approuvé':
        return 1;
      case 'Refusé':
        return 2;
      default:
        return 3; // Priorité par défaut pour les statuts inconnus
    }
  }

  Widget buildTaskIndicators(List<PpUser> ppUsers) {
    double totalWidth = MediaQuery.of(context).size.width;
    double taskWidth = totalWidth / ppUsers.length / 1.2;

    return Container(
      width: totalWidth,
      height: 10,
      child: Stack(
        children: ppUsers.asMap().entries.map((entry) {
          int index = entry.key;
          PpUser ppUser = entry.value;
          return Positioned(
            left: index * taskWidth,
            child: Container(
              width: taskWidth,
              height: 10,
              decoration: BoxDecoration(
                color: getColorForStatus(ppUser.status),
                borderRadius: index == 0
                    ? BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                    : index == ppUsers.length - 1
                        ? BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )
                        : BorderRadius.zero,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color getColorForStatus(String status) {
    switch (status) {
      case 'Approuvé':
        return kcGreen; // Couleur pour les tâches correctes
      case 'Refusé':
        return Colors.red; // Couleur pour les tâches incorrectes
      default:
        return Colors.purple; // Couleur par défaut
    }
  }

  Widget buildListView(BuildContext context, PrizePoolsViewModel viewModel) {
    if (viewModel.ppUsers.isEmpty) {
      return Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[700]!,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kcGrey,
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: kcGrey,
                        ),
                        child: const SizedBox(
                          width: 40,
                          height: 10,
                        )),
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: kcGrey,
                        ),
                        child: const SizedBox(
                          width: 60,
                          height: 10,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: viewModel.ppUsers.length,
        itemBuilder: (context, index) {
          PpUser ppUser = viewModel.ppUsers[index];
          return GestureDetector(
            onTap: () async {
              TaskDetails? taskDetails =
                  await widget.viewModel.getTaskDetails(ppUser.idTask);
              showModalBottomSheet(
                context: context,
                isScrollControlled:
                    true, // This allows the BottomSheet to take full screen height
                builder: (BuildContext context) {
                  return FractionallySizedBox(
                      heightFactor: 0.7,
                      child: TaskDetailsView(
                        taskDetails: taskDetails,
                      ));
                },
              );
            },
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kcGrey,
                        ),
                        child: const Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ppUser.type,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(ppUser.date),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        ppUser.status == "Approuvé"
                            ? Icons.verified
                            : ppUser.status == 'Refusé'
                                ? Icons.cancel
                                : Icons.timelapse,
                        color: ppUser.status == "Approuvé"
                            ? kcGreen
                            : ppUser.status == "Refusé"
                                ? Colors.red
                                : kcPrimaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        ppUser.status,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 16);
        },
      );
    }
  }
}

class FloatingImage extends StatefulWidget {
  @override
  _FloatingImageState createState() => _FloatingImageState();
}

class _FloatingImageState extends State<FloatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Image.asset(
        'lib/ui/assets/tadatoken.png',
        width: MediaQuery.of(context).size.width,
        height: 150,
      ),
    );
  }
}
