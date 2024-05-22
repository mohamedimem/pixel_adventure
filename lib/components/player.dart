import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/raw_keyboard.dart';
import 'package:pixel_adventure/components/collision_block.dart';

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
  double horizontalMovement = 0.0;
  List<CollisionBlock> collisionBlocks = [];
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    debugMode = true;
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
    _updatePlayerState();
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
    horizontalMovement += isRightKeyPressed ? 1 : 0;
    horizontalMovement -= isLeftKeyPressed ? 1 : 0;

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
    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    // Check if moving, set running
    if (velocity.x > 0 || velocity.x < 0) playerState = PlayerState.run;

    current = playerState;
  }


  _checkHorizontalCollisions(){
    for (final block in collisionBlocks){
      
    }
  }
}
