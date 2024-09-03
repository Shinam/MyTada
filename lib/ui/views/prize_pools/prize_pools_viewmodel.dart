import 'package:stacked/stacked.dart';
import 'package:tada_beta/app/core/models/pp_user.dart';
import 'package:tada_beta/app/core/models/prizepool.dart';
import 'package:tada_beta/app/core/models/task_details.dart';
import 'package:tada_beta/services/user_service.dart';

import '../../../app/core/models/user.dart';
import '../../../services/api_service.dart';

class PrizePoolsViewModel extends BaseViewModel {
  final ApiService _apiService = ApiService();
  final UserService _userService = UserService();
  List<Prizepool> prizepools = [];
  List<PpUser> ppUsers = [];
  bool hasClaimedReward = false;

  User? get user => _userService.user;

  int _currentIndex = 1;

  int get currentIndex => _currentIndex;

  double appBarOp = 0;

  PrizePoolsViewModel() {
    loadPP();
    loadUser(); // Chargez les données de l'utilisateur
    loadPPUser();
  }

  set appBarOpacity(double appBarOpacity) {
    appBarOp = appBarOpacity;
    notifyListeners();
  }

  Future<void> loadPP() async {
    prizepools = await _apiService.getPrizePools();
    notifyListeners();
  }

  Future<void> loadUser() async {
    await _userService.loadUser();
    notifyListeners();
  }

  Future<void> loadPPUser() async {
    ppUsers = await _apiService.getPpUser();
    notifyListeners();
  }

  Future<TaskDetails> getTaskDetails(int id) async {
    return _apiService.getTaskDetails(id);
  }

  Future<void> incrementBoost() async {
    hasClaimedReward = true;
    await _userService.incrementBoost();
    notifyListeners();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day &&
        date1.hour == date2.hour;
  }

  DateTime getNextTuesdayAt4PM() {
    DateTime now = DateTime.now();
    DateTime nextTuesday =
        now.add(Duration(days: (DateTime.tuesday - now.weekday + 7)));
    return DateTime(nextTuesday.year, nextTuesday.month, nextTuesday.day, 16);
  }

  Duration getTimeUntilNextTuesdayAt4PM() {
    DateTime nextTuesdayAt4PM = getNextTuesdayAt4PM();
    return nextTuesdayAt4PM.difference(DateTime.now());
  }

  Duration getTimeUntilMidnight() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return tomorrow.difference(now);
  }

  void resetReward() {
    hasClaimedReward = false;
    notifyListeners();
  }
}
