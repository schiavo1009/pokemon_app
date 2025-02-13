import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon_app/src/core/constants/assets_system.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(AssetsSystem.pikachuLottie, width: 130),
    );
  }
}
