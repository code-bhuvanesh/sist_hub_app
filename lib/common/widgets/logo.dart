import 'package:flutter/material.dart';

import '../../styles/styles.dart';


class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: const Center(
        child: Text(
          "SIST HUB",
          style: AppTextStyles.logoTextStyle,
        ),
      ),
    );
  }
}
