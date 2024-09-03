import 'package:stacked/stacked.dart';

import '../../../app/core/models/user.dart';
import '../../../services/user_service.dart';

class ProfileViewModel extends BaseViewModel {
  double appBarOp = 0;
  int _currentIndex = 2;
  int onglet = 0;
  final UserService _userService = UserService();

  int get currentIndex => _currentIndex;

  User? get user => _userService.user;

  ProfileViewModel() {
    loadUser();
  }

  Future<void> loadUser() async {
    await _userService.loadUser();
    notifyListeners();
  }

  set appBarOpacity(double appBarOpacity) {
    appBarOp = appBarOpacity;
    notifyListeners();
  }

  void updateOnglet(int newIndex) {
    onglet = newIndex;
    notifyListeners();
  }
}
