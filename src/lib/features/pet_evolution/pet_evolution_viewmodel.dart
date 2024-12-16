import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagotchi_app/app/app.locator.dart';
import 'package:tamagotchi_app/models/pet.dart';
import 'package:tamagotchi_app/services/pet_service.dart';

class PetEvolutionViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _petService = locator<PetService>();

  Pet? get pet => _petService.currentPet;
  bool get hasPet => pet != null;

  String get evolutionMessage {
    if (!hasPet) return '';
    return '${pet!.name} has evolved to ${pet!.stage.name}!';
  }

  String get congratulationsMessage {
    if (!hasPet) return '';
    return 'Keep taking good care of ${pet!.name} to reach the next stage!';
  }

  Future<void> onContinue() async {
    try {
      await _navigationService.back();
    } catch (e) {
      setError('Unable to return to pet view. Please try again.');
    }
  }
}
