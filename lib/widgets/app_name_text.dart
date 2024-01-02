import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopsmart_users_ar/widgets/title_text.dart';

class AppNameTextWidget extends StatelessWidget {
  final double fontSize;
  const AppNameTextWidget({super.key, this.fontSize = 30});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: const Duration(seconds: 16),
        baseColor: Colors.purple,
        highlightColor: Colors.red,
        child: TitlesTextWidget(
          label: "Amaz Insights",
          fontSize: fontSize,
        ));
  }
}
