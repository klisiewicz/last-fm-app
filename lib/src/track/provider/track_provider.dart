import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/shared/infrastructure/web/client_provider.dart';
import 'package:last_fm_app/src/track/domain/track_query.dart';
import 'package:last_fm_app/src/track/domain/track_repository.dart';
import 'package:last_fm_app/src/track/infrastructure/web/track_rest_repository.dart';

final trackRepositoryProvider = Provider<TrackRepository>((
  ProviderReference ref,
) {
  return TrackRestRepository(ref.watch(clientProvider));
});

final trackQueryProvider =
    StateProvider.autoDispose<String>((ProviderReference ref) => '');

final tracksProvider = FutureProvider.autoDispose((
  AutoDisposeProviderReference ref,
) async {
  final trackQueryNotifier = ref.watch(trackQueryProvider);
  final repository = ref.watch(trackRepositoryProvider);
  return repository.getByQuery(TrackQuery(trackQueryNotifier.state));
});
