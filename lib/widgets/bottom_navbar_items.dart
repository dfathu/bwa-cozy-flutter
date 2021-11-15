import 'package:bwa_cozy/theme.dart';
import 'package:flutter/material.dart';

class BottomNavbaritem extends StatelessWidget {
  final String imageUrl;
  final bool isActive;

  BottomNavbaritem({this.imageUrl, this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        isActive
            ? Image.asset(
                imageUrl,
                color: purpleColor,
                width: 26,
                height: 26,
              )
            : Image.asset(
                imageUrl,
                width: 26,
                height: 26,
              ),
        Spacer(),
        isActive
            ? Container(
                height: 2,
                width: 30,
                decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(1000))),
              )
            : Container()
      ],
    );
  }
}
