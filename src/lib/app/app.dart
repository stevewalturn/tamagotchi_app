import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagotchi_app/services/pet_service.dart';
import 'package:tamagotchi_app/services/notification_service.dart';
import 'package:tamagotchi_app/ui/bottom_sheets/pet_actions/pet_actions_sheet.dart';
import 'package:tamagotchi_app/ui/dialogs/name_pet_dialog/name_pet_dialog.dart';
import 'package:tamagotchi_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:tamagotchi_app/features/home/home_view.dart';
import 'package:tamagotchi_app/features/startup/startup_view.dart';
import 'package:tamagotchi_app/features/pet_detail/pet_detail_view.dart';
import 'package:tamagotchi_app/features/pet_evolution/pet_evolution_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: PetDetailView),
    MaterialRoute(page: PetEvolutionView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: PetService),
    LazySingleton(classType: NotificationService),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: NamePetDialog),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: PetActionsSheet),
  ],
)
class App {}