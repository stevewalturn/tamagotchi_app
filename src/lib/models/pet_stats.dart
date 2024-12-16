import 'package:equatable/equatable.dart';

class PetStats extends Equatable {
  final double happiness;
  final double health;
  final double energy;
  final double hunger;
  final double cleanliness;

  const PetStats({
    required this.happiness,
    required this.health,
    required this.energy,
    required this.hunger,
    required this.cleanliness,
  });

  factory PetStats.initial() {
    return const PetStats(
      happiness: 100,
      health: 100,
      energy: 100,
      hunger: 100,
      cleanliness: 100,
    );
  }

  PetStats copyWith({
    double? happiness,
    double? health,
    double? energy,
    double? hunger,
    double? cleanliness,
  }) {
    return PetStats(
      happiness: happiness ?? this.happiness,
      health: health ?? this.health,
      energy: energy ?? this.energy,
      hunger: hunger ?? this.hunger,
      cleanliness: cleanliness ?? this.cleanliness,
    );
  }

  bool get needsAttention {
    return happiness < 30 ||
        health < 30 ||
        energy < 30 ||
        hunger < 30 ||
        cleanliness < 30;
  }

  String get mostUrgentNeed {
    final stats = {
      'happiness': happiness,
      'health': health,
      'energy': energy,
      'hunger': hunger,
      'cleanliness': cleanliness,
    };

    final lowestStat =
        stats.entries.reduce((a, b) => a.value < b.value ? a : b);
    return lowestStat.key;
  }

  @override
  List<Object?> get props => [
        happiness,
        health,
        energy,
        hunger,
        cleanliness,
      ];

  Map<String, double> toMap() {
    return {
      'happiness': happiness,
      'health': health,
      'energy': energy,
      'hunger': hunger,
      'cleanliness': cleanliness,
    };
  }

  factory PetStats.fromMap(Map<String, dynamic> map) {
    return PetStats(
      happiness: map['happiness'] as double,
      health: map['health'] as double,
      energy: map['energy'] as double,
      hunger: map['hunger'] as double,
      cleanliness: map['cleanliness'] as double,
    );
  }
}
