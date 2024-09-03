class PpUser {
  final int id;
  final int idTask;
  final DateTime date;
  final String type;
  final String status;
  final String sex;
  final bool noise;
  final String sentence;

  PpUser(
      {required this.id,
      required this.idTask,
      required this.date,
      required this.type,
      required this.status,
      required this.sex,
      required this.noise,
      required this.sentence});

  factory PpUser.fromJson(Map<String, dynamic> json) {
    return PpUser(
        id: json['id'] as int,
        idTask: json['id_task'] as int, // Convertir 'id' en entier
        date: DateTime.parse(
            json['date']), // Conversion explicite de la chaîne en DateTime
        type: json['type'] as String,
        status: json['status'] as String,
        sex: json['sex'] as String,
        noise: json['noise'] as bool,
        sentence: json['sentence'] as String);
  }
}
