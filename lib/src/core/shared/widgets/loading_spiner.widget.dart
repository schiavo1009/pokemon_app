import 'package:flutter/material.dart';

import 'package:pokemon_app/src/core/constants/colors_system.dart';
import 'package:pokemon_app/src/core/constants/layout_space.enum.dart';

class LoadingSpinnerWidget extends StatelessWidget {
  const LoadingSpinnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: LayoutSpace.xxs.size),
      child: CircularProgressIndicator(
        color: ColorsSystem.primary,
      ),
    );
  }
}
