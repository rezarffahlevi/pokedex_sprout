import 'package:flutter/material.dart';
import 'package:pokedex_sprout/src/themes/my_color.dart';
import 'package:pokedex_sprout/src/themes/my_text_style.dart';

class MainTabData {
  final Widget child;
  final String label;

  const MainTabData({required this.label, required this.child});
}

class MainTabView extends StatelessWidget {
  final List<MainTabData> tabs;
  final Animation<double>? paddingAnimation;

  const MainTabView({super.key, required this.tabs, this.paddingAnimation});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: MyColor.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTopAnimatedPadding(),
            _buildTabBar(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAnimatedPadding() {
    if (paddingAnimation == null) {
      return const SizedBox(height: 6);
    }

    return AnimatedBuilder(
      animation: paddingAnimation!,
      builder: (context, _) =>
          SizedBox(height: (1 - paddingAnimation!.value) * 16 + 6),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      labelPadding: const EdgeInsets.symmetric(vertical: 16),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorColor: MyColor.indigo,
      tabs: tabs.map((tab) => Text(tab.label, style: MyTextStyle.h6.bold,)).toList(),
    );
  }

  Widget _buildTabContent() {
    return Expanded(
      child: TabBarView(children: tabs.map((tab) => tab.child).toList()),
    );
  }
}
