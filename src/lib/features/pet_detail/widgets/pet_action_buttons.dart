import 'package:flutter/material.dart';
import 'package:tamagotchi_app/ui/themes/app_theme.dart';

class PetActionButtons extends StatelessWidget {
  final VoidCallback onFeed;
  final VoidCallback onPlay;
  final VoidCallback onClean;
  final bool isBusy;

  const PetActionButtons({
    Key? key,
    required this.onFeed,
    required this.onPlay,
    required this.onClean,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ActionButton(
          icon: Icons.restaurant,
          label: 'Feed',
          onPressed: isBusy ? null : onFeed,
          color: AppTheme.petStatusColors['hunger']!,
        ),
        _ActionButton(
          icon: Icons.sports_esports,
          label: 'Play',
          onPressed: isBusy ? null : onPlay,
          color: AppTheme.petStatusColors['happiness']!,
        ),
        _ActionButton(
          icon: Icons.cleaning_services,
          label: 'Clean',
          onPressed: isBusy ? null : onClean,
          color: AppTheme.petStatusColors['cleanliness']!,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final Color color;

  const _ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          child: Icon(
            icon,
            size: 32,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTheme.captionStyle,
        ),
      ],
    );
  }
}
