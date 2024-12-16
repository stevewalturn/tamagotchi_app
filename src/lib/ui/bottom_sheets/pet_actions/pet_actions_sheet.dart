import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagotchi_app/ui/themes/app_theme.dart';

class PetActionsSheet extends StatelessWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const PetActionsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pet Care Guide',
            style: AppTheme.titleStyle,
          ),
          const SizedBox(height: 20),
          _buildGuideItem(
            icon: Icons.restaurant,
            title: 'Feeding',
            description:
                'Feed your pet regularly to maintain their energy and happiness.',
          ),
          const SizedBox(height: 16),
          _buildGuideItem(
            icon: Icons.sports_esports,
            title: 'Playing',
            description:
                'Play with your pet to increase their happiness and bond with them.',
          ),
          const SizedBox(height: 16),
          _buildGuideItem(
            icon: Icons.cleaning_services,
            title: 'Cleaning',
            description: 'Keep your pet clean and healthy by regular grooming.',
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () => completer?.call(SheetResponse(confirmed: true)),
              child: const Text('Got it!'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.titleStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTheme.bodyStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
