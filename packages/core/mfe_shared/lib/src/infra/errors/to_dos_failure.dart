import '../../domain/errors/failure.dart';

class ToDosFailure extends Failure {
  final String message;
  final Map<String, dynamic>? attributes;

  ToDosFailure({
    required this.message,
    this.attributes,
  });

  @override
  List<Object> get props => [message, attributes ?? {}];
}
