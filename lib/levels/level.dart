import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/actors/player.dart';

class Level extends World {
  final int currentLevelIndex;
  final Player player;
  late TiledComponent level;

  Level(
      {super.children,
      required this.currentLevelIndex,
      super.priority,
      required this.player});

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
        'LEVEL_0${currentLevelIndex}.tmx', Vector2.all(16));
    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('spawnPoints');

    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
          break;
        default:
      }
    }
    return super.onLoad();
  }
}
