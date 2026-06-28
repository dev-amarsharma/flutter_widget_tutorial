import 'dart:math' as math;

import 'package:flutter/material.dart';

@immutable
class ExpandableFabAction {
  const ExpandableFabAction({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final Widget icon;
  final String tooltip;
  final VoidCallback onPressed;
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen = false,
    required this.distance,
    required this.actions,
  }) : assert(distance > 0);

  final bool initialOpen;
  final double distance;
  final List<ExpandableFabAction> actions;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  late bool _open;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen;
    _controller = AnimationController(
      value: _open ? 1 : 0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_open) {
      _close();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    setState(() => _open = true);
    _controller.forward();
  }

  void _close() {
    setState(() => _open = false);
    _controller.reverse();
  }

  void _runAction(ExpandableFabAction action) {
    _close();
    action.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          ..._buildActionButtons(),
          FloatingActionButton(
            heroTag: null,
            tooltip: _open ? 'Close actions' : 'Open actions',
            onPressed: _toggle,
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _controller,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActionButtons() {
    final count = widget.actions.length;
    final step = count <= 1 ? 0.0 : 90.0 / (count - 1);

    return [
      for (var index = 0; index < count; index++)
        _ExpandingActionButton(
          directionInDegrees: count <= 1 ? 90 : 90 - index * step,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: Tooltip(
            message: widget.actions[index].tooltip,
            child: FloatingActionButton.small(
              heroTag: widget.actions[index],
              onPressed: () => _runAction(widget.actions[index]),
              child: widget.actions[index].icon,
            ),
          ),
        ),
    ];
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * math.pi / 180,
          progress.value * maxDistance,
        );
        return Positioned(
          right: 8 + offset.dx,
          bottom: 8 + offset.dy,
          child: IgnorePointer(
            ignoring: progress.value < 1,
            child: Transform.rotate(
              angle: (1 - progress.value) * math.pi / 2,
              child: Opacity(opacity: progress.value, child: child),
            ),
          ),
        );
      },
      child: child,
    );
  }
}
