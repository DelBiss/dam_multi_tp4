import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart';


const PageTransitionsTheme rotatingPageTransitionTheme = PageTransitionsTheme(builders: {
        TargetPlatform.android: RotatingPageTransition(),
        TargetPlatform.iOS: RotatingPageTransition(),
        TargetPlatform.linux: RotatingPageTransition(),
        TargetPlatform.macOS: RotatingPageTransition(),
        TargetPlatform.windows: RotatingPageTransition(),
      });

class RotatingPageTransition extends PageTransitionsBuilder{
    const RotatingPageTransition();

  @override
  Widget buildTransitions<T>(PageRoute<T> route, BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      
      const begin = 90.0;
      const end = 0.0;
      const curve = Curves.ease;
      
      var tween1 = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var tween2 = Tween(begin: 0.0, end: begin*-1).chain(CurveTween(curve: curve));
      
      return Box3DTransition(
          key: ValueKey("In-${route.settings.name}"), //To ease debuging
          angle: animation.drive(tween1),
          child: Box3DTransition(
            key: ValueKey("Out-${route.settings.name}"), //To ease debuging
          angle: secondaryAnimation.drive(tween2),
          child: child
        )
        );

  }
}


enum Box3DRotationAxis {x,y}

extension Box3DRotationAxisExtention on Box3DRotationAxis{
  Vector3 get rotationAxis{
    switch (this) {
      case Box3DRotationAxis.x:
        return Vector3(1,0,0);
      default:
        return Vector3(0,-1,0);
    }
  }

  Vector2 get offsetAxis{
    return rotationAxis.yx..multiply(Vector2(-1,1));
  }

  Vector2 vectorAlignment(double angle){
    double direction = (sin(angle) >= 0)?1:-1;
    return offsetAxis * -direction;
  }
  Alignment alignment(double angle){
    Vector2 vAlign = vectorAlignment(angle);
    return Alignment(vAlign.x,vAlign.y);
  }

  Vector2 offsetAnim(double angle){
    return offsetAxis.xy * (angle/(pi/2));
  }
  
  Vector2 vectorOffset(double angle, BoxConstraints constraints){
    Vector2 constraintsVector = Vector2(constraints.maxWidth, constraints.maxHeight);
    return offsetAnim(angle)..multiply(constraintsVector);
  }
  Offset offset(double angle, BoxConstraints constraints){
    Vector2 vOffset = vectorOffset(angle,constraints).xy;
    return Offset(vOffset.x,vOffset.y);
  }

  Matrix4 matrix(angle) { 
    return Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotate(rotationAxis, angle);
  }
}

class Box3DTransition extends AnimatedWidget{

  const Box3DTransition({
    Key? key,
    required Animation<double> angle,
    this.transformHitTests = true,
    required this.child,
    this.rotationAxis = Box3DRotationAxis.y
  }) : super(key: key, listenable: angle);

  Animation<double> get angle => listenable as Animation<double>;
  final bool transformHitTests;
  final Widget child;
  final Box3DRotationAxis rotationAxis;

  @override
  Widget build(BuildContext context) {
    
    double angleRad = (angle.value/180)*pi;
    if(cos(angleRad)<0){
      return Container();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Transform.translate(
          offset: rotationAxis.offset(angleRad, constraints),
          child: Transform(
            transform: rotationAxis.matrix(angleRad),
            alignment: rotationAxis.alignment(angleRad),
            child: child,
          ),
        );
      },
    );

  }
}