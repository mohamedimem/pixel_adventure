import 'dart:async';

import 'package:flame/components.dart';

enum PlayerState { idle, run, jump, attack, die }

class Player extends SpriteAnimationGroupComponent with HasGameRef {
  String character;
  Player({required this.character, position}) : super(position: position);
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation fallAnimation;
  late final SpriteAnimation doubleJumpAnimation;
  late final SpriteAnimation jumpAnimation;
  late final SpriteAnimation wallJumpAnimation;

  final double stepTime = 0.05;

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
}
