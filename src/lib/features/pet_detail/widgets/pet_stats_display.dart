import 'package:flutter/material.dart';
import 'package:tamagotchi_app/models/pet_stats.dart';
import 'package:tamagotchi_app/ui/shared/pet_status_bar.dart';

class PetStatsDisplay extends StatelessWidget {
  final PetStats stats;

  const PetStatsDisplay({
    Key? key,
    required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PetStatusBar(
              label: 'Happiness',
              value: stats.happiness,
              type: 'happiness',
            ),
            const SizedBox(height: 12),
            PetStatusBar(
              label: 'Health',
              value: stats.health,
              type: 'health',
            ),
            const SizedBox(height: 12),
            PetStatusBar(
              label: 'Energy',
              value: stats.energy,
              type: 'energy',
            ),
            const SizedBox(height: 12),
            PetStatusBar(
              label: 'Hunger',
              value: stats.hunger,
              type: 'hunger',
            ),
            const SizedBox(height: 12),
            PetStatusBar(
              label: 'Cleanliness',
              value: stats.cleanliness,
              type: 'cleanliness',
            ),
          ],
        ),
      ),
    );
  }
}
