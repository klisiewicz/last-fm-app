import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final urlLauncherProvider = Provider.family.autoDispose<Function(), String>((
  AutoDisposeRef ref,
  String url,
) {
  return () async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    }
  };
});
