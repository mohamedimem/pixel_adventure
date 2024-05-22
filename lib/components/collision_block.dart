// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  bool isPlatform;
  CollisionBlock({
    this.isPlatform = false,
    position,
    size,
  }) : super(size: size, position: position) {
    debugMode = true;
  }
}
