import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:tamagotchi_app/features/pet_detail/widgets/pet_animation.dart';
import 'package:tamagotchi_app/ui/themes/app_theme.dart';
import 'pet_evolution_viewmodel.dart';

class PetEvolutionView extends StackedView<PetEvolutionViewModel> {
  const PetEvolutionView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PetEvolutionViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (viewModel.hasError)
                  Text(
                    viewModel.modelError.toString(),
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                Text(
                  '🎉 Evolution Time! 🎉',
                  style: AppTheme.headlineStyle,
                  textAlign: TextAlign.center,
                ),
                const Gap(40),
                if (viewModel.hasPet) ...[
                  PetAnimation(
                    stageType: viewModel.pet!.stage.type,
                    isHappy: true,
                  ),
                  const Gap(40),
                  Text(
                    viewModel.evolutionMessage,
                    style: AppTheme.titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(20),
                  Text(
                    viewModel.congratulationsMessage,
                    style: AppTheme.bodyStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
                const Gap(40),
                ElevatedButton(
                  onPressed: viewModel.onContinue,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  PetEvolutionViewModel viewModelBuilder(BuildContext context) =>
      PetEvolutionViewModel();
}
