import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokemon_app/src/core/constants/assets_system.dart';
import 'package:pokemon_app/src/core/constants/colors_system.dart';
import 'package:pokemon_app/src/core/constants/constants.dart';
import 'package:pokemon_app/src/core/constants/font_size.enum.dart';
import 'package:pokemon_app/src/core/constants/layout_space.enum.dart';
import 'package:pokemon_app/src/splash/splash.controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.controller});
  final SplashController controller;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashController controller;
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller.goHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsSystem.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: (MediaQuery.of(context).size.width * 0.2)),
                child: SvgPicture.asset(
                  AssetsSystem.logo,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(LayoutSpace.xs.size),
                  decoration: BoxDecoration(
                    color: ColorsSystem.neutralWhite,
                    borderRadius: BorderRadius.circular(LayoutSpace.xxs.size),
                  ),
                  child: Text(
                    Constants.appLabel,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: FontSize.m.size),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
