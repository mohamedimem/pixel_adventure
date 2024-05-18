import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/raw_keyboard.dart';

enum PlayerState { idle, run, jump, attack, die }

enum PlayerDirection { left, right, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef, KeyboardHandler {
  String character;
  Player({this.character = "Ninja Frog", position}) : super(position: position);
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation fallAnimation;
  late final SpriteAnimation doubleJumpAnimation;
  late final SpriteAnimation jumpAnimation;
  late final SpriteAnimation wallJumpAnimation;

  final double stepTime = 0.05;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  PlayerDirection playerDirection = PlayerDirection.none;
  bool isFacingRight = true;
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
  }

  void _loadAllAnimation() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);
    hitAnimation = _spriteAnimation('Hit', 7);
    jumpAnimation = _spriteAnimation('Jump', 1);
    doubleJumpAnimation = _spriteAnimation('Double Jump', 5);
    wallJumpAnimation = _spriteAnimation('Wall Jump', 6);
    fallAnimation = _spriteAnimation('Fall', 1);

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.run: runningAnimation,
    };
    current = PlayerState.run;
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
            keysPressed.contains(LogicalKeyboardKey.keyA);
    final isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
            keysPressed.contains(LogicalKeyboardKey.keyD);
    if (isLeftKeyPressed && isRightKeyPressed) {
      playerDirection = PlayerDirection.none;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else {
      playerDirection = PlayerDirection.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  SpriteAnimation _spriteAnimation(String characterState, int amount) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache(
            'Main Characters/$character/' + characterState + ' (32x32).png'),
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
        ));
  }

  _updatePlayerMovement(double dt) {
    double dirX = 0.0;
    print(playerDirection);
    switch (playerDirection) {
      case PlayerDirection.left:
        if (isFacingRight) {
          isFacingRight = false;
          flipHorizontallyAroundCenter();
        }
        current = PlayerState.run;
        dirX -= moveSpeed;

        break;
      case PlayerDirection.right:
        if (!isFacingRight) {
          isFacingRight = true;
          flipHorizontallyAroundCenter();
        }
        current = PlayerState.run;

        dirX += moveSpeed;
        break;
      case PlayerDirection.none:
        current = PlayerState.idle;

        break;
    }
    velocity.x = dirX;
    position += velocity * dt;
  }
}
