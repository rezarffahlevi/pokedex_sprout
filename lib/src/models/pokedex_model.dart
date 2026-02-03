import 'package:pokedex_sprout/src/utils/utils.dart';

class PokedexModel {
  final int? id;
  final String? name;
  final String? image;
  final List<String>? types;
  final int? height;
  final int? weight;
  final int? hp;
  final int? attack;
  final int? defense;
  final int? spAttack;
  final int? spDefense;
  final int? speed;
  final String? abilities;
  final String? species;

  final Map<String, dynamic>? raw;

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
      raw: json['raw_json'] != null ? json : null,
    );
  }
}
