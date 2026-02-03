import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_bloc.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_state.dart';
import 'package:pokedex_sprout/src/themes/my_asset.dart';
import 'package:pokedex_sprout/src/ui/pokedex_list_screen.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController pinController = TextEditingController();
  SplashBloc get bloc => context.read<SplashBloc>();

  @override
  void initState() {
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SplashBloc, SplashState>(
        listenWhen: (previous, current) => current.data != previous.data,
        listener: (context, state) async {
          if (state.data.status.isLoaded) {
            return GoRouter.of(context).replace(PokedexListScreen.routeName);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(MyAsset.logo, width: 160.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
