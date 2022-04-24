import 'package:http/http.dart';

String httpErrorHandler(Response response) {
  final statusCode = response.statusCode;
  final reasone = response.reasonPhrase;
  String message = 'Request failed\nStatus Code: $statusCode\nReason: $reasone';
  return message;
}
