

import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:test_ososs/core/error/base_error.dart';
import 'package:test_ososs/core/models/pokemon_model.dart';
import 'package:test_ososs/core/param/base_param.dart';
import 'package:test_ososs/core/result/result.dart';
import 'package:test_ososs/presentation/hom_flow/usecase/usecase_pokemon_list.dart';
import 'package:test_ososs/presentation/infinite_list_view/bloc/infinite_list_bloc.dart';
import 'package:test_ososs/presentation/infinite_list_view/entity/pagination_params.dart';
import 'package:test_ososs/presentation/infinite_list_view/presentation/pagination_builder.dart';

typedef AsyncCallbackWithParams<T> = Future<T> Function(BaseParams b);
typedef BuilderType<T> = Widget Function(T data, int index);

class WrapperParams {
  final int startIndex;
  final Map<String, dynamic> extraParams;

  WrapperParams(this.startIndex, this.extraParams);

  WrapperParams copyWith({int startIndex, Map<String, dynamic> extraParams}) {
    return PaginationParams(
        startIndex: startIndex ?? this.startIndex,
        extraParams: extraParams ?? this.extraParams);
  }
}

abstract class UseCaseWrapper<T, P extends WrapperParams> {
  Future<List<T>> caller(P params);

  Future<List<T>> responseChecker(Result<BaseError, List<T>> response) async {
    if (response.hasDataOnly) {
      return response.data;
    } else if (response.hasErrorOnly) {
      throw Exception(response.error.toString());
    }
    return null;
  }
}

extension PainationUseCaseBuilder on UseCaseWrapper {
  Widget buildPaginationList<T>({
    Map<String, dynamic> extraParams,
    BuilderType<T> listBuilder,
    BuilderType<T> gridBuilder,
    Key builderKey,
    PaginationController controller,
    void Function(int id, int index, bool hasChild) onPressed,
    int currentId,
  }) {
    switch (runtimeType) {
      case PokemonListWrapper:
        return _buildOrderList(
            builderKey,
            extraParams,
            listBuilder as BuilderType<Results>,
            gridBuilder as BuilderType<Results>,
            controller);
        break;

      default:
        return Container();
    }
  }
}

extension Builders on UseCaseWrapper {
  Widget _buildOrderList(
      Key builderKey,
      Map<String, dynamic> extraParams,
      BuilderType<Results> listBuilder,
      BuilderType<Results> gridBuilder,
      PaginationController controller) {
    return PaginationBuilder<Results>(
      key: builderKey,
      type: ListType.list,
      flex: 10,
      controller: controller,
      extraParams: extraParams,
      useCase: this,
      listBuilder: listBuilder,
      gridBuilder: gridBuilder,
    );
  }


}
