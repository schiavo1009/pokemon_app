import 'package:flutter/material.dart';
import 'package:pokemon_app/src/core/constants/colors_system.dart';
import 'package:pokemon_app/src/core/constants/font_size.enum.dart';

class RetryWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const RetryWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Sorry! An error occurred',
            style: TextStyle(
              fontSize: FontSize.s.size,
            )),
        SizedBox(height: 24),
        ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: ColorsSystem.neutralWhite,
              backgroundColor: ColorsSystem.primary,
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text('Try Again'))
      ],
    ));
  }
}
