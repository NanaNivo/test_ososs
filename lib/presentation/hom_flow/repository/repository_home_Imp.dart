import 'package:dartz/dartz.dart';
import 'package:test_ososs/core/error/base_error.dart';
import 'package:test_ososs/core/models/pokemon_model.dart';
import 'package:test_ososs/core/result/result.dart';
import 'package:test_ososs/presentation/hom_flow/dataSource/data_source_home.dart';
import 'package:test_ososs/presentation/hom_flow/repository/repository_home.dart';
import 'package:test_ososs/presentation/hom_flow/request/pokemon_list_request.dart';


class HomeRepositoryImp extends  HomeRepository
{
  DataSourceHome dataSourceHome;
  HomeRepositoryImp(this.dataSourceHome);
 // final sessionManager=locator<SessionManager>();




  @override
  Future<Result<BaseError, PokemonModel>> pokemonRepo({PokemonRequest pokemonRequest}) async {
    final res=await dataSourceHome.getPokemonList(data:pokemonRequest );
    // if(res.isRight()) {
    //   final data = (res as Right<BaseError, PokemonModel>).value;
    // //  sessionManager.persistToken(data.token);
    //
    // }
    return executeWithoutConvert(remoteResult: res);
  }


}