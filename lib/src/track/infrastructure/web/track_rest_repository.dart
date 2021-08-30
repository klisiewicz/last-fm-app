import 'package:dio/dio.dart';
import 'package:last_fm_app/src/track/domain/track.dart';
import 'package:last_fm_app/src/track/domain/track_details.dart';
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

  @override
  Future<TrackDetails?> getById(TrackId id) async {
    final response = await _executeGetTrack(id);
    return response.getTrack();
  }

  Future<Response<Map<String, dynamic>>> _executeGetTrack(
    TrackId id,
  ) async {
    return _client.get('', queryParameters: id.toMap());
  }
}

extension on TrackQuery {
  Map<String, String> toMap() {
    return {
      'method': 'track.search',
      'track': value,
      'limit': '$limit',
    };
  }
}

extension on TrackId {
  Map<String, String> toMap() {
    return {
      'mbid': '$this',
      'method': 'track.getInfo',
    };
  }
}

extension on Response {
  List<Track> getTracks() {
    final results = data?['results'] as Map<String, dynamic>?;
    if (results?.isEmpty ?? true) return [];
    final tracks = results!['trackmatches']['track'] as List<dynamic>?;
    return tracks
            ?.where((dynamic json) => (json['mbid'] as String).isNotEmpty)
            .map(
          (dynamic json) {
            return Track(
              id: json['mbid'] as String,
              name: json['name'] as String,
              artist: json['artist'] as String,
              imageUrl: (json['image'] as List)[2]['#text'] as String,
            );
          },
        ).toList() ??
        [];
  }

  TrackDetails? getTrack() {
    final track = data?['track'] as Map<String, dynamic>?;
    if (track == null) return null;
    return TrackDetails(
      id: track['mbid'] as String,
      name: track['name'] as String,
      durationInSeconds: int.tryParse(track['duration'] as String) ?? 0,
      artist: track['album']['artist'] as String,
      albumTitle: track['album']['title'] as String,
      albumCover: (track['album']['image'] as List).last['#text'] as String,
      tags: (track['toptags']['tag'] as List)
          .map((dynamic tag) => tag['name'] as String)
          .toList(),
    );
  }
}
