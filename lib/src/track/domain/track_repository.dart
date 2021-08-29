import 'package:last_fm_app/src/track/domain/track.dart';
import 'package:last_fm_app/src/track/domain/track_query.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TrackRepository {
  Future<List<Track>> getByQuery(TrackQuery query);
}
