import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex_sprout/src/repositories/meta_repo_local.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_api.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_local.dart';
import 'package:sqflite/sqflite.dart';

class PokedexBootstrap {
  final PokedexRepoApi remote;
  final PokedexRepoLocal local;
  final MetaRepoLocal metaRepoLocal;
  static int dataLength = 1;
  static int process = 0;

  PokedexBootstrap({
    required this.remote,
    required this.local,
    required this.metaRepoLocal,
  });
  Future<void> start() async {
    final lastIdStr = await metaRepoLocal.get('last_pokemon_id');
    int startId = int.tryParse(lastIdStr ?? '0') ?? 0;

    final list = await remote.getAllIds();
    dataLength = list.length;

    for (int i = startId; i < list.length; i++) {
      try {
        final pokemon = await remote.getDetail(list[i]);
        await local.upsert(pokemon);

        await metaRepoLocal.set('last_pokemon_id', list[i].toString());
        process = i;
        log('save pokemon $i/${list.length}');
        if (i % 10 == 1) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      } catch (e) {
        log('error $e');
      }
    }

    await metaRepoLocal.set('bootstrap_done', 'true');
  }
}

class AppLifecycleHandler extends WidgetsBindingObserver {
  final PokedexBootstrap bootstrap;

  AppLifecycleHandler(this.bootstrap);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      bootstrap.start();
    }
  }
}
