import 'package:dartz/dartz.dart';
import 'package:test_ososs/core/enums/api/HttpMethod.dart';
import 'package:test_ososs/core/error/base_error.dart';
import 'package:test_ososs/core/models/pokemon_model.dart';
import 'package:test_ososs/presentation/hom_flow/dataSource/data_source_home.dart';
import 'package:test_ososs/presentation/hom_flow/request/pokemon_list_request.dart';
import 'package:test_ososs/presentation/hom_flow/response/pokemon_list_response_response.dart';



class DataSourceHomeImp extends DataSourceHome
{
  @override
  Future<Either<BaseError, PokemonModel>> getPokemonList({PokemonRequest data}) {
    return request< PokemonModel, PokemonListResponse>(
        responseStr: 'PokemonListResponse',
        mapper: (json) => PokemonListResponse.fromJson(json),
        method: HttpMethod.GET,
        data: data.toJson(),
       // acceptLang: data.language,
        url: "https://pokeapi.co/api/v2/pokemon?limit=10&offset=${data.page}");
  }


}