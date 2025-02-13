import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/src/core/constants/colors_system.dart';
import 'package:pokemon_app/src/core/constants/icon_size.enum.dart';
import 'package:pokemon_app/src/core/constants/layout_space.enum.dart';
import 'package:pokemon_app/src/core/shared/utils/string.extension.dart';

class PokemonItem extends StatelessWidget {
  final int index;
  final String urlImage;
  final String name;
  final bool? isFavorite;
  final Function(int index) onPressFavorite;
  final Function(int index) onPressCard;
  const PokemonItem({
    super.key,
    required this.index,
    required this.urlImage,
    required this.name,
    this.isFavorite,
    required this.onPressFavorite,
    required this.onPressCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressCard(index);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsSystem.neutralWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(LayoutSpace.s.size),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    color: ColorsSystem.neutralWhite,
                    margin: EdgeInsets.symmetric(vertical: LayoutSpace.s.size),
                    child: SizedBox(
                      width: IconSize.xl.size,
                      height: IconSize.xl.size,
                      child: CachedNetworkImage(
                        imageUrl: urlImage,
                        imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        )),
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                              height: IconSize.s.size,
                              width: IconSize.s.size,
                              child: CircularProgressIndicator(
                                color: ColorsSystem.primary,
                              )),
                        ),
                      ),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        top: LayoutSpace.xs.size, bottom: LayoutSpace.xxs.size),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(LayoutSpace.s.size),
                          bottomRight: Radius.circular(LayoutSpace.s.size)),
                    ),
                    child: Text(
                      name.capitalize(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: ColorsSystem.fontMiddleGrey,
                      ),
                    )),
                Expanded(child: Container())
              ],
            ),
          ),
          Positioned(
            top: LayoutSpace.xxs.size,
            left: LayoutSpace.xs.size,
            child: Text(
              '#$index',
              style: TextStyle(
                color: ColorsSystem.fontNeutralGrey,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (isFavorite != null)
            Positioned(
              top: LayoutSpace.xxs.size,
              right: LayoutSpace.xs.size,
              child: GestureDetector(
                onTap: () {
                  onPressFavorite(index);
                },
                child: Icon(
                  isFavorite! ? Icons.favorite : Icons.favorite_border,
                  color: ColorsSystem.secondary,
                  size: IconSize.xs.size,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
