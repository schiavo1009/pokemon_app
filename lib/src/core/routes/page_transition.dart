import 'package:flutter/widgets.dart';

import 'roues_core.dart';

class PageTransition<T> extends PageRouteBuilder<T> {
  // ignore: use_super_parameters
  PageTransition({
    required this.builder,
    required this.type,
    this.curve = Curves.easeInOut,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 600),
    RouteSettings? settings,
    bool maintainState = true,
    // ignore: avoid_unused_constructor_parameters
    required Widget Function(dynamic context, dynamic animation, dynamic secondaryAnimation) pageBuilder,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return builder(context);
          },
          transitionDuration:
              type == RouteTransition.none ? Duration.zero : duration,
          reverseTransitionDuration: type == RouteTransition.none
              ? Duration.zero
              : const Duration(milliseconds: 300),
          settings: settings,
          maintainState: maintainState,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (type) {
              case RouteTransition.rightToLeft:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(-1, 0),
                    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve)),
                    child: child,
                  ),
                );

              case RouteTransition.leftToRight:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(1, 0),
                    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve)),
                    child: child,
                  ),
                );
              case RouteTransition.upToDown:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(0, -1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0, 1),
                    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve)),
                    child: child,
                  ),
                );
              case RouteTransition.downToUp:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0, -1),
                    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve)),
                    child: child,
                  ),
                );
              case RouteTransition.scale:
                return ScaleTransition(
                  alignment: alignment,
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Interval(
                      0,
                      0.50,
                      curve: curve,
                    ),
                  ),
                  child: child,
                );
              case RouteTransition.rotate:
                return RotationTransition(
                  alignment: alignment,
                  turns: CurvedAnimation(parent: animation, curve: curve),
                  child: ScaleTransition(
                    scale: CurvedAnimation(parent: animation, curve: curve),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                );
              case RouteTransition.size:
                return Align(
                  child: SizeTransition(
                    sizeFactor: CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                    child: child,
                  ),
                );
              case RouteTransition.rightToLeftWithFade:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: FadeTransition(
                    opacity: CurvedAnimation(parent: animation, curve: curve),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(-1, 0),
                      ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve)),
                      child: child,
                    ),
                  ),
                );
              case RouteTransition.leftToRightWithFade:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: FadeTransition(
                    opacity: CurvedAnimation(parent: animation, curve: curve),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(1, 0),
                      ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve)),
                      child: child,
                    ),
                  ),
                );
              case RouteTransition.defaultTransition:
                return child;
              case RouteTransition.none:
                return child;
            }
          },
        );
  final Widget Function(BuildContext context) builder;
  final RouteTransition type;
  final Curve curve;
  final Alignment alignment;
  final Duration duration;
}
