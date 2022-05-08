import 'package:flutter/material.dart';

import '../../../main_theme.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onAction;

  const ActionButton({Key? key, required this.icon, required this.onAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 45,
      child: Material(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: InkWell(
          child: Icon(icon, color: mainTheme.secondaryHeaderColor, size: 24),
          onTap: () {
            onAction();
          },
        ),
        elevation: 2.0,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
    );
  }
}
