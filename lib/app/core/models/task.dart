class Task {
  final int id;
  final String type;
  final String category;
  final String sexe;
  final String language;
  final String texte;
  final double caution;
  final double experience;
  final double energy;
  final String format;
  final String brand;

  Task(
      {required this.id,
      required this.type,
      required this.category,
      required this.sexe,
      required this.language,
      required this.texte,
      required this.caution,
      required this.experience,
      required this.energy,
      required this.format,
      required this.brand});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int, // Convertir 'id' en entier
      type: json['type'] as String,
      category: json['category'] as String,
      sexe: json['sexe'] as String,
      language: json['language'] as String,
      texte: json['texte'] as String,
      caution: json['caution'] as double,
      experience: json['experience'] as double,
      energy: json['energy'] as double,
      format: json['format'] as String,
      brand: json['brand'] as String,
    );
  }
}
