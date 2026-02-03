import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_detail/pokedex_detail_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_list/pokedex_list_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_list/pokedex_list_state.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_bloc.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_state.dart';
import 'package:pokedex_sprout/src/themes/my_asset.dart';
import 'package:pokedex_sprout/src/themes/my_color.dart';
import 'package:pokedex_sprout/src/themes/my_text_style.dart';
import 'package:pokedex_sprout/src/themes/my_theme.dart';
import 'package:pokedex_sprout/src/ui/pokedex_detail_screen.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';
import 'package:pokedex_sprout/src/widgets/general/my_loading.dart';
import 'package:pokedex_sprout/src/widgets/general/my_shimmer.dart';
import 'package:pokedex_sprout/src/widgets/pokedex/pokedex_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PokedexListScreen extends StatefulWidget {
  static const String routeName = '/pokedex-list';

  const PokedexListScreen({Key? key}) : super(key: key);

  @override
  State<PokedexListScreen> createState() => _PokedexListScreenState();
}

class _PokedexListScreenState extends State<PokedexListScreen> {
  PokedexListBloc get bloc => context.read<PokedexListBloc>();
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
            await bloc.getList(loadMore: true);
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 22.w),
            child: BlocConsumer<PokedexListBloc, PokedexListState>(
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
                    childAspectRatio: isPotrait ? 1.4 : 2.4,
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
                    final item = state.data.data?[index];
                    return MyShimmer(
                      show: item?.types != null,
                      child: PokedexCard(
                        state.data.data![index],
                        onPress: () {
                          context.push(
                            PokedexDetailScreen.routeName,
                            extra: item,
                          );
                        },
                      ),
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
