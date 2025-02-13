import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/src/core/shared/widgets/app_bar_system.dart';
import 'package:pokemon_app/src/core/shared/widgets/bottom_bar.widget.dart';
import 'package:pokemon_app/src/modules/home/utils/home_constants.dart';
import 'package:pokemon_app/src/modules/home/presentation/controllers/home_tab.controller.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/pages/favorite_pokemons.page.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/pages/pokemons.page.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key, required this.controller});
  final IHomeTabController controller;
  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  late IHomeTabController controller;

  final List<({String label, IconData icon, Widget page})> tabScreens = [
    (
      label: HomeConstants.pokemons,
      icon: Icons.list,
      page:  PokemonsPage(controller: GetIt.I.get()),
    ),
    (
      label: HomeConstants.favorites,
      icon: Icons.favorite,
      page: FavoritePokemonsPage(controller: GetIt.I.get()),
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: widget.controller.index,
        builder: (context, snapshot) {
          final index = snapshot.data ?? 0;
          final currentItem = tabScreens[index];
          return Scaffold(
            appBar: AppBarSystem(),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(child: currentItem.page),
                  BottomBarWidget(
                      itens: tabScreens.map((element) {
                        final ({String label, IconData icon}) item =
                            (label: element.label, icon: element.icon);
                        return item;
                      }).toList(),
                      indexSelect: index,
                      onPressItem: controller.updateSelectTab,
                    )
                ],
              ),
            ),
          );
        });
  }
}
