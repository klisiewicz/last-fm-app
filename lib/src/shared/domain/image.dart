import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Image with EquatableMixin {
  final String url;

  const Image._(this.url);

  factory Image.url(String url) {
    return Image._(_checkImageUrl(url));
  }

  @override
  List<Object?> get props => [url];

  @override
  String toString() => url;
}

String _checkImageUrl(String url) {
  final imageUrlRegExp = RegExp(r'(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|png)');
  if (!imageUrlRegExp.hasMatch(url)) {
    throw ArgumentError.value(url, 'url', 'Invalid url');
  }
  return url;
}
