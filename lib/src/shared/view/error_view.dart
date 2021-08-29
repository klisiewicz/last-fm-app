import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_fm_app/src/shared/view/context_ext.dart';

class ErrorView extends StatelessWidget {
  final Object error;

  const ErrorView(
    this.error, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Something went wrong',
            style: context.textTheme.headline5,
          ),
          const SizedBox(height: 20),
          Icon(
            Icons.error_outlined,
            size: 64,
            color: context.theme.accentColor,
          ),
          const SizedBox(height: 20),
          Text(
            '$error',
            style: context.textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
