import 'package:equatable/equatable.dart';
import 'package:last_fm_app/src/shared/domain/image.dart';
import 'package:meta/meta.dart';

@immutable
class Album with EquatableMixin {
  final String artist;
  final String title;
  final Image image;

  Album({
    required this.artist,
    required this.title,
    required String imageUrl,
  }) : image = Image.url(imageUrl);

  @override
  List<Object?> get props => [artist, title];

  @override
  String toString() => '$artist - $title';
}
