import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/shared/infrastructure/web/client_provider.dart';
import 'package:last_fm_app/src/track/domain/track.dart';
import 'package:last_fm_app/src/track/domain/track_details.dart';
import 'package:last_fm_app/src/track/domain/track_query.dart';
import 'package:last_fm_app/src/track/domain/track_repository.dart';
import 'package:last_fm_app/src/track/infrastructure/web/track_rest_repository.dart';

final trackRepositoryProvider = Provider<TrackRepository>((
  ProviderReference ref,
) {
  return TrackRestRepository(ref.watch(clientProvider));
});

final trackQueryProvider =
    StateProvider.autoDispose<String>((AutoDisposeProviderReference ref) => '');

final tracksProvider = FutureProvider.autoDispose<List<Track>>((
  AutoDisposeProviderReference ref,
) async {
  final query = ref.watch(trackQueryProvider).state;
  final repository = ref.watch(trackRepositoryProvider);
  return repository.getByQuery(TrackQuery(query));
});

final trackProvider = FutureProvider.autoDispose.family<TrackDetails?, String>(
    (AutoDisposeProviderReference ref, String id) async {
  final repository = ref.watch(trackRepositoryProvider);
  final trackId = TrackId(id);
  return repository.getById(trackId);
});
