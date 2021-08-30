import 'package:auto_route/annotations.dart';
import 'package:last_fm_app/src/track/view/track_details_page.dart';
import 'package:last_fm_app/src/track/view/tracks_page.dart';

export 'package:last_fm_app/src/app/app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(
      path: '/',
      page: TracksPage,
      initial: true,
    ),
    AutoRoute<dynamic>(
      path: '/track/:id',
      page: TrackDetailsPage,
    ),
  ],
)
class $AppRouter {}
