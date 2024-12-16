import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagotchi_app/app/app.locator.dart';
import 'package:tamagotchi_app/app/app.router.dart';
import 'package:tamagotchi_app/services/pet_service.dart';
import 'package:tamagotchi_app/services/notification_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _petService = locator<PetService>();
  final _notificationService = locator<NotificationService>();

  Future<void> runStartupLogic() async {
    try {
      setBusy(true);

      // Initialize necessary services
      await _notificationService.initialize();

      // Simulate startup delay
      await Future.delayed(const Duration(seconds: 2));

      // Update pet stats if exists
      if (_petService.currentPet != null) {
        await _petService.updatePetStats();
      }

      // Navigate to home view
      await _navigationService.replaceWithHomeView();
    } catch (e) {
      setError('Unable to start the application. Please try again.');
    } finally {
      setBusy(false);
    }
  }
}
