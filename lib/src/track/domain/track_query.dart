import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class TrackQuery with EquatableMixin {
  final String value;
  final int limit;

  const TrackQuery(
    this.value, {
    this.limit = 50,
  });

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}
