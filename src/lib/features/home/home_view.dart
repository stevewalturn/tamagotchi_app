import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:tamagotchi_app/ui/themes/app_theme.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Tamagotchi',
                  style: AppTheme.headlineStyle,
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                if (viewModel.hasError)
                  Text(
                    viewModel.modelError.toString(),
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                const Gap(40),
                if (viewModel.hasPet)
                  ElevatedButton(
                    onPressed: viewModel.navigateToPetDetail,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('View My Pet'),
                  )
                else
                  ElevatedButton(
                    onPressed: viewModel.createNewPet,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Create New Pet'),
                  ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: viewModel.showDialog,
                      icon: const Icon(Icons.help_outline),
                      label: const Text('Help'),
                    ),
                    TextButton.icon(
                      onPressed: viewModel.showBottomSheet,
                      icon: const Icon(Icons.info_outline),
                      label: const Text('Guide'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
