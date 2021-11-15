import 'package:flutter/material.dart';
import 'package:bwa_cozy/theme.dart';

class FacilitiesItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int total;

  FacilitiesItem({this.name, this.imageUrl, this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageUrl,
            width: 32,
          ),
          SizedBox(
            height: 8,
          ),
          Text.rich(TextSpan(
              text: '$total',
              style: purpleTextStyle,
              children: [TextSpan(text: ' $name', style: greyTextStyle)])),
        ],
      ),
    );
  }
}
