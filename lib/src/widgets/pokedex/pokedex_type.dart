import 'package:flutter/material.dart';
import 'package:pokedex_sprout/src/themes/my_color.dart';
import 'package:pokedex_sprout/src/themes/my_text_style.dart';

class PokedexType extends StatelessWidget {
  const PokedexType(this.type, {super.key, this.extra = ''});

  final PokedexTypes type;
  final String extra;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: (MyColor.white).withValues(alpha: 0.3),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              type.displayName,
              textScaler: TextScaler.noScaling,
              style: MyTextStyle.h8.semiBold.withColor(Colors.white),
            ),
            const SizedBox(width: 5),
            Text(
              extra,
              textScaler: TextScaler.noScaling,
              style: MyTextStyle.h8.semiBold.withColor(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

enum PokedexTypes {
  grass('Grass', MyColor.lightTeal),
  poison('Poison', MyColor.lightPurple),
  fire('Fire', MyColor.lightRed),
  flying('Flying', MyColor.lilac),
  water('Water', MyColor.lightBlue),
  bug('Bug', MyColor.lightTeal),
  normal('Normal', MyColor.beige),
  electric('Electric', MyColor.lightYellow),
  ground('Ground', MyColor.darkBrown),
  fairy('Fairy', MyColor.pink),
  fighting('Fighting', MyColor.red),
  psychic('Psychic', MyColor.lightPink),
  rock('Rock', MyColor.lightBrown),
  steel('Steel', MyColor.grey),
  ice('Ice', MyColor.lightCyan),
  ghost('Ghost', MyColor.purple),
  dragon('Dragon', MyColor.violet),
  dark('Dark', MyColor.black),
  monster('Monster', MyColor.lightBlue),
  unknown('Unknown', MyColor.lightBlue);

  final String displayName;
  final Color color;

  const PokedexTypes(this.displayName, this.color);

  static PokedexTypes parse(String rawValue) => values.firstWhere(
    (e) => e.name == rawValue.toLowerCase(),
    orElse: () => unknown,
  );
}
