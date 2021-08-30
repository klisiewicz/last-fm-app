import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/shared/view/context_ext.dart';
import 'package:last_fm_app/src/track/provider/track_provider.dart';

class TracksSearchBar extends HookWidget implements PreferredSizeWidget {
  const TracksSearchBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textController = _useTextEditingControllerWithDebounce(context);
    return AppBar(
      title: SizedBox(
        height: kToolbarHeight - 12,
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            hintText: 'Search for tracks...',
            suffixIcon: Icon(
              Icons.search,
              color: context.theme.accentColor,
            ),
            fillColor: context.theme.canvasColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

TextEditingController _useTextEditingControllerWithDebounce(
  BuildContext context,
) {
  final textEditingController = useTextEditingController(text: '');
  useEffect(() {
    Timer? timer;
    void listener() {
      timer?.cancel();
      timer = Timer(const Duration(milliseconds: 250), () {
        final newQuery = textEditingController.text.trim();
        final trackQueryNotifier = context.read(trackQueryProvider);
        trackQueryNotifier.updateWhenChanged(newQuery);
      });
    }

    textEditingController.addListener(listener);
    return () {
      timer?.cancel();
      textEditingController.removeListener(listener);
    };
  }, [textEditingController]);
  return textEditingController;
}

extension on StateController<String> {
  void updateWhenChanged(String newValue) {
    if (state != newValue) {
      state = newValue;
    }
  }
}
