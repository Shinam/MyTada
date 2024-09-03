class VerifierResult {
  final int verifierId;
  final String genderResponse;
  final bool genderCorrect;
  final String noiseResponse;
  final bool noiseCorrect;
  final String sentenceResponse;
  final bool sentenceCorrect;

  VerifierResult({
    required this.verifierId,
    required this.genderResponse,
    required this.genderCorrect,
    required this.noiseResponse,
    required this.noiseCorrect,
    required this.sentenceResponse,
    required this.sentenceCorrect,
  });

  factory VerifierResult.fromJson(Map<String, dynamic> json) {
    return VerifierResult(
      verifierId: json['verifier_id'] as int,
      genderResponse: json['gender_response'] as String,
      genderCorrect: json['gender_correct'] as bool,
      noiseResponse: json['noise_response'] as String,
      noiseCorrect: json['noise_correct'] as bool,
      sentenceResponse: json['sentence_response'] as String,
      sentenceCorrect: json['sentence_correct'] as bool,
    );
  }
}

class TaskDetails {
  final int id;
  final int idTask;
  final String type;
  final String category;
  final String sex;
  final bool noise;
  final String sentence;
  final int sexConsensus;
  final int noiseConsensus;
  final int sentenceConsensus;
  final List<VerifierResult> verifierResults;

  TaskDetails({
    required this.id,
    required this.idTask,
    required this.type,
    required this.category,
    required this.sex,
    required this.noise,
    required this.sentence,
    required this.sexConsensus,
    required this.noiseConsensus,
    required this.sentenceConsensus,
    required this.verifierResults,
  });

  factory TaskDetails.fromJson(Map<String, dynamic> json) {
    var verifierResultsFromJson = json['verifier_results'] as List;
    List<VerifierResult> verifierResultsList =
        verifierResultsFromJson.map((i) => VerifierResult.fromJson(i)).toList();

    return TaskDetails(
      id: json['id'] as int,
      idTask: json['id_task'] as int,
      type: json['type'] as String,
      category: json['category'] as String,
      sex: json['sex'] as String,
      noise: json['noise'] as bool,
      sentence: json['sentence'] as String,
      sexConsensus: json['sex_consensus'] as int,
      noiseConsensus: json['noise_consensus'] as int,
      sentenceConsensus: json['sentence_consensus'] as int,
      verifierResults: verifierResultsList,
    );
  }
}
