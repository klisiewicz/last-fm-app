import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:last_fm_app/src/shared/view/context_ext.dart';

class TrackSearchBar extends HookWidget implements PreferredSizeWidget {
  const TrackSearchBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    return AppBar(
      centerTitle: true,
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
