import 'package:equatable/equatable.dart';

enum PetStageType { egg, baby, child, teen, adult }

class PetStage extends Equatable {
  final PetStageType type;
  final String name;
  final int requiredCarePoints;
  final String description;
  final double evolutionThreshold;

  const PetStage({
    required this.type,
    required this.name,
    required this.requiredCarePoints,
    required this.description,
    required this.evolutionThreshold,
  });

  factory PetStage.initial() {
    return const PetStage(
      type: PetStageType.egg,
      name: 'Egg',
      requiredCarePoints: 0,
      description:
          'Your pet is still an egg! Take good care of it until it hatches.',
      evolutionThreshold: 100,
    );
  }

  PetStage copyWith({
    PetStageType? type,
    String? name,
    int? requiredCarePoints,
    String? description,
    double? evolutionThreshold,
  }) {
    return PetStage(
      type: type ?? this.type,
      name: name ?? this.name,
      requiredCarePoints: requiredCarePoints ?? this.requiredCarePoints,
      description: description ?? this.description,
      evolutionThreshold: evolutionThreshold ?? this.evolutionThreshold,
    );
  }

  @override
  List<Object?> get props => [
        type,
        name,
        requiredCarePoints,
        description,
        evolutionThreshold,
      ];

  static List<PetStage> getAllStages() {
    return [
      const PetStage(
        type: PetStageType.egg,
        name: 'Egg',
        requiredCarePoints: 0,
        description:
            'Your pet is still an egg! Take good care of it until it hatches.',
        evolutionThreshold: 100,
      ),
      const PetStage(
        type: PetStageType.baby,
        name: 'Baby',
        requiredCarePoints: 100,
        description:
            'A newly hatched baby pet! Very fragile and needs lots of attention.',
        evolutionThreshold: 300,
      ),
      const PetStage(
        type: PetStageType.child,
        name: 'Child',
        requiredCarePoints: 300,
        description: 'Growing and energetic! Needs regular care and attention.',
        evolutionThreshold: 600,
      ),
      const PetStage(
        type: PetStageType.teen,
        name: 'Teen',
        requiredCarePoints: 600,
        description: 'Getting more independent but still needs guidance.',
        evolutionThreshold: 1000,
      ),
      const PetStage(
        type: PetStageType.adult,
        name: 'Adult',
        requiredCarePoints: 1000,
        description: 'A fully grown pet! Keep maintaining its happiness.',
        evolutionThreshold: double.infinity,
      ),
    ];
  }

  static PetStage getNextStage(PetStageType currentType) {
    final stages = getAllStages();
    final currentIndex =
        stages.indexWhere((stage) => stage.type == currentType);
    if (currentIndex < stages.length - 1) {
      return stages[currentIndex + 1];
    }
    return stages.last;
  }
}
