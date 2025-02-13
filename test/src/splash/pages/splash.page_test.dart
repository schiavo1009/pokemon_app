import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Certifique-se de importar o pacote flutter_svg
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/src/core/constants/assets_system.dart';
import 'package:pokemon_app/src/core/constants/constants.dart';
import 'package:pokemon_app/src/splash/splash.controller.dart';
import 'package:pokemon_app/src/splash/splash.page.dart'; 


class SplashControllerMock extends Mock implements SplashController {}

void main() {
  late SplashController controller;
  setUpAll(() {
  controller = SplashControllerMock();
  });

Widget makeTestable(Widget widget) => MaterialApp(home: widget);

  testWidgets('Should verify with elements were rendered', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestable(SplashPage(controller: controller,)));
    
    final Finder svgAssetFinder = find.byType(SvgPicture);
    final SvgPicture svgWidget = tester.widget(svgAssetFinder);
    expect(svgAssetFinder, findsOneWidget);
    expect((svgWidget.pictureProvider as ExactAssetPicture).assetName,
        AssetsSystem.logo);


    final Finder textFinder = find.byType(Text);
    final Text textWidget = tester.widget(textFinder);
    expect(textFinder, findsOneWidget);
    expect(textWidget.data, Constants.appLabel);
  });
}
