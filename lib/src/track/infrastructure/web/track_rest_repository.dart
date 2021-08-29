import 'package:dio/dio.dart';
import 'package:last_fm_app/src/track/domain/track.dart';
import 'package:last_fm_app/src/track/domain/track_query.dart';
import 'package:last_fm_app/src/track/domain/track_repository.dart';

class TrackRestRepository implements TrackRepository {
  final Dio _client;

  TrackRestRepository(Dio client) : _client = client;

  @override
  Future<List<Track>> getByQuery(TrackQuery query) async {
    final response = await _executeGetQuery(query);
    return response.getTracks();
  }

  Future<Response<Map<String, dynamic>>> _executeGetQuery(
    TrackQuery query,
  ) async {
    return _client.get('', queryParameters: query.toMap());
  }
}

extension on TrackQuery {
  Map<String, String> toMap() {
    return {
      'method': 'track.search',
      'track': value,
    };
  }
}

extension on Response {
  List<Track> getTracks() {
    print(this);
    final results = data?['results'] as Map<String, dynamic>?;
    if (results?.isEmpty ?? true) return [];
    final tracks = results!['trackmatches']['track'] as List<dynamic>?;
    return tracks?.map(
          (dynamic json) {
            return Track(
              name: json['name'] as String,
              artist: json['artist'] as String,
              numberOfListeners: int.tryParse(json['listeners'] as String) ?? 0,
              imageUrl: (json['image'] as List)[2]['#text'] as String,
            );
          },
        ).toList() ??
        [];
  }
}
