import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_utils/flame_tiled_utils.dart';
import 'package:pixel_adventure/components/collision_block.dart';
import 'package:pixel_adventure/components/player.dart';

class Level extends World {
  final int currentLevelIndex;
  final Player player;
  late TiledComponent level;
  List<CollisionBlock> collisionsBlock = [];

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
    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer!.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          default:
        }
      }
    }
    final collisionLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisionLayer != null) {
      for (final block in collisionLayer.objects) {
        switch (block.class_) {
          case 'Platform':
            final platform = CollisionBlock(
              position: Vector2(block.x, block.y),
              size: Vector2(block.width, block.height),
              isPlatform: true,
            );
            collisionsBlock.add(platform);
            add(platform);
            break;
          default:
        }
      }
    }

    player.collisionBlocks = collisionsBlock;

    return super.onLoad();
  }
}
