import 'package:flutter/material.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/core/shared/widgets/empty.widget.dart';
import 'package:pokemon_app/src/core/shared/widgets/loading.widget.dart';
import 'package:pokemon_app/src/core/shared/widgets/loading_spiner.widget.dart';
import 'package:pokemon_app/src/core/shared/widgets/retry.widget.dart';
import 'package:pokemon_app/src/core/shared/utils/state_page.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/controllers/pokemons.controller.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/widgets/pokemon_grid.widget.dart';

class PokemonsPage extends StatefulWidget {
  const PokemonsPage({super.key, required this.controller});
  final IPokemonsController controller;
  @override
  State<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  late IPokemonsController controller;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    controller = widget.controller;
    controller.getPokemons();
  }

  void _scrollListener() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double delta = 0.0;
    if ((maxScroll - currentScroll) == delta) {
      controller.getPokemons(getMoreItens: true);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StatePage<List<PokemonEntity>>>(
        stream: controller.state.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data is StateLoading) {
            return LoadingWidget();
          }
          if (snapshot.data is StateEmpty) {
            return EmptyWidget();
          }
          if (snapshot.data is StateSuccess) {
            final pokemonsState =
                (snapshot.data as StateSuccess<List<PokemonEntity>>);
            return Column(
              children: [
                Expanded(
                    child: PokemonGridWidget(
                  onPressFavoritePokemon: (id) {
                    controller.updateFavoritePokemon(id: id);
                  },
                  onPressCard: (index) {
                    controller.goToPokemonDetail(index);
                  },
                  pokemons: pokemonsState.data!,
                  scrollController: scrollController,
                )),
                if (pokemonsState.isLoadingMore) LoadingSpinnerWidget(),
              ],
            );
          }
          return RetryWidget(
            onPressed: () {
              controller.getPokemons();
            },
          );
        });
  }
}
