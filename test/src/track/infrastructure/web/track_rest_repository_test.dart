import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:last_fm_app/src/track/domain/track.dart';
import 'package:last_fm_app/src/track/domain/track_query.dart';
import 'package:last_fm_app/src/track/domain/track_repository.dart';
import 'package:last_fm_app/src/track/infrastructure/web/track_rest_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../util/file_test_util.dart';
import '../../../util/responses.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio client;
  late TrackRepository trackRepository;

  setUp(() {
    client = DioMock();
    trackRepository = TrackRestRepository(client);
  });

  group('when dio client returns 200 response with the list of tracks', () {
    const trackName = 'Believe';

    setUp(() {
      when(
        () => client.get<Map<String, dynamic>>(
          '',
          queryParameters: _trackSearchQueryParameters(trackName),
        ),
      ).thenAnswer(
        (_) async => okResponse(await readJsonFromFile('track_response')),
      );
    });

    test('then should return tracks', () async {
      final tracks = await trackRepository.getByQuery(
        const TrackQuery(trackName),
      );
      expect(tracks, hasLength(2));
      tracks.first.shouldBeImagineDragonsBeliever();
      tracks.last.shouldBeCherBelieve();
    });
  });
}

Map<String, dynamic> _trackSearchQueryParameters(String trackName) {
  return any(
    named: 'queryParameters',
    that: allOf(_isTrackSearch(), _withTrackName(trackName)),
  );
}

TypeMatcher<Map<String, String>> _isTrackSearch() {
  return const TypeMatcher<Map<String, String>>().having(
    (queryParams) => queryParams['method'],
    'method',
    equals('track.search'),
  );
}

TypeMatcher<Map<String, String>> _withTrackName(String trackName) {
  return const TypeMatcher<Map<String, String>>().having(
    (queryParams) => queryParams['track'],
    'track',
    equals(trackName),
  );
}

extension on Track {
  void shouldBeImagineDragonsBeliever() {
    shouldBeEqualTo(
      name: 'Believer',
      artist: 'Imagine Dragons',
      listeners: 491053,
      imageUrl:
          'https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png',
    );
  }

  void shouldBeCherBelieve() {
    shouldBeEqualTo(
      name: 'Believe',
      artist: 'Cher',
      listeners: 582577,
      imageUrl:
          'https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png',
    );
  }

  void shouldBeEqualTo({
    required String name,
    required String artist,
    required int listeners,
    required String imageUrl,
  }) {
    expect(name, equals(name));
    expect(artist, equals(artist));
    expect(numberOfListeners, equals(listeners));
    expect(image.url, equals(imageUrl));
  }
}
