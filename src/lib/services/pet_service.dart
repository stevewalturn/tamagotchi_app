import 'package:tamagotchi_app/models/pet.dart';
import 'package:tamagotchi_app/models/pet_stage.dart';
import 'package:tamagotchi_app/models/pet_stats.dart';

class PetService {
  Pet? _currentPet;

  Pet? get currentPet => _currentPet;

  Future<Pet> createNewPet(String name) async {
    try {
      final pet = Pet.create(name: name);
      _currentPet = pet;
      await _savePet(pet);
      return pet;
    } catch (e) {
      throw 'Unable to create your pet. Please try again.';
    }
  }

  Future<void> _savePet(Pet pet) async {
    try {
      // TODO: Implement persistence logic
      _currentPet = pet;
    } catch (e) {
      throw 'Failed to save pet data. Please try again.';
    }
  }

  Future<void> feedPet() async {
    if (_currentPet == null) {
      throw 'No pet found. Please create a new pet first.';
    }

    final updatedStats = _currentPet!.stats.copyWith(
      hunger: _clampValue(_currentPet!.stats.hunger + 20),
      energy: _clampValue(_currentPet!.stats.energy + 10),
    );

    final updatedPet = _currentPet!.copyWith(
      stats: updatedStats,
      carePoints: _currentPet!.carePoints + 5,
      lastInteraction: DateTime.now(),
    );

    await _savePet(updatedPet);
  }

  Future<void> playWithPet() async {
    if (_currentPet == null) {
      throw 'No pet found. Please create a new pet first.';
    }

    final updatedStats = _currentPet!.stats.copyWith(
      happiness: _clampValue(_currentPet!.stats.happiness + 20),
      energy: _clampValue(_currentPet!.stats.energy - 15),
      hunger: _clampValue(_currentPet!.stats.hunger - 10),
    );

    final updatedPet = _currentPet!.copyWith(
      stats: updatedStats,
      carePoints: _currentPet!.carePoints + 10,
      lastInteraction: DateTime.now(),
    );

    await _savePet(updatedPet);
  }

  Future<void> cleanPet() async {
    if (_currentPet == null) {
      throw 'No pet found. Please create a new pet first.';
    }

    final updatedStats = _currentPet!.stats.copyWith(
      cleanliness: _clampValue(_currentPet!.stats.cleanliness + 30),
      happiness: _clampValue(_currentPet!.stats.happiness + 5),
    );

    final updatedPet = _currentPet!.copyWith(
      stats: updatedStats,
      carePoints: _currentPet!.carePoints + 5,
      lastInteraction: DateTime.now(),
    );

    await _savePet(updatedPet);
  }

  Future<void> checkEvolution() async {
    if (_currentPet == null || !_currentPet!.canEvolve) return;

    final nextStage = PetStage.getNextStage(_currentPet!.stage.type);
    final updatedPet = _currentPet!.copyWith(stage: nextStage);
    await _savePet(updatedPet);
  }

  Future<void> updatePetStats() async {
    if (_currentPet == null) return;

    final timeSinceLastInteraction = _currentPet!.timeSinceLastInteraction;
    if (timeSinceLastInteraction.inMinutes < 30) return;

    final decreaseAmount = (timeSinceLastInteraction.inHours * 2).clamp(0, 20);

    final updatedStats = _currentPet!.stats.copyWith(
      happiness: _clampValue(_currentPet!.stats.happiness - decreaseAmount),
      hunger: _clampValue(_currentPet!.stats.hunger - decreaseAmount),
      energy: _clampValue(_currentPet!.stats.energy - decreaseAmount),
      cleanliness: _clampValue(_currentPet!.stats.cleanliness - decreaseAmount),
    );

    final updatedPet = _currentPet!.copyWith(
      stats: updatedStats,
    );

    await _savePet(updatedPet);
  }

  double _clampValue(double value) {
    return value.clamp(0.0, 100.0);
  }
}
