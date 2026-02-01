import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_bloc.dart';
import 'package:pokedex_sprout/src/injection.dart';
import 'package:pokedex_sprout/src/ui/pokedex_list_screen.dart';
import 'package:pokedex_sprout/src/ui/splash_screen.dart';

class Routes {
  static List<RouteBase> appRoutes() {
    return [
      GoRoute(
        path: SplashScreen.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: PokedexListScreen.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return PokedexListScreen();
        },
      ),
    ];
  }
}
