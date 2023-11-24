import 'package:algo_verse_app/components/buttons/visualization_fab/algorithm_buttons.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class VisualizeButton extends StatefulWidget {
  const VisualizeButton(
      {super.key,
      this.initialOpen,
      required this.distance,
      required this.children});

  final bool? initialOpen;
  final double distance;
  final List<AlgorithmButton> children;

  @override
  State<VisualizeButton> createState() => _VisualizeButtonState();
}

class _VisualizeButtonState extends State<VisualizeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    const step = 80;
    for (var i = 0, distance = widget.distance;
        i < count;
        i++, distance += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: 90.0,
          maxDistance: distance,
          progress: _expandAnimation,
          child: widget.children[i],
          onTap: () {
            if (_open == false) {
            } else {
              if (widget.children[i].closeFabOnTap) {
                _toggle();
              }
              widget.children[i].onPressed?.call();
            }
          },
        ),
      );
    }
    return children;
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
              onTap: _toggle,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.close,
                  color: Color.fromRGBO(51, 74, 100, 1),
                ),
              )),
        ),
      ),
    );
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(microseconds: 250),
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeOut,
        ),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(
            0.25,
            1.0,
            curve: Curves.easeIn,
          ),
          duration: const Duration(microseconds: 250),
          child: FloatingActionButton.extended(
            onPressed: _toggle,
            elevation: 10,
            backgroundColor: Color.alphaBlend(
                const Color.fromRGBO(239, 237, 93, 0.9),
                const Color.fromRGBO(51, 74, 100, 0.9)),
            label: const Icon(
              Icons.play_arrow_outlined,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
    this.onTap,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: InkWell(
          splashColor: Colors.green,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
