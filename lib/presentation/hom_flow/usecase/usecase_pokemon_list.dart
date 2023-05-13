
import 'package:test_ososs/core/error/base_error.dart';
import 'package:test_ososs/core/models/pokemon_model.dart';
import 'package:test_ososs/core/param/base_param.dart';
import 'package:test_ososs/core/result/result.dart';
import 'package:test_ososs/core/usecases/base_use_case.dart';
import 'package:test_ososs/presentation/hom_flow/repository/repository_home.dart';
import 'package:test_ososs/presentation/hom_flow/request/pokemon_list_request.dart';
import 'package:test_ososs/presentation/infinite_list_view/entity/pagination_params.dart';
import 'package:test_ososs/presentation/infinite_list_view/entity/usecase_wrapper.dart';


class PokemonListUseCase extends UseCase<Future<Result<BaseError,PokemonModel >>,GetListPokemanParams>
{
  final HomeRepository homeRepository;
  PokemonListUseCase({this.homeRepository});
  @override
  Future<Result<BaseError, PokemonModel>> call(GetListPokemanParams params) async {

    final result=await homeRepository.pokemonRepo(pokemonRequest:PokemonRequest(page:params.page) );
    if (result.hasDataOnly) {

      return Result(data: result.data);
    }
    return Result(error: result.error);
  }
}
// class PokemonParams extends BaseParams
// {
//   PokemonRequest pokemonRequest;
//   PokemonParams({this.pokemonRequest});
// }

class GetListPokemanParams extends BaseParams {
  final int parentId;
  final int page;
  final int pageSize;

  GetListPokemanParams({this.parentId, this.page, this.pageSize});
}

class PokemonListWrapper extends UseCaseWrapper<Results, PaginationParams> {
  final PokemonListUseCase pokemonListUseCase;

  PokemonListWrapper(this.pokemonListUseCase);

  @override
  Future<List<Results>> caller(PaginationParams params) async {
    final   response = await pokemonListUseCase(GetListPokemanParams(page: params.startIndex));
    Result<BaseError, List<Results>> tempRes=Result(error:response.error,data: response.data.results );
    return responseChecker(tempRes);
  }
}

