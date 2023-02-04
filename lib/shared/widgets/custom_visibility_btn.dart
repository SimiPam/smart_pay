import 'package:flutter/material.dart';

import '../utils/color.dart';

class PasswordVisibilityBtn extends StatelessWidget {
  const PasswordVisibilityBtn({
    Key? key,
    required this.onPress,
    required this.isVisible,
  }) : super(key: key);

  final void Function() onPress;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPress,
        enableFeedback: false,
        icon: isVisible
            ? const Icon(Icons.visibility, color: AppColors.greyscaleTextColor)
            : const Icon(Icons.visibility_off,
                color: AppColors.greyscaleTextColor));
  }
}
