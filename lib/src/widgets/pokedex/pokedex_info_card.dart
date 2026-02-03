import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/themes/my_color.dart';
import 'package:pokedex_sprout/src/themes/my_text_style.dart';
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final safeArea = MediaQuery.paddingOf(context);
    final appBarHeight = AppBar().preferredSize.height;

    final cardMinHeight = screenHeight * PokedexInfoCard.minCardHeightFraction;
    final cardMaxHeight = screenHeight - appBarHeight - safeArea.top;
    bool isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      // AutoSlideUpPanel(
      //   minHeight: cardMinHeight,
      //   maxHeight: cardMaxHeight,
      //   onPanelSlide: (position) => slideController.value = position,
      constraints: BoxConstraints(
        minHeight: cardMinHeight,
        maxHeight: isPotrait ? 1.sh : 2.sh,
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
                  _labelAbout('Species', pokedex.species ?? ''),
                  MySizedBox.extraSmallVertical(),
                  _labelAbout('Height', pokedex.height.toString() ?? ''),
                  MySizedBox.extraSmallVertical(),
                  _labelAbout('Weight', pokedex.weight.toString() ?? ''),
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
                  _labelStats('HP', pokedex.hp.toString() ?? ''),
                  MySizedBox.extraSmallVertical(),
                  _labelStats('Attack', pokedex.attack.toString() ?? ''),
                  MySizedBox.extraSmallVertical(),
                  _labelStats('Defense', pokedex.defense.toString() ?? ''),
                  MySizedBox.extraSmallVertical(),
                  _labelStats('Sp. Attack', pokedex.spAttack.toString() ?? ''),
                  MySizedBox.extraSmallVertical(),
                  _labelStats(
                    'Sp. Defense',
                    pokedex.spDefense.toString() ?? '',
                  ),
                ],
              ),
            ),
          ),
          MainTabData(label: 'Evolution', child: Container()),
          MainTabData(label: 'Moves', child: Container()),
        ],
      ),
    );
  }

  _labelAbout(String label, String value) {
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

  _labelStats(String label, String value) {
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
