import 'package:flutter/material.dart';

Duration transitionDuration() {
  return const Duration(milliseconds: 1000);
}

Duration reverseTransitionDuration() {
  return const Duration(milliseconds: 400);
}

class TransitionalRouteFade extends PageRouteBuilder {
  final Widget page;

  TransitionalRouteFade(this.page)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: transitionDuration(),
          reverseTransitionDuration: reverseTransitionDuration(),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return FadeTransition(
              opacity: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
}

class TransitionalRouteBounce extends PageRouteBuilder {
  final Widget page;

  TransitionalRouteBounce(this.page)
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: transitionDuration(),
            reverseTransitionDuration: reverseTransitionDuration(),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return SlideTransition(
                position: Tween(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0))
                    .animate(animation),
                child: page,
              );
            });
}

class TransitionalRouteSlide extends PageRouteBuilder {
  final Widget page;

  TransitionalRouteSlide(this.page)
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: transitionDuration(),
            reverseTransitionDuration: reverseTransitionDuration(),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return ScaleTransition(
                scale: animation,
                alignment: Alignment.topLeft,
                child: child,
              );
            });
}
