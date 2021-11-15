import 'package:flutter/material.dart';
import '../theme.dart';

class RatingItem extends StatelessWidget {
  final int index;
  final int rating;

  RatingItem(this.index, this.rating);

  @override
  Widget build(BuildContext context) {
    return index <= rating
        ? Image.asset(
            'assets/icons/Icon_star_solid.png',
            width: 20,
          )
        : Image.asset(
            'assets/icons/Icon_star_solid.png',
            width: 20,
            color: greyColor,
          );
  }
}
