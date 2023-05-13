import 'package:dartz/dartz.dart';

import 'package:test_ososs/core/datasources/remote_data_source.dart';
import 'package:test_ososs/core/error/base_error.dart';
import 'package:test_ososs/core/models/pokemon_model.dart';
import 'package:test_ososs/presentation/hom_flow/request/pokemon_list_request.dart';


abstract class DataSourceHome extends  RemoteDataSource {
  Future<Either<BaseError,PokemonModel >> getPokemonList({ PokemonRequest data});
}