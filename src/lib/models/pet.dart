import 'package:equatable/equatable.dart';
import 'package:tamagotchi_app/models/pet_stage.dart';
import 'package:tamagotchi_app/models/pet_stats.dart';

class Pet extends Equatable {
  final String id;
  final String name;
  final DateTime birthday;
  final PetStage stage;
  final PetStats stats;
  final int carePoints;
  final DateTime lastInteraction;

  const Pet({
    required this.id,
    required this.name,
    required this.birthday,
    required this.stage,
    required this.stats,
    required this.carePoints,
    required this.lastInteraction,
  });

  factory Pet.create({required String name}) {
    return Pet(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      birthday: DateTime.now(),
      stage: PetStage.initial(),
      stats: PetStats.initial(),
      carePoints: 0,
      lastInteraction: DateTime.now(),
    );
  }

  Pet copyWith({
    String? id,
    String? name,
    DateTime? birthday,
    PetStage? stage,
    PetStats? stats,
    int? carePoints,
    DateTime? lastInteraction,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      stage: stage ?? this.stage,
      stats: stats ?? this.stats,
      carePoints: carePoints ?? this.carePoints,
      lastInteraction: lastInteraction ?? this.lastInteraction,
    );
  }

  bool get canEvolve {
    return carePoints >= stage.evolutionThreshold;
  }

  int get age {
    return DateTime.now().difference(birthday).inDays;
  }

  bool get needsAttention => stats.needsAttention;

  String get urgentNeed => stats.mostUrgentNeed;

  Duration get timeSinceLastInteraction {
    return DateTime.now().difference(lastInteraction);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        birthday,
        stage,
        stats,
        carePoints,
        lastInteraction,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthday': birthday.toIso8601String(),
      'stage': stage,
      'stats': stats.toMap(),
      'carePoints': carePoints,
      'lastInteraction': lastInteraction.toIso8601String(),
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'] as String,
      name: map['name'] as String,
      birthday: DateTime.parse(map['birthday'] as String),
      stage: map['stage'] as PetStage,
      stats: PetStats.fromMap(map['stats'] as Map<String, dynamic>),
      carePoints: map['carePoints'] as int,
      lastInteraction: DateTime.parse(map['lastInteraction'] as String),
    );
  }
}
