library insta_image_viewer;

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _kRouteDuration = Duration(milliseconds: 400);

class InstaImageViewer extends StatelessWidget {
  const InstaImageViewer({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    this.disposeLevel,
  }) : super(key: key);

  /// Image widget
  /// For example Image(image:Image.network("https://picsum.photos/id/507/1000").image,)
  final Widget child;

  /// Background in the full screen mode, Colors.black by default
  final Color backgroundColor;

  /// Make background transparent
  final bool backgroundIsTransparent;

  /// After what level of drag from top image should be dismissed
  /// high - 300px, middle - 200px, low - 100px
  final DisposeLevel? disposeLevel;

  @override
  Widget build(BuildContext context) {
    final UniqueKey tag = UniqueKey();
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              transitionDuration: _kRouteDuration,
              reverseTransitionDuration: _kRouteDuration,
              barrierColor: backgroundIsTransparent
                  ? Colors.white.withOpacity(0)
                  : backgroundColor,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final tween = Tween(begin: 0.0, end: 1.0);
                final fadeAnimation = animation.drive(tween);
                return FadeTransition(
                  opacity: fadeAnimation,
                  child: child,
                );
              },
              pageBuilder: (BuildContext context, _, __) {
                return FullScreenViewer(
                  child: Hero(tag: tag, child: child),
                  backgroundColor: backgroundColor,
                  backgroundIsTransparent: backgroundIsTransparent,
                  disposeLevel: disposeLevel,
                );
              },
            ),
          );
        },
        child: child,
      ),
    );
  }
}

enum DisposeLevel { high, medium, low }

class FullScreenViewer extends StatefulWidget {
  const FullScreenViewer({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    this.disposeLevel = DisposeLevel.medium,
  }) : super(key: key);

  final Widget child;
  final Color backgroundColor;
  final bool backgroundIsTransparent;
  final DisposeLevel? disposeLevel;

  @override
  _FullScreenViewerState createState() => _FullScreenViewerState();
}

class _FullScreenViewerState extends State<FullScreenViewer> {
  double? _initialPositionY = 0;

  double? _currentPositionY = 0;

  double _positionYDelta = 0;

  double _opacity = 1;

  double _disposeLimit = 150;

  Duration _animationDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    setDisposeLevel();
  }

  setDisposeLevel() {
    if (widget.disposeLevel == DisposeLevel.high) {
      _disposeLimit = 300;
    } else if (widget.disposeLevel == DisposeLevel.medium) {
      _disposeLimit = 200;
    } else {
      _disposeLimit = 100;
    }
  }

  void _startVerticalDrag(details) {
    setState(() {
      _initialPositionY = details.globalPosition.dy;
    });
  }

  void _whileVerticalDrag(details) {
    setState(() {
      _currentPositionY = details.globalPosition.dy;
      _positionYDelta = _currentPositionY! - _initialPositionY!;
      setOpacity();
    });
  }

  setOpacity() {
    final double tmp = _positionYDelta < 0
        ? 1 - ((_positionYDelta / 1000) * -1)
        : 1 - (_positionYDelta / 1000);
    if (kDebugMode) {
      print(tmp);
    }

    if (tmp > 1) {
      _opacity = 1;
    } else if (tmp < 0) {
      _opacity = 0;
    } else {
      // _opacity = tmp;
      _opacity = 1;
    }

    if (_positionYDelta > _disposeLimit || _positionYDelta < -_disposeLimit) {
      // _opacity = tmp;
      _opacity = 1;
    }
  }

  _endVerticalDrag(DragEndDetails details) {
    if (_positionYDelta > _disposeLimit || _positionYDelta < -_disposeLimit) {
      _opacity = 0;
      Navigator.of(context).pop();
    } else {
      setState(() {
        _animationDuration = const Duration(milliseconds: 400);
        // _opacity = 1;
        _positionYDelta = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPosition = 0 + max(_positionYDelta, -_positionYDelta) / 15;
    return Scaffold(
      backgroundColor: widget.backgroundIsTransparent
          ? Colors.transparent
          : widget.backgroundColor,
      body: GestureDetector(
        onVerticalDragStart: (details) => _startVerticalDrag(details),
        onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
        onVerticalDragEnd: (details) => _endVerticalDrag(details),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 100),
          opacity: _opacity,
          child: Container(
            color: widget.backgroundColor,
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: _animationDuration,
                  curve: Curves.fastOutSlowIn,
                  top: 0 + _positionYDelta,
                  bottom: 0 - _positionYDelta,
                  left: horizontalPosition,
                  right: horizontalPosition,
                  child: InteractiveViewer(
                    panEnabled: false,
                    boundaryMargin: const EdgeInsets.all(double.infinity),
                    child: widget.child,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
