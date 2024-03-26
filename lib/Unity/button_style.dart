import 'package:flutter/material.dart';

class IconDeletionAndAddition extends StatelessWidget {
  final Icon? icon;
  final bool isAddition;
  final ButtonStyle? style;
  final Function()? ontap;

  const IconDeletionAndAddition({
    super.key,
    this.icon,
    required this.isAddition,
    this.style,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = isAddition ? ontap : ontap;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
          icon: icon ?? Icon(isAddition ? Icons.add : Icons.remove),
          onPressed: onPressed,
          style: style,
        ));
  }
}
