import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart';
import 'bat.dart';
import 'brick.dart';
import 'play_area.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color(0xff1e6091)
              ..style = PaintingStyle.fill,
            children: [CircleHitbox(radius: radius)]);

  final Vector2 velocity;
  final double difficultyModifier;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        if (velocity.y < 0) velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        if (velocity.x < 0) velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        if (velocity.x > 0) velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        add(RemoveEffect(
          delay: 0.35,
        ));
      }
    } else if (other is Bat) {
      if (velocity.y > 0) {
        velocity.y = -velocity.y;
        velocity.x = velocity.x +
            (position.x - other.position.x) / other.size.x * game.width * 0.3;
      }
    } else if (other is Brick) {
      if (position.y < other.position.y - other.size.y / 2) {
        if (velocity.y > 0) velocity.y = -velocity.y;
      } else if (position.y > other.position.y + other.size.y / 2) {
        if (velocity.y < 0) velocity.y = -velocity.y;
      } else if (position.x < other.position.x) {
        if (velocity.x > 0) velocity.x = -velocity.x;
      } else if (position.x > other.position.x) {
        if (velocity.x < 0) velocity.x = -velocity.x;
      }
      velocity.setFrom(velocity * difficultyModifier);
    }
  }
}
