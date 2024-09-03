class Prizepool {
  final int id;
  final double pot;
  final int number_users;
  final DateTime date;

  Prizepool(
      {required this.id,
      required this.pot,
      required this.number_users,
      required this.date});

  factory Prizepool.fromJson(Map<String, dynamic> json) {
    return Prizepool(
      id: json['id'] as int, // Convertir 'id' en entier
      pot: json['pot'] as double,
      number_users: json['number_users'] as int,
      date: DateTime.parse(
          json['date']), // Conversion explicite de la chaîne en DateTime
    );
  }
}
