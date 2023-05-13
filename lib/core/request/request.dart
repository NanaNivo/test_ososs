import 'package:dio/dio.dart';

abstract class BaseRequest {}

abstract class PostRequest extends BaseRequest {
  FormData toJson();
}

abstract class Request extends BaseRequest {
  Map<String, dynamic> toJson();
}
