import 'dart:developer';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_detail/pokedex_detail_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_detail/pokedex_detail_state.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_list/pokedex_list_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_list/pokedex_list_state.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_bloc.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_state.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/themes/my_asset.dart';
import 'package:pokedex_sprout/src/themes/my_color.dart';
import 'package:pokedex_sprout/src/themes/my_text_style.dart';
import 'package:pokedex_sprout/src/themes/my_theme.dart';
import 'package:pokedex_sprout/src/utils/utils.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';
import 'package:pokedex_sprout/src/widgets/general/my_loading.dart';
import 'package:pokedex_sprout/src/widgets/general/my_sized_box.dart';
import 'package:pokedex_sprout/src/widgets/pokedex/background_decoration.dart';
import 'package:pokedex_sprout/src/widgets/pokedex/pokedex_card.dart';
import 'package:pokedex_sprout/src/widgets/pokedex/pokedex_info_card.dart';
import 'package:pokedex_sprout/src/widgets/pokedex/pokedex_type.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PokedexDetailScreen extends StatefulWidget {
  static const String routeName = '/pokedex-detail';
  final PokedexModel pokedex;

  const PokedexDetailScreen({Key? key, required this.pokedex})
    : super(key: key);

  @override
  State<PokedexDetailScreen> createState() => _PokedexDetailScreenState();
}

class _PokedexDetailScreenState extends State<PokedexDetailScreen> {
  PokedexDetailBloc get bloc => context.read<PokedexDetailBloc>();
  final RefreshController _refreshController = RefreshController();
  PokedexModel get pokedex => widget.pokedex;

  final GlobalKey _currentTextKey = GlobalKey();
  final GlobalKey _targetTextKey = GlobalKey();
  double textDiffLeft = 0.0;
  double textDiffTop = 0.0;

  @override
  void initState() {
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    bool isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double pokeSize = isPotrait ? 200.w : 230.h;

    return SafeArea(
      top: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            BackgroundDecoration(pokedex: pokedex),
            SingleChildScrollView(
              child: Column(
                children: [
                  MySizedBox.bloodyLargeVertical(height: 90.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${pokedex.name?.capitalize()}',
                              style: MyTextStyle.h1.ultraBold.withColor(
                                Colors.white,
                              ),
                            ),
                            Row(children: _buildTypes(context)),
                          ],
                        ),
                        Text(
                          '#${pokedex.id}',
                          style: MyTextStyle.h2.bold
                              .withColor(MyColor.white)
                              .withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 130.h),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _buildAppBarPokeballDecoration(),
                      PokedexInfoCard(pokedex: pokedex),
                      Positioned(
                        top: -(pokeSize - 40.h),
                        left: 0,
                        right: 0,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokedex.id}.png',
                          width: pokeSize,
                          height: pokeSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 6.w,
              top: kToolbarHeight - 20.h,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Container(
                  height: 40.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(Icons.arrow_back_ios, size: 18.h)),
                ),
              ),
            ),
            // PokedexHiglight(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarPokeballDecoration() {
    final pokeSize = 300.w;
    bool isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Positioned(
      top: isPotrait ? -230 : -430,
      right: 0,
      child: IgnorePointer(
        ignoring: true,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(seconds: 20),
          onEnd: () {},
          builder: (_, value, child) {
            return Transform.rotate(angle: value * 2 * pi, child: child);
          },
          child: Image(
            image: AssetImage(MyAsset.background),
            width: pokeSize,
            height: pokeSize,
            color: Colors.white24,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTypes(BuildContext context) {
    return pokedex.types
            ?.map(
              (type) => Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6, left: 6),
                child: PokedexType(PokedexTypes.parse(type ?? '')),
              ),
            )
            .toList() ??
        [];
  }
}
