import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    required this.child,
    required this.color,
    required this.height,
    required this.borderRadius,
    required this.onPressed,
  });

  final Widget child;
  final Color color;
  final double height;
  final double borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: RaisedButton(
        onPressed: onPressed,
        padding: EdgeInsets.all(20.0),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        child: child,
      ),
    );
  }
}
