import 'dart:developer';

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
import 'package:pokedex_sprout/src/utils/view_data.dart';
import 'package:pokedex_sprout/src/widgets/general/my_loading.dart';
import 'package:pokedex_sprout/src/widgets/pokedex/pokedex_card.dart';
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

  @override
  void initState() {
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    bool isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(title: Text('Pokedex', style: MyTextStyle.h2.ultraBold)),
      body: SafeArea(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () async {
            bloc.init();
            await Future.delayed(Duration(seconds: 1));
            _refreshController.refreshCompleted();
          },
          onLoading: () async {
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 22.w),
            child: BlocConsumer<PokedexDetailBloc, PokedexDetailState>(
              listener: (context, state) {
                if (state.data.status.isError) {
                  _refreshController.refreshCompleted();
                  _refreshController.loadFailed();
                } else if (state.data.status.isLoaded) {
                  _refreshController.refreshCompleted();
                  _refreshController.loadComplete();
                } else if (state.data.status.isLoadNoData ||
                    state.data.status.isNoData) {
                  _refreshController.refreshCompleted();
                  _refreshController.loadNoData();
                }
              },
              builder: (context, state) {
                if (state.data.status.isInitial ||
                    state.data.status.isLoading) {
                  return MyLoading();
                }

                if (state.data.status.isNoData ||
                    (state.data.status.isLoaded &&
                        (state.data.data?.isEmpty ?? true))) {
                  return Center(child: Text('Tidak ada data'));
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: isPotrait ? 1.4 : 1.9,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.data.data?.length ?? 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.w,
                  ),
                  itemBuilder: (context, index) {
                    return PokedexCard(
                      state.data.data![index],
                      onPress: () {
                        context.push(
                          '/pokedex-detail',
                          extra: state.data.data![index],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
