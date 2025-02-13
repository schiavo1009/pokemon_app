import 'package:flutter/material.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/core/shared/widgets/empty.widget.dart';
import 'package:pokemon_app/src/core/shared/widgets/loading.widget.dart';
import 'package:pokemon_app/src/core/shared/widgets/retry.widget.dart';
import 'package:pokemon_app/src/core/shared/utils/state_page.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/controllers/favorite_pokemons.controller.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/widgets/pokemon_grid.widget.dart';

class FavoritePokemonsPage extends StatefulWidget {
  const FavoritePokemonsPage({super.key, required this.controller});
  final IFavoritePokemonsController controller;
  @override
  State<FavoritePokemonsPage> createState() => _FavoritePokemonsPageState();
}

class _FavoritePokemonsPageState extends State<FavoritePokemonsPage> {
  late IFavoritePokemonsController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller.getFavoritePokemons();
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
                    controller.removeFavoritePokemon(id: id);
                  },
                  onPressCard: (index) {
                    controller.goToPokemonDetail(index);
                  },
                  pokemons: pokemonsState.data!,
                )),
              ],
            );
          }
          return RetryWidget(
            onPressed: () => controller.getFavoritePokemons(),
          );
        });
  }
}
