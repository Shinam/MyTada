import 'package:tada_beta/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:tada_beta/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:tada_beta/ui/views/home/home_view.dart';
import 'package:tada_beta/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tada_beta/ui/views/prize_pools/prize_pools_view.dart';
import 'package:tada_beta/ui/views/tasks/tasks_view.dart';
import 'package:tada_beta/services/api_service.dart';
import 'package:tada_beta/ui/bottom_sheets/filters/filters_sheet.dart';
import 'package:tada_beta/ui/views/profile/profile_view.dart';
import 'package:tada_beta/services/user_service.dart';
import 'package:tada_beta/ui/views/task_details/task_details_view.dart';
import 'package:tada_beta/ui/views/task_verification/task_verification_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: PrizePoolsView),
    MaterialRoute(page: TasksView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: TaskDetailsView),
    MaterialRoute(page: TaskVerificationView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: UserService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: FiltersSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
