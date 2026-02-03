import 'package:pokedex_sprout/src/utils/utils.dart';

class PokedexModel {
  int? id;
  String? name;
  String? image;
  List<String>? types;
  int? height;
  int? weight;
  int? hp;
  int? attack;
  int? defense;
  int? spAttack;
  int? spDefense;
  int? speed;
  String? abilities;
  String? species;

  Map<String, dynamic>? raw;

  PokedexModel({
    this.id,
    this.name,
    this.image,
    this.types,
    this.height,
    this.weight,
    this.hp,
    this.attack,
    this.defense,
    this.spAttack,
    this.spDefense,
    this.speed,
    this.abilities,
    this.species,
    this.raw,
  });
  factory PokedexModel.fromMap(Map<String, dynamic> json) {
    int stat(String name) =>
        json['stats'].firstWhere((e) => e['stat']['name'] == name)['base_stat'];
    return PokedexModel(
      id: json['id'] ?? json['url'],
      name: json['name'].toString().capitalize(),
      image: json['sprites']['other']['official-artwork']['front_default'],
      types: (json['types'] as List)
          .map((e) => e['type']['name'].toString().capitalize())
          .toList(),
      height: json['height'],
      weight: json['weight'],
      hp: stat('hp'),
      attack: stat('attack'),
      defense: stat('defense'),
      spAttack: stat('special-attack'),
      spDefense: stat('special-defense'),
      speed: stat('speed'),
      abilities: (json['abilities'] as List)
          .map((e) => e['ability']['name'].toString().capitalize())
          .join(', '),
      species: json['species']['name'].toString().capitalize(),
      raw: json,
    );
  }
}

class MoveItem {
  final String name;
  final int level;

  MoveItem({required this.name, required this.level});
}
