import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:tamagotchi_app/features/pet_detail/widgets/pet_action_buttons.dart';
import 'package:tamagotchi_app/features/pet_detail/widgets/pet_animation.dart';
import 'package:tamagotchi_app/features/pet_detail/widgets/pet_stats_display.dart';
import 'package:tamagotchi_app/ui/themes/app_theme.dart';
import 'pet_detail_viewmodel.dart';

class PetDetailView extends StackedView<PetDetailViewModel> {
  const PetDetailView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PetDetailViewModel viewModel,
    Widget? child,
  ) {
    if (!viewModel.hasPet) {
      return const Scaffold(
        body: Center(
          child: Text('No pet found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.pet!.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (viewModel.hasError)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    viewModel.modelError.toString(),
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        viewModel.pet!.stage.name,
                        style: AppTheme.titleStyle,
                      ),
                      Text(
                        viewModel.getAgeDisplay(),
                        style: AppTheme.captionStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              Center(
                child: PetAnimation(
                  stageType: viewModel.pet!.stage.type,
                  isHappy: viewModel.pet!.stats.happiness > 50,
                ),
              ),
              const Gap(20),
              PetStatsDisplay(stats: viewModel.pet!.stats),
              const Gap(20),
              PetActionButtons(
                onFeed: viewModel.feedPet,
                onPlay: viewModel.playWithPet,
                onClean: viewModel.cleanPet,
                isBusy: viewModel.isBusy,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PetDetailViewModel viewModelBuilder(BuildContext context) =>
      PetDetailViewModel();

  @override
  void onViewModelReady(PetDetailViewModel viewModel) {
    viewModel.updatePetStats();
  }
}
