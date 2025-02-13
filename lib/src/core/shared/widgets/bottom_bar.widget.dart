import 'package:flutter/material.dart';
import 'package:pokemon_app/src/core/constants/colors_system.dart';
import 'package:pokemon_app/src/core/constants/font_size.enum.dart';
import 'package:pokemon_app/src/core/constants/icon_size.enum.dart';
import 'package:pokemon_app/src/core/constants/layout_space.enum.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget(
      {super.key,
      required this.itens,
      required this.indexSelect,
      required this.onPressItem});
  final List<({String label, IconData icon})>  itens;
  final int indexSelect;
  final void Function(int) onPressItem;

  @override
  Widget build(BuildContext context) {
    int? index;
    return  Container(
        padding:  EdgeInsets.only(top: LayoutSpace.xs.size, bottom: LayoutSpace.s.size, left: LayoutSpace.xs.size, right: LayoutSpace.xs.size),
        decoration: BoxDecoration(
           color: Colors.white,
         border: Border(
           top: BorderSide(
             color: ColorsSystem.backgroundColor,
             width: 1,
           ),
         ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: itens.map((item) {
            if (index == null) {
              index = 0;
            } else {
              index = index! + 1;
            }
            final indexLocal = index;
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => onPressItem(indexLocal!),
                    child: Icon(item.icon,
                        size: IconSize.m.size,
                        color: indexSelect == index
                            ? ColorsSystem.primary
                            : ColorsSystem.neutralGrey),
                  ),
                  Text(item.label,
                      style: TextStyle(
                          color: indexSelect == index
                              ? ColorsSystem.primary
                              : ColorsSystem.neutralGrey,
                          fontSize: FontSize.xxs.size)),
                ],
              ),
            );
          }).toList(),
        ),
    );
  }
}
