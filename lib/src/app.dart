import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_detail/pokedex_detail_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_list/pokedex_list_bloc.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_bloc.dart';
import 'package:pokedex_sprout/src/injection.dart';
import 'package:pokedex_sprout/src/routes.dart';
import 'package:pokedex_sprout/src/ui/splash_screen.dart';
import 'package:pokedex_sprout/src/utils/utils.dart';
import 'package:pokedex_sprout/src/widgets/general/my_error_widget.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => inject<SplashBloc>()),
        BlocProvider(create: (context) => inject<PokedexListBloc>()),
        BlocProvider(create: (context) => inject<PokedexDetailBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex Sprout',
        routerConfig: _router,
      ),
    );
  }
}

final _router = GoRouter(
  routes: Routes.appRoutes(),
  errorBuilder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: MyErrorWidget('GoRouter Error: ${state.error}'),
        ),
      ),
    );
  },
  navigatorKey: Utils.navigatorKey,
  initialLocation: SplashScreen.routeName,
);
