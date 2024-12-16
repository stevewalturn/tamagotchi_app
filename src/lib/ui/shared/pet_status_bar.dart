import 'package:flutter/material.dart';
import 'package:tamagotchi_app/ui/themes/app_theme.dart';

class PetStatusBar extends StatelessWidget {
  final String label;
  final double value;
  final String type;

  const PetStatusBar({
    Key? key,
    required this.label,
    required this.value,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.captionStyle,
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              AppTheme.getStatusColor(type),
            ),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${value.toInt()}%',
          style: AppTheme.captionStyle,
        ),
      ],
    );
  }
}
