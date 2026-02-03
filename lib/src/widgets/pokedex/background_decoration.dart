import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/themes/my_asset.dart';
import 'package:pokedex_sprout/src/themes/my_color.dart';
import 'package:pokedex_sprout/src/widgets/pokedex/pokedex_type.dart';

class _BoxDecoration extends StatelessWidget {
  static const Size size = Size.square(144);

  const _BoxDecoration();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi * 5 / 12,
      alignment: Alignment.center,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: const Alignment(-0.2, -0.2),
            end: const Alignment(1.5, -0.3),
            colors: [
              Colors.white.withValues(alpha: 0.3),
              Colors.white.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundDecoration extends StatefulWidget {
  PokedexModel pokedex;
  BackgroundDecoration({required this.pokedex});

  @override
  State<BackgroundDecoration> createState() => BackgroundDecorationState();
}

class BackgroundDecorationState extends State<BackgroundDecoration> {
  PokedexModel get pokedex => widget.pokedex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        _buildBoxDecoration(),
      ],
    );
  }

  Widget _buildBackground() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: const BoxConstraints.expand(),
      color: PokedexTypes.parse(pokedex.types?.first).color,
    );
  }

  Widget _buildBoxDecoration() {
    return Positioned(
      top: -_BoxDecoration.size.height * 0.4,
      left: -_BoxDecoration.size.width * 0.4,
      child: const _BoxDecoration(),
    );
  }
}
