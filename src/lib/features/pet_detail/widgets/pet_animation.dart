import 'package:flutter/material.dart';
import 'package:tamagotchi_app/models/pet_stage.dart';

class PetAnimation extends StatefulWidget {
  final PetStageType stageType;
  final bool isHappy;

  const PetAnimation({
    Key? key,
    required this.stageType,
    this.isHappy = true,
  }) : super(key: key);

  @override
  State<PetAnimation> createState() => _PetAnimationState();
}

class _PetAnimationState extends State<PetAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_bounceAnimation.value),
          child: _getPetImage(),
        );
      },
    );
  }

  Widget _getPetImage() {
    String imagePath;
    double size;

    switch (widget.stageType) {
      case PetStageType.egg:
        imagePath = 'assets/images/egg.png';
        size = 100;
        break;
      case PetStageType.baby:
        imagePath = widget.isHappy
            ? 'assets/images/baby_happy.png'
            : 'assets/images/baby_sad.png';
        size = 120;
        break;
      case PetStageType.child:
        imagePath = widget.isHappy
            ? 'assets/images/child_happy.png'
            : 'assets/images/child_sad.png';
        size = 140;
        break;
      case PetStageType.teen:
        imagePath = widget.isHappy
            ? 'assets/images/teen_happy.png'
            : 'assets/images/teen_sad.png';
        size = 160;
        break;
      case PetStageType.adult:
        imagePath = widget.isHappy
            ? 'assets/images/adult_happy.png'
            : 'assets/images/adult_sad.png';
        size = 180;
        break;
    }

    return Image.asset(
      imagePath,
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: size,
          height: size,
          color: Colors.grey[300],
          child: const Icon(
            Icons.pets,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
