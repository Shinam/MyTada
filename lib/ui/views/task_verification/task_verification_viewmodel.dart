import 'package:audioplayers/audioplayers.dart';
import 'package:stacked/stacked.dart';

import '../../../app/core/models/user.dart';
import '../../../services/user_service.dart';


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


  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  void toggleAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(AssetSource('audio/ohnon.m4a'));
    }
    isPlaying = !isPlaying;
    notifyListeners(); // Notify listeners to update the UI
  }

  void onAudioFinished() {
    isPlaying = false;
    notifyListeners(); // Notify listeners to update the UI
  }

  TaskVerificationViewModel() {
    audioPlayer.onPlayerComplete.listen((event) {
      isPlaying = false;
      notifyListeners(); // Call when audio is finished
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose(); // Dispose of the audio player
    super.dispose();
  }


}
