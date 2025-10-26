import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  final Color? startColor;
  final Color? endColor;

  const BackgroundContainer({
    super.key,
    required this.child,
    this.startColor,
    this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            startColor ?? const Color(0xFFFFEBEE), // default soft red
            endColor ?? const Color(0xFFFDECEA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
