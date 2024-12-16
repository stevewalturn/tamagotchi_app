import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagotchi_app/app/app.locator.dart';
import 'package:tamagotchi_app/app/app.router.dart';
import 'package:tamagotchi_app/services/pet_service.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _petService = locator<PetService>();

  bool get hasPet => _petService.currentPet != null;

  Future<void> navigateToPetDetail() async {
    if (!hasPet) {
      setError('No pet found. Create a new pet first!');
      return;
    }

    try {
      await _navigationService.navigateToPetDetailView();
    } catch (e) {
      setError('Unable to view pet details. Please try again.');
    }
  }

  Future<void> createNewPet() async {
    try {
      final response = await _dialogService.showCustomDialog(
        variant: DialogType.namePet,
        title: 'Name Your Pet',
        description: 'Choose a name for your new friend!',
      );

      if (response?.confirmed == true && response?.data != null) {
        setBusy(true);
        await _petService.createNewPet(response!.data);
        await _navigationService.navigateToPetDetailView();
      }
    } catch (e) {
      setError('Unable to create a new pet. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Welcome to Tamagotchi!',
      description: 'Create and care for your virtual pet!',
    );
  }

  void showBottomSheet() {
    // Preserve existing bottom sheet functionality
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Pet Care Guide',
      description: 'Learn how to take care of your virtual pet!',
    );
  }
}
