class User {
  final String username;
  final String email;
  final String password;
  final int xp;
  final int energyMax;
  int boost; // Rendre boost non final pour permettre la modification
  DateTime? lastBoostTime;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.xp,
    required this.energyMax,
    required this.boost,
    this.lastBoostTime,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      xp: json['xp'] as int,
      energyMax: json['energy_max'] as int,
      boost: json['boost'] as int,
      lastBoostTime: json['lastBoostTime'] != null
          ? DateTime.parse(json['lastBoostTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'xp': xp,
      'energy_max': energyMax,
      'boost': boost,
      'lastBoostTime': lastBoostTime?.toIso8601String(),
    };
  }
}
