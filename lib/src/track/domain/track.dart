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
  final String name;
  final String artist;
  final int numberOfListeners;
  final Image image;

  Track({
    required this.name,
    required this.artist,
    required this.numberOfListeners,
    required String imageUrl,
  }) : image = Image.url(imageUrl);

  @override
  List<Object?> get props => [name, artist];

  @override
  String toString() => '$artist - $name';
}
