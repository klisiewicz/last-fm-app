import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/shared/infrastructure/web/client_provider.dart';
import 'package:last_fm_app/src/track/domain/track.dart';
import 'package:last_fm_app/src/track/domain/track_query.dart';
import 'package:last_fm_app/src/track/domain/track_repository.dart';
import 'package:last_fm_app/src/track/infrastructure/web/track_rest_repository.dart';

final trackRepositoryProvider = Provider<TrackRepository>((
  ProviderReference ref,
) {
  return TrackRestRepository(ref.watch(clientProvider));
});

final tracksProvider = FutureProvider.autoDispose.family<List<Track>, String>(
  (ProviderReference ref, String query) async {
    final repository = ref.watch(trackRepositoryProvider);
    return repository.getByQuery(TrackQuery(query));
  },
);
