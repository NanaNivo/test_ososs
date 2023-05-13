
import 'package:test_ososs/core/error/base_error.dart';
import 'package:test_ososs/core/models/pokemon_model.dart';
import 'package:test_ososs/core/repositories/repository.dart';
import 'package:test_ososs/core/result/result.dart';
import 'package:test_ososs/presentation/hom_flow/request/pokemon_list_request.dart';

abstract class HomeRepository extends Repository {

  Future<Result<BaseError,PokemonModel >> pokemonRepo(
      { PokemonRequest pokemonRequest});

}