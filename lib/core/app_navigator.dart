import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

extension BuildContextNavigation on BuildContext {
  void pop<T extends Object>([T? result]) => Navigator.of(this).pop(result);

  void popUntil(RoutePredicate predicate) => Navigator.of(this).popUntil(predicate);

  Future<T?> push<T extends Object>(
          {required WidgetBuilder builder,
          required RouteSettings settings,
          bool maintainState = true,
          bool fullscreenDialog = false,
          bool rootNavigator = false,
          Duration transitionDuration = const Duration(milliseconds: 500),
          PageTransitionType transitionType = PageTransitionType.rightToLeft}) =>
      Navigator.of(this, rootNavigator: rootNavigator).push(AnimatedPageRoute<T>(
          transitionDuration: transitionDuration,
          transitionType: transitionType,
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog));

  Future<T?> pushTransparent<T extends Object>(
          {required WidgetBuilder builder,
          required RouteSettings settings,
          Color? overlayColor,
          bool maintainState = true,
          bool fullscreenDialog = false,
          bool rootNavigator = false}) =>
      Navigator.of(this, rootNavigator: rootNavigator).push(TransparentRoute<T>(
          builder: builder, settings: settings, overlayColor: overlayColor, updatedFullscreenDialog: fullscreenDialog));

  Future<T?> pushReplacementTransparent<T extends Object>(
          {required WidgetBuilder builder,
          required RouteSettings settings,
          Color? overlayColor,
          bool maintainState = true,
          bool fullscreenDialog = false}) =>
      Navigator.of(this).pushReplacement(TransparentRoute<T>(
          builder: builder, settings: settings, overlayColor: overlayColor, updatedFullscreenDialog: fullscreenDialog));

  Future<T?> pushReplacement<T extends Object>(
          {required WidgetBuilder builder,
          required RouteSettings settings,
          bool maintainState = true,
          bool fullscreenDialog = false,
          Duration transitionDuration = const Duration(milliseconds: 500),
          PageTransitionType transitionType = PageTransitionType.rightToLeft}) =>
      Navigator.of(this).pushReplacement(AnimatedPageRoute<T>(
          transitionDuration: transitionDuration,
          transitionType: transitionType,
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog));

  Future<T?> pushAndRemoveUntil<T extends Object>(
          {required WidgetBuilder builder,
          required RouteSettings settings,
          bool maintainState = true,
          bool fullscreenDialog = false,
          Duration transitionDuration = const Duration(milliseconds: 500),
          PageTransitionType transitionType = PageTransitionType.rightToLeft}) =>
      Navigator.of(this).pushAndRemoveUntil(
          AnimatedPageRoute<T>(
              transitionDuration: transitionDuration,
              transitionType: transitionType,
              builder: builder,
              settings: settings,
              maintainState: maintainState,
              fullscreenDialog: fullscreenDialog),
          (route) => false);

  Future<bool> maybePop<T extends Object?>([T? result]) => Navigator.of(this).maybePop(result);

  void showToast(Widget child) {
    showToastWidget(child,
        context: this,
        duration: const Duration(milliseconds: 3000),
        animDuration: const Duration(milliseconds: 100),
        animation: StyledToastAnimation.none,
        reverseAnimation: StyledToastAnimation.none,
        position: StyledToastPosition.center);
  }

  showBottomSheet(
          {required Widget child,
          bool isDismissible = true,
          bool isScrollControlled = true,
          Color backgroundColor = Colors.white,
          double borderRadius = 8.0}) =>
      showModalBottomSheet(
          backgroundColor: backgroundColor,
          // here increase or decrease in width),
          useSafeArea: true,
          isDismissible: isDismissible,
          context: this,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius))),
          isScrollControlled: isScrollControlled,
          builder: (context) => child);
}

class TransparentRoute<T> extends PageRoute<T> {
  TransparentRoute(
      {required this.builder, required this.updatedFullscreenDialog, required this.overlayColor, super.settings})
      : super(fullscreenDialog: updatedFullscreenDialog);

  final WidgetBuilder builder;
  final bool updatedFullscreenDialog;
  final Color? overlayColor;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final result = builder(context);
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end);
    final offsetAnimation = animation.drive(tween);
    return Container(
        color: overlayColor ?? Colors.blue.shade200, child: SlideTransition(position: offsetAnimation, child: result));
  }
}

class AnimatedPageRoute<T> extends PageRouteBuilder<T> {
  AnimatedPageRoute(
      {required WidgetBuilder builder,
      super.settings,
      super.maintainState,
      super.fullscreenDialog,
      PageTransitionType transitionType = PageTransitionType.rightToLeft,
      super.transitionDuration})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => builder(context),
            reverseTransitionDuration: transitionDuration,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              Offset begin;
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              switch (transitionType) {
                case PageTransitionType.rightToLeft:
                  begin = const Offset(1.0, 0.0);
                case PageTransitionType.leftToRight:
                  begin = const Offset(-1.0, 0.0);
                case PageTransitionType.upToDown:
                  begin = const Offset(0.0, -1.0);
                case PageTransitionType.downToUp:
                  begin = const Offset(0.0, 1.0);
                case PageTransitionType.scale:
                  // For scale animation, we'll handle differently
                  final scaleAnimation =
                      Tween<double>(begin: 0.9, end: 1.0).animate(CurvedAnimation(parent: animation, curve: curve));
                  final fadeAnimation =
                      Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: animation, curve: curve));
                  return FadeTransition(
                      opacity: fadeAnimation, child: ScaleTransition(scale: scaleAnimation, child: child));
                case PageTransitionType.fade:
                  return FadeTransition(opacity: animation, child: child);
              }

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            });
}

enum PageTransitionType { rightToLeft, leftToRight, upToDown, downToUp, scale, fade }
