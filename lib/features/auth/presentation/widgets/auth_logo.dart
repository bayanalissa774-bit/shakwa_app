import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  final double scale;
  final double screenWidth;

  const AuthLogo({super.key, required this.scale, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 44 * scale,
      left: (screenWidth - (269 * scale)) / 2,
      width: 269 * scale,
      height: 76 * scale,
      child: const Image(
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.contain,
      ),
    );
  }
}
