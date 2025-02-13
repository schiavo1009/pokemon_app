import 'package:flutter/material.dart';
import 'package:pokemon_app/src/core/constants/colors_system.dart';
import 'package:pokemon_app/src/core/constants/font_size.enum.dart';
import 'package:pokemon_app/src/core/constants/layout_space.enum.dart';
import 'package:pokemon_app/src/core/shared/utils/string.extension.dart';

class InfoItemWidget extends StatelessWidget {
  final String label;
  final String description;
  const InfoItemWidget({
    super.key,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(bottom: LayoutSpace.s.size),
                  decoration: BoxDecoration(
                    color: ColorsSystem.colorShadow,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: LayoutSpace.s.size,
                    horizontal: LayoutSpace.s.size,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label.capitalize(),
                        style: TextStyle(
                            color: ColorsSystem.fontMiddleGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize.s.size),
                      ),
                      // SizedBox(
                      //   height: LayoutSpace.xxs.size,
                      // ),
                      Expanded(child: Container()),
                      Text(
                        description.capitalize(),
                        style: TextStyle(
                          color: ColorsSystem.fontNeutralGrey,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  )))
        ]);
  }
}
