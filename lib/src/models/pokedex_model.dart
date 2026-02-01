import 'dart:convert';
import 'dart:developer';

class PokedexModel {
  final int? id;
  final String? name;
  final String? image;
  final String? primaryType;
  final String? secondaryType;
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
    this.primaryType,
    this.secondaryType,
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
    return PokedexModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      primaryType: json['primary_type'],
      secondaryType: json['secondary_type'],
      height: json['height'],
      weight: json['weight'],
      hp: json['hp'],
      attack: json['attack'],
      defense: json['defense'],
      spAttack: json['sp_attack'],
      spDefense: json['sp_defense'],
      speed: json['speed'],
      abilities: json['abilities'],
      species: json['species'],
      raw: json['raw_json'] != null ? jsonDecode(json['raw_json']) : null,
    );
  }
}
