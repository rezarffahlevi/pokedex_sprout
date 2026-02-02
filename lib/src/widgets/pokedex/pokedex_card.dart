import 'package:flutter/material.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/themes/my_asset.dart';
import 'package:pokedex_sprout/src/themes/my_color.dart';
import 'package:pokedex_sprout/src/themes/my_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_sprout/src/utils/utils.dart';
import 'package:pokedex_sprout/src/widgets/pokedex/pokedex_type.dart';

class PokedexCard extends StatelessWidget {
  static const double _pokeballFraction = 0.75;
  static const double _pokedexFraction = 0.76;

  final PokedexModel pokedex;
  final void Function()? onPress;

  const PokedexCard(this.pokedex, {super.key, this.onPress});
  @override
  Widget build(BuildContext context) {
    Color color = PokedexTypes.parse(pokedex.primaryType ?? '').color;
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;

        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: color,
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildPokeballDecoration(height: itemHeight + 80),
                    _buildPokemon(height: itemHeight),
                    _buildPokemonNumber(),
                    _CardContent(pokedex),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPokeballDecoration({required double height}) {
    final pokeballSize = height * _pokeballFraction;

    return Positioned(
      bottom: -height * 0.13,
      right: -height * 0.13,
      child: Image(
        image: AssetImage(MyAsset.background),
        width: pokeballSize,
        height: pokeballSize,
        color: Colors.white.withValues(alpha: 0.14),
      ),
    );
  }

  Widget _buildPokemon({required double height}) {
    final pokedexSize = height * _pokedexFraction;

    return Positioned(
      bottom: -2,
      right: 2,
      child: CachedNetworkImage(
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokedex.id}.png',
        width: pokedexSize,
        height: pokedexSize,
      ),
    );
  }

  Widget _buildPokemonNumber() {
    return Positioned(
      top: 10,
      right: 14,
      child: Text(
        '#${pokedex.id}',
        style: MyTextStyle.h7.bold.withColor(MyColor.white).withOpacity(0.5),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final PokedexModel pokedex;

  const _CardContent(this.pokedex);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Hero(
              tag: '${pokedex.id}${pokedex.name}',
              child: Text(
                '${pokedex.name?.capitalize()}',
                style: MyTextStyle.h6.bold.withColor(Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ..._buildTypes(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTypes(BuildContext context) {
    List types = [pokedex.primaryType];
    if (pokedex.secondaryType != null) {
      types.add(pokedex.secondaryType);
    }

    return types
        .map(
          (type) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: PokedexType(PokedexTypes.parse(type ?? '')),
          ),
        )
        .toList();
  }
}
