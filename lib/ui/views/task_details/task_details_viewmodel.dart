import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tada_beta/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../app/core/models/user.dart';
import '../../../services/user_service.dart';

class TaskDetailsViewModel extends BaseViewModel {
  double appBarOp = 0;
  int _currentIndex = 4;
  final UserService _userService = UserService();


  int get currentIndex => _currentIndex;
  User? get user => _userService.user;

  final _navigationService = locator<NavigationService>();

  void UserTouchCommencer() {
    _navigationService.navigateToTaskVerificationView();
  }
}
