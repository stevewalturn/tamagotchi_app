import 'package:stacked/stacked.dart';
import 'package:tamagotchi_app/app/app.locator.dart';
import 'package:tamagotchi_app/models/pet.dart';
import 'package:tamagotchi_app/services/pet_service.dart';
import 'package:tamagotchi_app/services/notification_service.dart';

class PetDetailViewModel extends BaseViewModel {
  final _petService = locator<PetService>();
  final _notificationService = locator<NotificationService>();

  Pet? get pet => _petService.currentPet;

  bool get hasPet => pet != null;

  Future<void> feedPet() async {
    try {
      setBusy(true);
      await _petService.feedPet();
      await _checkEvolution();
      await _notificationService.checkAndNotifyPetNeeds(pet!);
      notifyListeners();
    } catch (e) {
      setError('Unable to feed your pet right now. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  Future<void> playWithPet() async {
    try {
      setBusy(true);
      await _petService.playWithPet();
      await _checkEvolution();
      await _notificationService.checkAndNotifyPetNeeds(pet!);
      notifyListeners();
    } catch (e) {
      setError('Unable to play with your pet right now. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  Future<void> cleanPet() async {
    try {
      setBusy(true);
      await _petService.cleanPet();
      await _checkEvolution();
      await _notificationService.checkAndNotifyPetNeeds(pet!);
      notifyListeners();
    } catch (e) {
      setError('Unable to clean your pet right now. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  Future<void> _checkEvolution() async {
    if (!pet!.canEvolve) return;

    try {
      await _petService.checkEvolution();
      await _notificationService.notifyEvolution(pet!.name);
      notifyListeners();
    } catch (e) {
      setError('Unable to evolve your pet. Please try again later.');
    }
  }

  Future<void> updatePetStats() async {
    try {
      await _petService.updatePetStats();
      await _notificationService.checkAndNotifyPetNeeds(pet!);
      notifyListeners();
    } catch (e) {
      setError('Unable to update pet stats. Please check your connection.');
    }
  }

  String getAgeDisplay() {
    if (pet == null) return '';
    final age = pet!.age;
    return age == 1 ? '1 day old' : '$age days old';
  }
}
