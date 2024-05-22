import 'package:flame/components.dart';
import 'package:pixel_adventure/components/player.dart';

bool checkCollision(Player player,  block) {
  final playerX = player.position.x;
  final playerY = player.position.y;

  final playerWidth = player.width;
  final playerHeight = player.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;
}
