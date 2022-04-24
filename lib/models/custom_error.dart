import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CustomError extends Equatable {
  String error;
  CustomError({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CustomError(error: $error)';
}
