import 'package:flutter/material.dart';
import 'package:examen_flutter/core/extensions.dart';

class CenteredTextButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final bool isEnabled;
  final Function() onTap;
  final Color color;
  final Color disabledColor;

  const CenteredTextButton._internal({
    super.key,
    required this.label,
    required this.isPrimary,
    required this.isEnabled,
    required this.onTap,
    required this.color,
    required this.disabledColor,
  });

  factory CenteredTextButton.primary({
    Key? key,
    required String label,
    bool isEnabled = true,
    required Function() onTap,
    required BuildContext context,
  }) {
    return CenteredTextButton._internal(
      key: key,
      label: label,
      isPrimary: true,
      isEnabled: isEnabled,
      onTap: onTap,
      color: Theme.of(context).appColors.backgroundActionPrimary,
      disabledColor:
          Theme.of(context).appColors.backgroundActionPrimaryDisabled,
    );
  }

  factory CenteredTextButton.secondary({
    Key? key,
    required String label,
    bool isEnabled = true,
    required Function() onTap,
    required BuildContext context,
  }) {
    return CenteredTextButton._internal(
      key: key,
      label: label,
      isPrimary: false,
      isEnabled: isEnabled,
      onTap: onTap,
      color: Theme.of(context).appColors.backgroundActionPrimaryDisabled,
      disabledColor: Theme.of(context).appColors.snackbarError,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onTap : null,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color
      ),
    );
  }
}
