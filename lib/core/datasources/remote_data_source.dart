//import 'package:vendor/features/user_management/domain/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api/api_helper.dart';
import '../enums/api/HttpMethod.dart';
import '../error/base_error.dart';
import '../error/custom_error.dart';
import '../factories/ModelFactory.dart';
import '../response/api_response.dart';
import '../services/session_manager.dart';

abstract class RemoteDataSource {
  Future<Either<BaseError, Data>> request<Data, Response extends ApiResponse>({
    @required String responseStr,
    @required Response Function(dynamic) mapper,
    @required HttpMethod method,
    @required String url,
    Map<String, String> queryParameters,
    Map<String, dynamic> data,
    String token,
    CancelToken cancelToken,
    String acceptLang ,
  }) async {
    assert(responseStr != null);
    assert(mapper != null);
    assert(method != null);
    assert(url != null);

    ModelFactory.getInstance().registerModel(responseStr, mapper);

    final Map<String, String> headers = {};

    // if (token != null && token.isNotEmpty) {
    //   headers.putIfAbsent(SessionManager.authorizeToken, () => 'Bearer $token');
    //   print('token: $token');
    // }

    headers.putIfAbsent('content-Type', () => 'application/json');

  //  headers['content-Type'] = 'application/json';

     headers.putIfAbsent('x-locale', () => acceptLang);

    print('data: $data');
    final response = await ApiHelper().sendRequest<Response>(
        method: method,
        url: url,
        data: data,
        headers: headers,

        cancelToken: cancelToken);

    print('123 123 Response: $response');

    if (response.isLeft()) {
      return Left((response as Left<BaseError, Response>).value);
    } else if (response.isRight()) {
      final resValue = (response as Right<BaseError, Response>).value;
      print('has error : ${resValue.hasError}');
      if (resValue.hasError) return Left(CustomError(message: resValue.msg));
      return Right(resValue.result);
    }
    return null;
  }
}
