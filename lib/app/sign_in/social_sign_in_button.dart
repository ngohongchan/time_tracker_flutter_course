import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    required String assetsName,
    required String text,
    required var color,
    required Color textColor,
    required VoidCallback onPressed,
  })  : assert(assetsName != null),
        assert(text != null),
        super(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(assetsName),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15.0,
                  ),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image.asset(assetsName),
                ),
              ]),
          color: color,
          height: 40.0,
          borderRadius: 10.0,
          onPressed: onPressed,
        );
}
