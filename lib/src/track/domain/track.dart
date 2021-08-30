import 'package:equatable/equatable.dart';
import 'package:last_fm_app/src/shared/domain/image.dart';
import 'package:meta/meta.dart';

@immutable
class TrackId with EquatableMixin {
  final String value;

  const TrackId(this.value);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}

@immutable
class Track with EquatableMixin {
  final TrackId id;
  final String name;
  final String artist;
  final Image image;

  Track({
    required String id,
    required this.name,
    required this.artist,
    required String imageUrl,
  })  : id = TrackId(id),
        image = Image.url(imageUrl);

  @override
  List<Object?> get props => [id];

  @override
  String toString() => '$artist - $name';
}
