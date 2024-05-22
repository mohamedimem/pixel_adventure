import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Color backgroundColor() => Colors.red;
  late JoystickComponent joystick;

  late final CameraComponent cam;
  final Player playerFrog = Player();
  @override
  FutureOr<void> onLoad() async {
    //load all image in cache
    await images.loadAllImages();
    final world = Level(
      player: playerFrog,
      currentLevelIndex: 1,
    );

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([world, cam]);
    addJoyStick();
    return super.onLoad();
  }

  void addJoyStick() {
    joystick = JoystickComponent(
        position: Vector2(0, 0),
        margin: EdgeInsets.only(left: 32, bottom: 32),
        knob: SpriteComponent(
          sprite: Sprite(images.fromCache('HUD/Knob.png')),
        ),
        background: SpriteComponent(
          sprite: Sprite(images.fromCache('HUD/Joystick.png')),
        ));
    add(joystick);
  }

  @override
  void update(double dt) {
    _updateJoyStick();
    super.update(dt);
  }

  void _updateJoyStick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
        playerFrog.playerDirection = PlayerDirection.left;
        playerFrog.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
        playerFrog.playerDirection = PlayerDirection.right;
        playerFrog.horizontalMovement = 1;
        break;
      case JoystickDirection.up:
        break;
      case JoystickDirection.down:
        break;
      default:
        playerFrog.playerDirection = PlayerDirection.none;
        playerFrog.horizontalMovement = 0;
    }
  }
}
