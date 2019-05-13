import 'dart:async' show Future;
import 'package:http/http.dart' as http show delete, Response;
import 'package:network/src/exception.dart';
import 'package:network/src/response.dart';
import 'package:network/src/utils.dart';
import 'package:network/src/utils/serialize_query_params.dart';

Future<T> delete<T extends BinaryResponse>(
  String url, {
  Map<String, String> headers,
  Map<String, dynamic> queryParameters = const {},
}) async {
  final http.Response httpResponse = await http.delete(
      url + serializeQueryParameters(queryParameters),
      headers: headers);

  final int statusCode = httpResponse.statusCode;

  final response = makeResponseByType<T>(statusCode, httpResponse.bodyBytes);

  if (statusCode < 200 || statusCode >= 400) {
    throw NetworkException<T>(response);
  }

  return response;
}
