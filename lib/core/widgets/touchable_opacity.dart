import 'package:flutter/material.dart';

class TouchableOpacity extends StatefulWidget {
  final Widget child;
  final double activeOpacity;
  final void Function()? onTap;
  const TouchableOpacity({
    super.key,
    required this.child,
    required this.onTap,
    this.activeOpacity = 0.3,
  });

  @override
  State<TouchableOpacity> createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() {
        _isPressed = true;
      }),
      onTapUp: (_) => setState(() {
        _isPressed = false;
      }),
      onTapCancel: () => setState(() {
        _isPressed = false;
      }),

      child: Opacity(
        opacity: _isPressed ? widget.activeOpacity : 1,
        child: widget.child,
      ),
    );
  }
}
