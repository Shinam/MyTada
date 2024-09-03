import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../app/core/models/user.dart';

class UserService {
  User? _user;

  User? get user => _user;

  Future<void> loadUser() async {
    await _copyAssetToLocalStorage('lib/ui/assets/json/user.json', 'user.json');
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/user.json');
    if (await file.exists()) {
      final contents = await file.readAsString();
      final json = jsonDecode(contents);
      _user = User.fromJson(json);
    }
  }

  Future<void> incrementBoost() async {
    if (_user != null) {
      final now = DateTime.now();
      if (_user!.lastBoostTime == null ||
          !_isSameHour(now, _user!.lastBoostTime!)) {
        if (_user!.boost < 7)
          _user!.boost += 1;
        else
          _user!.boost = 1;
        _user!.lastBoostTime = now;
        await _saveUser();
      }
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isSameHour(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day &&
        date1.hour == date2.hour;
  }

  Future<void> _saveUser() async {
    if (_user != null) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user.json');
      await file.writeAsString(jsonEncode(_user!.toJson()));
    }
  }

  Future<void> _copyAssetToLocalStorage(
      String assetPath, String localFileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$localFileName';
    final file = File(filePath);

    if (!(await file.exists())) {
      final jsonData = await rootBundle.loadString(assetPath);
      await file.writeAsString(jsonData);
    }
  }
}
