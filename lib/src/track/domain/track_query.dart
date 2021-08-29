import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class TrackQuery with EquatableMixin {
  final String value;

  const TrackQuery(this.value);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}
