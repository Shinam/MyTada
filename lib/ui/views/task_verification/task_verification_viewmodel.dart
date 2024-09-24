import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import '../../../app/core/models/user.dart';
import '../../../services/user_service.dart';
import 'package:just_audio/just_audio.dart';

class TaskVerificationViewModel extends BaseViewModel {
  double appBarOp = 0;
  int _currentIndex = 4;
  final UserService _userService = UserService();

  String sentence = '';
  final Set<String> _selectedWords = {};

  void toggleWord(String word) {
    if (word == "Aucune des propositions") {
      // Deselect all other words
      if (_selectedWords.contains("Aucune des propositions")) {
        _selectedWords.clear();
        sentence = '';
      } else {
        _selectedWords.clear();
        _selectedWords.add(word);
        sentence = word;
      }
    } else {
      if (_selectedWords.contains(word)) {
        _selectedWords.remove(word);
        sentence = sentence.replaceAll('$word ', '');
      } else {
        _selectedWords.add(word);
        sentence += '$word ';
      }
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  bool isSelected(String word) {
    return _selectedWords.contains(word);
  }

  int get currentIndex => _currentIndex;
  User? get user => _userService.user;

  late final RecorderController recorderController;

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;

  TaskVerificationViewModel() {
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/ohnon.m4a";
    isLoading = false;
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      musicFile = result.files.single.path;
    } else {
      print("File not picked");
    }
  }

  void startOrStopRecording() async {
    try {
      if (isRecording) {
        recorderController.reset();

        path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          print(path);
          print("Recorded file size: ${File(path!).lengthSync()}");
        }
      } else {
        await recorderController.record(path: path); // Path is optional
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isRecording = !isRecording;
      notifyListeners();
    }
  }

  void refreshWave() {
    if (isRecording) recorderController.refresh();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
