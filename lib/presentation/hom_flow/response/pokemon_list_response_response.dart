

import 'package:test_ososs/core/models/pokemon_model.dart';
import 'package:test_ososs/core/response/api_response.dart';

class PokemonListResponse extends ApiResponse<PokemonModel>
{
  PokemonListResponse(String msg, bool hasError, result) : super(msg, hasError, result) ;

  factory PokemonListResponse.fromJson(json) {
    print('hi there');
    final error = json['error'];
    bool isError = error != null;
    if(isError) {
      int status = error["status"];
    }

    String message ='';


    PokemonModel model;
    if (!isError) {
      isError = false;
      print('response in Pokemonresponse');
      model = PokemonModel.fromJson(json);

    } else if (isError) {
      print('response in Pokemonresponse error');

      message = error['message'];
      if(error['details']!=null)
      {
        message = '';
        error['details']['errors'].forEach((v) {
          message += ' ${v['message']}\n';
        });
      }
    }

    return PokemonListResponse(message, isError, model);
  }
}