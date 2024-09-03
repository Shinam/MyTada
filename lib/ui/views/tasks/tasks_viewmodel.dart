import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tada_beta/app/app.router.dart';
import '../../../app/app.locator.dart';
import '../../../app/core/models/task.dart';
import '../../../app/core/models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/user_service.dart';

class TasksViewModel extends BaseViewModel {
  List<Task> tasks = [];
  List<Task> filteredTasks = [];
  final ApiService _apiService = ApiService();
  final UserService _userService = UserService();
  final _navigationService = locator<NavigationService>();

  User? get user => _userService.user;

  TasksViewModel() {
    loadTasks();
    loadUser();
  }

  Future<void> loadTasks() async {
    tasks = await _apiService.getTasks();
    applyFilters();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  double appBarOp = 1;

  Future<void> loadUser() async {
    await _userService.loadUser();
    notifyListeners();
  }

  int _insideIndex = 0;
  int get insideIndex => _insideIndex;

  void changeIndex(int newIndex) {
    _insideIndex = newIndex;
    applyFilters();
    notifyListeners();
  }

  Map<String, bool> _selected = {
    'Fr': true,
    'Ro': true,
    'Production': true,
    'Verification': true,
  };

  bool isSelected(String select) => _selected[select] ?? false;

  void toggleSelection(String select) {
    _selected[select] = !(_selected[select] ?? false);
    notifyListeners();
  }

  void resetSelections() {
    _selected.updateAll((key, value) => true);
    notifyListeners();
  }

  void applyFilters() {
    filteredTasks = tasks.where((task) {
      bool matchesLanguage = _selected[task.language] ?? true;
      bool matchesCategory = _selected[task.category] ?? true;

      if (_currentIndex == 0) {
        return matchesCategory && matchesLanguage;
      } else if (_currentIndex == 1) {
        return task.type == 'Audio' && matchesCategory && matchesLanguage;
      } else if (_currentIndex == 2) {
        return task.type == 'Classification';
      } else if (_currentIndex == 3) {
        return task.type == 'Video';
      } else {
        return true;
      }
    }).toList();
    notifyListeners();
  }

  void UserTouchTask() {
    _navigationService.navigateToTaskDetailsView();
  }
}
