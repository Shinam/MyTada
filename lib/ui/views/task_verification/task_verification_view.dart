import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tada_beta/ui/widgets/CustomBackground.dart';
import '../../common/app_colors.dart';
import '../../widgets/AppBar.dart';
import '../../widgets/chat_bubble.dart';
import 'task_verification_viewmodel.dart';

class TaskVerificationView extends StackedView<TaskVerificationViewModel> {
  const TaskVerificationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TaskVerificationViewModel viewModel,
    Widget? child,
  ) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildCustomAppBar(context, viewModel),
        extendBodyBehindAppBar: true, // Allow
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 48, 16, 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Icon(
                              Icons.headphones_rounded,
                              color: Colors.white,
                              size: 50,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: kcPrimaryColor,
                              border: Border.all(
                                  width: 7,
                                  color: kcPrimaryColorDark.withOpacity(0.8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1, color: kcGrey)),
                      child: viewModel.isLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : WaveBubble(
                        path: viewModel.path,
                        isSender: true,
                        appDirectory: viewModel.appDirectory,
                      ),/*Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              viewModel.startOrStopRecording();
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: kcPrimaryColor,
                              ),
                              child: Icon(
                                viewModel.isRecording
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          //OscillogramWidget(data: viewModel.oscillogramData),
                        ],
                      ),*/
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Qu'est ce qui a été dit?",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    RandomWordsDisplay(
                      phrase: "oh non quelque chose s’est mal passé",
                      viewModel: viewModel,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Réponse",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width - 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(width: 1, color: kcGrey)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  viewModel.sentence,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                decoration: BoxDecoration(
                  color: kcPrimaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Suivant",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  TaskVerificationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TaskVerificationViewModel();
}

class TaskVerificationBody extends StatefulWidget {
  final TaskVerificationViewModel viewModel;

  const TaskVerificationBody({super.key, required this.viewModel});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class RandomWordsDisplay extends StatefulWidget {
  final String phrase;
  final TaskVerificationViewModel viewModel;

  RandomWordsDisplay({Key? key, required this.phrase, required this.viewModel})
      : super(key: key);

  @override
  _RandomWordsDisplayState createState() => _RandomWordsDisplayState();
}

class _RandomWordsDisplayState extends State<RandomWordsDisplay> {
  // Predefined list of French words
  final List<String> additionalWords = [
    "bonjour",
    "maison",
    "chat",
    "chien",
    "voiture",
    "arbre",
    "fleur",
    "lune",
    "étoile",
    "mer"
  ];

  late List<String> randomAdditionalWords;
  late List<String>
      shuffledWords; // Nouvelle variable pour stocker les mots mélangés

  @override
  void initState() {
    super.initState();
    _selectRandomWords();
    _shuffleWords(); // Mélanger les mots lors de l'initialisation
  }

  void _selectRandomWords() {
    // Shuffle the additional words and pick 2 random words
    randomAdditionalWords = List.from(additionalWords)
      ..shuffle(Random())
      ..removeRange(2, additionalWords.length); // Keep only the first 2
  }

  void _shuffleWords() {
    // Split the phrase into words
    List<String> words = widget.phrase.split(' ');

    // Combine the words from the phrase and the random additional words
    words.addAll(randomAdditionalWords);

    // Shuffle the words randomly and store them in shuffledWords
    shuffledWords = words..shuffle(Random());
    words.add("Aucune des propositions");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 1, color: kcGrey),
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 12.0, // Space between words
            runSpacing: 8.0, // Space between lines
            children: shuffledWords.map((word) {
              bool isSelected = widget.viewModel.isSelected(word);
              return GestureDetector(
                onTap: () {
                  widget.viewModel.toggleWord(word);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: kcGrey, width: 1),
                    borderRadius: BorderRadius.circular(20),
                    color: isSelected
                        ? kcPrimaryColor
                        : Colors.transparent, // Change color based on selection
                  ),
                  child: Text(
                    word,
                    style: TextStyle(
                      color:
                          Colors.white, // Change text color based on selection
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
