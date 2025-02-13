import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/src/core/config/shared_config.dart';
import 'package:pokemon_app/src/core/constants/colors_system.dart';
import 'package:pokemon_app/src/core/constants/icon_size.enum.dart';
import 'package:pokemon_app/src/core/constants/layout_space.enum.dart';
import 'package:pokemon_app/src/core/shared/utils/string.extension.dart';
import 'package:pokemon_app/src/core/shared/widgets/item_not_founded.widget.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/core/shared/widgets/loading.widget.dart';
import 'package:pokemon_app/src/core/shared/widgets/retry.widget.dart';
import 'package:pokemon_app/src/core/shared/utils/state_page.dart';
import 'package:pokemon_app/src/modules/pokemon/presentation/controllers/pokemon_detail.controller.dart';
import 'package:pokemon_app/src/modules/pokemon/utils/info_item.widget.dart';
import 'package:pokemon_app/src/modules/pokemon/utils/pokemon_constants.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key, required this.controller, this.id});
  final IPokemonDetailController controller;
  final String? id;
  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late IPokemonDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller.getPokemonDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsSystem.neutralWhite,
      appBar: AppBar(
        backgroundColor: ColorsSystem.neutralWhite,
      ),
      body: SafeArea(
        child: StreamBuilder<StatePage<PokemonEntity>>(
            stream: controller.state.stream,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data is StateLoading) {
                return LoadingWidget();
              }
              if (snapshot.data is StateEmpty) {
                return ItemNotFoundedWidget();
              }
              if (snapshot.data is StateSuccess) {
                final pokemonState =
                    (snapshot.data as StateSuccess<PokemonEntity>).data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListView(
                    children: [
                      Center(
                        child: SizedBox(
                          width: IconSize.xxl.size,
                          height: IconSize.xxl.size,
                          child: CachedNetworkImage(
                              imageUrl: SharedConfigs.instance.endpoints
                                  .getImagePath((pokemonState.id)),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                      decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                        ),
                      ),
                      SizedBox(
                        height: LayoutSpace.s.size,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                            color: pokemonState
                                .types?.first.type?.pokemonTypeEnum.color,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: LayoutSpace.s.size,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            (pokemonState.types?.first.type?.name ?? '')
                                .capitalize(),
                            style: TextStyle(
                                color: ColorsSystem.neutralWhite,
                                fontWeight: FontWeight.w800),
                          )),
                      SizedBox(
                        height: LayoutSpace.s.size,
                      ),
                      InfoItemWidget(
                        label: '${PokemonConstants.number}:',
                        description: '#${pokemonState.id}',
                      ),
                      InfoItemWidget(
                        label: '${PokemonConstants.name}:',
                        description: pokemonState.name,
                      ),
                      InfoItemWidget(
                        label: '${PokemonConstants.weight}:',
                        description: '${(pokemonState.weight ?? 0) / 10} kg',
                      ),
                      InfoItemWidget(
                        label: '${PokemonConstants.height}:',
                        description: '${(pokemonState.height ?? 0) / 10} m',
                      ),
                      ...(pokemonState.stats ?? []).map((item) {
                        return InfoItemWidget(
                          label:
                              '${(item.stat.statEnum?.name ?? '').capitalize()}:',
                          description: item.baseStat.toString(),
                        );
                      }),
                      SizedBox(
                        height: LayoutSpace.m.size,
                      ),
                    ],
                  ),
                );
              }
              return RetryWidget(
                onPressed: () {
                  controller.getPokemonDetail(widget.id);
                },
              );
            }),
      ),
    );
  }
}
