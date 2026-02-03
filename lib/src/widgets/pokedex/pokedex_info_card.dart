import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_detail/pokedex_detail_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_detail/pokedex_detail_state.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/themes/my_color.dart';
import 'package:pokedex_sprout/src/themes/my_text_style.dart';
import 'package:pokedex_sprout/src/utils/utils.dart';
import 'package:pokedex_sprout/src/widgets/general/main_tab_view.dart';
import 'package:pokedex_sprout/src/widgets/general/my_sized_box.dart';

class PokedexInfoCard extends StatefulWidget {
  static const double minCardHeightFraction = 0.54;
  final PokedexModel pokedex;

  PokedexInfoCard({required this.pokedex});

  @override
  State<PokedexInfoCard> createState() => _PokedexInfoCardState();
}

class _PokedexInfoCardState extends State<PokedexInfoCard>
    with TickerProviderStateMixin {
  AnimationController get slideController => AnimationController(vsync: this);
  PokedexModel get pokedex => widget.pokedex;

  List<MoveItem> parseMoves(List moves) {
    return moves
        .map((e) {
          final levelUp = e['version_group_details'].firstWhere(
            (v) => v['move_learn_method']['name'] == 'level-up',
            orElse: () => null,
          );

          if (levelUp == null) return null;

          return MoveItem(
            name: e['move']['name'],
            level: levelUp['level_learned_at'],
          );
        })
        .whereType<MoveItem>()
        .toList()
      ..sort((a, b) => a.level.compareTo(b.level));
  }

  @override
  Widget build(BuildContext context) {
    final cardMinHeight = 1.sh * PokedexInfoCard.minCardHeightFraction;
    bool isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      constraints: BoxConstraints(
        minHeight: cardMinHeight,
        maxHeight: isPotrait ? 1.sh : 4.sh,
      ),
      child: MainTabView(
        paddingAnimation: slideController,
        tabs: [
          MainTabData(
            label: 'About',
            child: Padding(
              padding: EdgeInsetsGeometry.all(16.w),
              child: Column(
                children: [
                  BlocBuilder<PokedexDetailBloc, PokedexDetailState>(
                    builder: (context, state) {
                      return _labelAbout(
                        'Species',
                        state.pokedex.data?.species ?? '',
                      );
                    },
                  ),
                  MySizedBox.extraSmallVertical(),
                  _labelAbout(
                    'Height',
                    Utils.formatHeightPokedex(pokedex.height),
                  ),
                  MySizedBox.extraSmallVertical(),
                  _labelAbout(
                    'Weight',
                    Utils.formatWeightPokedex(pokedex.weight),
                  ),
                  MySizedBox.extraSmallVertical(),
                  _labelAbout('Abilities', pokedex.abilities ?? ''),
                ],
              ),
            ),
          ),
          MainTabData(
            label: 'Base Stats',
            child: Padding(
              padding: EdgeInsetsGeometry.all(16.w),
              child: Column(
                children: [
                  _labelStats('HP', pokedex.hp.toString()),
                  MySizedBox.extraSmallVertical(),
                  _labelStats('Attack', pokedex.attack.toString()),
                  MySizedBox.extraSmallVertical(),
                  _labelStats('Defense', pokedex.defense.toString()),
                  MySizedBox.extraSmallVertical(),
                  _labelStats('Sp. Attack', pokedex.spAttack.toString()),
                  MySizedBox.extraSmallVertical(),
                  _labelStats('Sp. Defense', pokedex.spDefense.toString()),
                ],
              ),
            ),
          ),
          MainTabData(label: 'Evolution', child: Container()),
          MainTabData(
            label: 'Moves',
            child: Padding(
              padding: EdgeInsetsGeometry.all(16.w),
              child: Column(
                children: parseMoves(pokedex.raw?['moves']).map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _labelAbout('Lv. ${e.level}', e.name),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _labelAbout(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            label,
            style: MyTextStyle.h5.regular.withColor(Colors.black38),
          ),
        ),
        Text(value, style: MyTextStyle.h5.semiBold),
      ],
    );
  }

  Widget _labelStats(String label, String value) {
    double val = double.tryParse(value) ?? 0;
    final progress = val / 100;
    Color color = val > 50 ? MyColor.lightTeal : MyColor.lightRed;

    return Row(
      children: [
        SizedBox(
          width: 110.w,
          child: Text(
            label,
            style: MyTextStyle.h5.regular.withColor(Colors.black38),
          ),
        ),
        SizedBox(
          width: 40.w,
          child: Text(value, style: MyTextStyle.h5.semiBold),
        ),
        Expanded(
          child: Container(
            height: 4,
            width: 1.sw,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
