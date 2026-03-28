import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class FmSkeleton extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const FmSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppRadius.lg,
  });

  @override
  State<FmSkeleton> createState() => _FmSkeletonState();
}

class _FmSkeletonState extends State<FmSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Color.lerp(
              AppColors.cream100,
              AppColors.cream300,
              _animation.value,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        );
      },
    );
  }
}
