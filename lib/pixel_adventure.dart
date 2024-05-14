import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame {
  @override
  Color backgroundColor() => Colors.red;

  late final CameraComponent cam;
  final world = Level();
  @override
  FutureOr<void> onLoad() {
    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([world, cam]);
    return super.onLoad();
  }
}
