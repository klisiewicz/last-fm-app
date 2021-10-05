import 'package:flutter/material.dart';
import 'package:last_fm_app/src/shared/view/context_ext.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: context.theme.colorScheme.secondary,
    );
  }
}
