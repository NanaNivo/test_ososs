import 'package:dio/dio.dart';

abstract class BaseParams{
  CancelToken cancelToken;
  BaseParams({this.cancelToken});
}