import 'package:tada_beta/app/app.bottomsheets.dart';
import 'package:tada_beta/app/app.locator.dart';
import 'package:tada_beta/app/app.router.dart';
import 'package:tada_beta/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/core/models/user.dart';
import '../../../services/user_service.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final UserService _userService = UserService();

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  User? get user => _userService.user;

  Future<void> fetchUser() async {
    setBusy(true);
    await _userService.loadUser();
    setBusy(false);
    notifyListeners();
  }

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  // Méthode pour changer l'index
  void changeIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
