import 'package:flutter/material.dart';
import 'package:tada_beta/ui/widgets/FakeOscillogram.dart';
import '../../app/core/models/task_details.dart';
import '../common/app_colors.dart';

class TaskDetailsView extends StatelessWidget {
  final TaskDetails taskDetails;

  const TaskDetailsView({Key? key, required this.taskDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcDarkGreyColor,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 70,
            height: 7,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Text("Audio vérification",
                    style: TextStyle(color: Colors.white, fontSize: 24)),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: kcGrey)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_circle,
                        color: kcPrimaryColor,
                        size: 50,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      FakeOscillogram(),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ...taskDetails.verifierResults
                    .map((result) => buildVerifierResult(result))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVerifierResult(VerifierResult result) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 2,
              color: result.verifierId == 1 ? kcGrey : Colors.transparent)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (result.verifierId == 1)
            Text("Shinam", style: TextStyle(color: Colors.white))
          else
            Text("Verificateur ${result.verifierId}",
                style: TextStyle(color: Colors.white)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildResponseTile(
                  "Genre", result.genderResponse, result.genderCorrect),
              SizedBox(width: 5),
              buildResponseTile(
                  "Bruit de fond", result.noiseResponse, result.noiseCorrect),
              SizedBox(width: 5),
              Expanded(
                // Use Flexible here
                child: buildResponseTile("Phrase prononcée",
                    result.sentenceResponse, result.sentenceCorrect),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildResponseTile(String title, String response, bool isCorrect) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isCorrect ? kcGreen : Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(response, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
