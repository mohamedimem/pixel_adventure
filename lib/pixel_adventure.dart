import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/actors/player.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame {
  @override
  Color backgroundColor() => Colors.red;

  late final CameraComponent cam;
  final world = Level();
  final playerFrog = Player(character: 'Ninja Frog');
  @override
  FutureOr<void> onLoad() async {
    //load all image in cache
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([world, cam, playerFrog]);
    return super.onLoad();
  }
}
