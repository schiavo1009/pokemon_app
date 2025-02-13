import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokemon_app/src/core/constants/assets_system.dart';

class AppBarSystem extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color textColor;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;

  const AppBarSystem({
    super.key,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.leadingIcon,
    this.onLeadingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: SvgPicture.asset(
        AssetsSystem.logo,
        height: 45,
      ),
      leading: Container(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
