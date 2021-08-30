import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:last_fm_app/src/track/domain/album.dart';
import 'package:last_fm_app/src/track/domain/track.dart';
import 'package:meta/meta.dart';

@immutable
class TrackDetails with EquatableMixin {
  final TrackId id;
  final String name;
  final Duration duration;
  final Album album;
  final List<String> tags;

  TrackDetails({
    required String id,
    required this.name,
    required int durationInSeconds,
    required String artist,
    required String albumTitle,
    required String albumCover,
    List<String> tags = const [],
  })  : id = TrackId(id),
        duration = Duration(seconds: durationInSeconds),
        album = Album(artist: artist, title: albumTitle, imageUrl: albumCover),
        tags = UnmodifiableListView(tags);

  @override
  List<Object?> get props => [id];
}
